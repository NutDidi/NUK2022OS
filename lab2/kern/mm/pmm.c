#include <defs.h>
#include <x86.h>
#include <stdio.h>
#include <string.h>
#include <mmu.h>
#include <memlayout.h>
#include <pmm.h>
#include <default_pmm.h>
#include <sync.h>
#include <error.h>

/* *
 * Task State Segment:任务状态段
 *
 * TSS可以驻留在内存中的任何位置
 * 任务寄存器（TR）（一个特殊的段寄存器）
 * 保存一个指向驻留在GDT(全局描述符表)中的一个有效TSS段描述符的段选择器
 * The TSS may reside anywhere in memory. A special segment register called
 * the Task Register (TR) holds a segment selector that points a valid TSS
 * segment descriptor which resides in the GDT. Therefore, to use a TSS
 * the following must be done in function gdt_init:
 *   - create a TSS descriptor entry in GDT
 *   - add enough information to the TSS in memory as needed
 *   - load the TR register with a segment selector for that segment
 *
 * 使用TSS前必须在gdt_init中完成：
 * 1.在GDT中创建TSS描述符条目
 * 2.为内存中的TSS添加足够多的信息
 * 3.用TSS的段选择子加载一个任务寄存器
 * 
 * There are several fileds in TSS for specifying the new stack pointer when a
 * privilege level change happens. But only the fields SS0 and ESP0 are useful
 * in our os kernel.
 *
 * TSS中有几个文件用于在发生特权级别更改时指定新的堆栈指针。
 * 但只有字段SS0和ESP0在我们的操作系统内核中有用。
 * 
 * The field SS0 contains the stack segment selector for CPL = 0, and the ESP0
 * contains the new ESP value for CPL = 0. When an interrupt happens in protected
 * mode, the x86 CPU will look in the TSS for SS0 and ESP0 and load their value
 * into SS and ESP respectively.
 * 
 * CPL=0 内核态
 * SS0包含CPL=0的堆栈段选择器
 * ESP0包含CPL=0的新ESP值。
 * 当在保护模式下发生中断时，x86 CPU将查找SS0和ESP0的TSS，并将其值分别加载到SS和ESP中。
 * 
 * */

//任务状态
static struct taskstate ts = {0};

// virtual address of physicall page array
//物理页组的虚拟地址
struct Page *pages;

// amount of physical memory (in pages)
//（页的）物理内存量
size_t npage = 0;

//virtual address of boot-time page directory
//boot(引导)时 页目录虚拟地址boot_pgdir
extern pde_t __boot_pgdir;
pde_t *boot_pgdir = &__boot_pgdir;

// physical address of boot-time page directory
//boot(引导)时 页目录物理地址 boot_cr3 = boot_pgdir - KERNBASE /PADDR(boot_pgdir) pmm_init
uintptr_t boot_cr3;

// physical memory management
//物理内存管理 pmm_manager
const struct pmm_manager *pmm_manager;

/* *
 * The page directory entry corresponding to the virtual address range
 * [VPT, VPT + PTSIZE) points to the page directory itself. Thus, the page
 * directory is treated as a page table as well as a page directory.
 *
 * One result of treating the page directory as a page table is that all PTEs
 * can be accessed though a "virtual page table" at virtual address VPT. And the
 * PTE for number n is stored in vpt[n].
 *
 * A second consequence is that the contents of the current page directory will
 * always available at virtual address PGADDR(PDX(VPT), PDX(VPT), 0), to which
 * vpd is set bellow.
 * */
//与虚拟地址[VPT，VPT+PTSIZE)对应的页目录条目指向页目录自己
//页目录被视为页表和页目录
//将页目录视为页表，所有PTE(页表条目)就可通过虚拟地址VPT处的“虚拟页表”访问
//编号n的PTE存储在vpt[n]中。 


pte_t * const vpt = (pte_t *)VPT;//虚拟页表
pde_t * const vpd = (pde_t *)PGADDR(PDX(VPT), PDX(VPT), 0);//虚拟页目录：虚拟页表的页目录索引的物理地址

/* *
 * Global Descriptor Table:
 *
 * The kernel and user segments are identical (except for the DPL). To load
 * the %ss register, the CPL must equal the DPL. Thus, we must duplicate the
 * segments for the user and the kernel. Defined as follows:
 *   - 0x0 :  unused (always faults -- for trapping NULL far pointers)
 *   - 0x8 :  kernel code segment
 *   - 0x10:  kernel data segment
 *   - 0x18:  user code segment
 *   - 0x20:  user data segment
 *   - 0x28:  defined for tss, initialized in gdt_init
 * */
//全局描述符表
static struct segdesc gdt[] = {
    SEG_NULL,
    [SEG_KTEXT] = SEG(STA_X | STA_R, 0x0, 0xFFFFFFFF, DPL_KERNEL),
    [SEG_KDATA] = SEG(STA_W, 0x0, 0xFFFFFFFF, DPL_KERNEL),
    [SEG_UTEXT] = SEG(STA_X | STA_R, 0x0, 0xFFFFFFFF, DPL_USER),
    [SEG_UDATA] = SEG(STA_W, 0x0, 0xFFFFFFFF, DPL_USER),
    [SEG_TSS]   = SEG_NULL,
};

static struct pseudodesc gdt_pd = {
    sizeof(gdt) - 1, (uintptr_t)gdt
};

//检查
static void check_alloc_page(void);
static void check_pgdir(void);
static void check_boot_pgdir(void);

/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
//加载全局描述符表  重置内核的数据、代码段寄存器
static inline void
lgdt(struct pseudodesc *pd) {
    asm volatile ("lgdt (%0)" :: "r" (pd));
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
}

/* *
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
//更改默认任务状态段中的ESP0
//以便在将帧用户捕获到内核时使用不同的内核堆栈
void
load_esp0(uintptr_t esp0) {
    ts.ts_esp0 = esp0;
}

/* gdt_init - initialize the default GDT and TSS */
//初始化默认全局描述符表和任务状态段
static void
gdt_init(void) {
    // set boot kernel stack and default SS0
    //设置boot（引导）内核堆栈和默认SS0
    load_esp0((uintptr_t)bootstacktop);
    ts.ts_ss0 = KERNEL_DS;//内核代码段  SS0:包含CPL=0的堆栈段选择器

    // initialize the TSS filed of the gdt
    //初始化gdt的TSS字段 STS_T32A：空闲的32位TSS 
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);

    // reload all segment registers
    //重新加载所有段寄存器
    lgdt(&gdt_pd);

    // load the TSS
    //加载TSS
    ltr(GD_TSS);
}



//init_pmm_manager - initialize a pmm_manager instance
//初始化物理内存管理器示例
static void
init_pmm_manager(void) {
    pmm_manager = &default_pmm_manager;//from default_pmm.cpp
    cprintf("memory management: %s\n", pmm_manager->name);//输出名字
    pmm_manager->init(); //  default_init
}

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
//初始化内存映射   调用pmm->init_memmap（pmm.h/24  default_pmm.c/107 ）为空闲内存构建页面结构
static void
init_memmap(struct Page *base, size_t n) {
    pmm_manager->init_memmap(base, n);
}

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
//调用pmm->alloc_pages分配连续的n*PAGESIZE大小内存（分配n个页）
struct Page *
alloc_pages(size_t n) {
    struct Page *page=NULL;
    bool intr_flag;
    //开关中断
    local_intr_save(intr_flag);//关中断
    {
        //临界区代码
        page = pmm_manager->alloc_pages(n); //分配n个连续页 de falut_pmm.c/128
    }
    local_intr_restore(intr_flag);//开中断
    return page;
}

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
//调用pmm->free_pages释放连续的n*PAGESIZE大小内存 de falut_pmm.c/157
void
free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
    }
    local_intr_restore(intr_flag);
}

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) of current free memory
//调用pmm->nr_free_pages t以获取当前可用内存nr*PAGESIZE（n页）的大小  de falut_pmm.c/188
size_t
nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
    }
    local_intr_restore(intr_flag);
    return ret;
}

/* pmm_init - initialize the physical memory management */
//初始化物理内存管理
static void
page_init(void) {
    /*
    		INT 0x15/AX=E820H又称为Query System Address Map,名为查询系统地址映射关系。
            上电之后，BIOS根据获取到的内存信息以及其他地址配置信息, 
            通过向该中断将物理内存映射地址描述信息写入到该中断，
            当BIOS将权限传递给内核后，将会由内核通过读取到该中断信息，
            并对信息进行筛检做进一步管理。

    */
   //memlayout.h
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);//e820地址 虚拟地址
    uint64_t maxpa = 0;

    cprintf("e820map:\n");
    int i;
    //遍历e820中所有的内存块 输出信息
    for (i = 0; i < memmap->nr_map; i ++) {
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        //   address range memory？？？
        //确定物理内存边界,即映射至RAM最大物理地址 可用的
        if (memmap->map[i].type == E820_ARM) {
            if (maxpa < end && begin < KMEMSIZE) {
                maxpa = end;
            }
        }
    }
    //不能超过最大的物理内存
    if (maxpa > KMEMSIZE) {
        maxpa = KMEMSIZE;
    }

    extern char end[];//end BSS段的结束地址
    //页数
    npage = maxpa / PGSIZE;
    //end按页大小为边界取整后，作为管理页级物理内存空间所需的Page结构的内存空间
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);

    //设全部置占用标记
    for (i = 0; i < npage; i ++) {
        SetPageReserved(pages + i);
    }
    /*
    地址0到pages+ sizeof(struct Page) * npage)结束的物理内存空间
    设定为已占用物理内存空间（起始0~640KB的空间是空闲的）
    
    地址pages+ sizeof(struct Page) * npage)以上的空间为空闲物理内存空间，
    这时的空闲空间起始地址为freemem
    */

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
    //扩充
    for (i = 0; i < memmap->nr_map; i ++) {
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
        if (memmap->map[i].type == E820_ARM) {
            if (begin < freemem) {
                begin = freemem;
            }
            if (end > KMEMSIZE) {
                end = KMEMSIZE;
            }
            if (begin < end) {
                begin = ROUNDUP(begin, PGSIZE);
                end = ROUNDDOWN(end, PGSIZE);
                if (begin < end) {
                    //根据探测到的空闲物理空间，实现空闲标记：
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
                }
            }
        }
    }
}

//boot_map_segment - setup&enable the paging mechanism 设置并启用分页机制
// parameters
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  权限
//boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
static void boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
    assert(PGOFF(la) == PGOFF(pa));
    //页数
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
    //页地址
    la = ROUNDDOWN(la, PGSIZE);
    pa = ROUNDDOWN(pa, PGSIZE);
    //获取每页的PTE
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
        pte_t *ptep = get_pte(pgdir, la, 1);//返回页表项虚拟地址
        assert(ptep != NULL);
        *ptep = pa | PTE_P | perm;
    }
}

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
    struct Page *p = alloc_page();
    if (p == NULL) {
        panic("boot_alloc_page failed.\n");
    }
    return page2kva(p);
}

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
    // We've already enabled paging
    boot_cr3 = PADDR(boot_pgdir);//boot(引导)时 页目录虚拟地址boot_pgdir

    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();

    check_pgdir();

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;  
    //递归地将boot_pgdir插入其自身以在虚拟地址VPT处形成虚拟页表 

    // map all physical memory to linear memory with base linear addr KERNBASE
    // linear_addr KERNBASE ~ KERNBASE + KMEMSIZE = phy_addr 0 ~ KMEMSIZE
    // 映射
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);

    // Since we are using bootloader's GDT,
    // we should reload gdt (second time, the last time) to get user segments and the TSS
    // map virtual_addr 0 ~ 4G = linear_addr 0 ~ 4G
    // then set kernel stack (ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();

    print_pgdir();

}

//get_pte - get pte and return the kernel virtual address of this pte for la
//          获取页表项并返回其虚拟地址
//        - if the PT contians this pte didn't exist, alloc a page for PT
//          如果该页表项不存在，创建一个页
// parameter:
//  pgdir:  the kernel virtual base address of PDT 虚拟基地址 
//  la:     the linear address need to map 线性地址
//  create: a logical value to decide if alloc a page for PT 是否创建页
// return vaule: the kernel virtual address of this pte 返回页表项虚拟地址
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
    /* LAB2 EXERCISE 2: YOUR CODE
     *
     * If you need to visit a physical address, please use KADDR()
     * please read pmm.h for useful macros
     *
     * Maybe you want help comment, BELOW comments can help you finish the code
     *
     * Some Useful MACROs and DEFINEs, you can use them in below implementation.
     * MACROs or Functions:
     *   PDX(la) = the index of page directory entry of VIRTUAL ADDRESS la.
     *   虚拟地址la的页目录条目的索引
     *   KADDR(pa) : takes a physical address and returns the corresponding kernel virtual address.
     *   接收一个物理地址并返回相应的内核虚拟地址
     *   set_page_ref(page,1) : means the page be referenced by one time
     *   表示该页被引用一次
     *   page2pa(page): get the physical address of memory which this (struct Page *) page  manages
     *   获取(struct Page *)page所管理的内存的物理地址。
     *   struct Page * alloc_page() : allocation a page
     *   分配一个页面
     *   memset(void *s, char c, size_t n) : sets the first n bytes of the memory area pointed by s
     *                                       to the specified value c.
     *   将s所指向的内存区域的前n个字节设置为指定的值c。
     * DEFINEs:
     *   PTE_P           0x001                   // page table/directory entry flags bit : Present
     *   页表/页目录条目标志位：位1，表示物理内存页存在。
     *   PTE_W           0x002                   // page table/directory entry flags bit : Writeable
     *   页表/页目录条目标志位：位2，表示物理内存页内容可写。
     *   PTE_U           0x004                   // page table/directory entry flags bit : User can access
     *   页表/页目录条目标志位：位3，表示用户态的软件可以读取对应地址的物理内存页内容。
     */
/*
---------------------modify--------------------------
*/
// #if 0
//     pde_t *pdep = NULL;   // (1) find page directory entry
//     if (0) {              // (2) check if entry is not present
//                           // (3) check if creating is needed, then alloc page for page table
//                           // CAUTION: this page is used for page table, not for common data page
//                           // (4) set page reference
//         uintptr_t pa = 0; // (5) get linear address of page
//                           // (6) clear page content using memset
//                           // (7) set page directory entry's permission
//     }
//     return NULL;          // (8) return page table entry
// #endif 0
    pde_t *pdep = &pgdir[PDX(la)];                   // (1) find page directory entry 
    
    if (!(*pdep & PTE_P))            // (2) check if entry is not present
    { 
        struct Page *page;
        if (create)                                  // (3) check if creating is needed, then alloc page for page table
        {
            page = alloc_page();
            if (alloc_page()!= NULL)
            {
                set_page_ref(page,1);                // (4) set page reference
            }
            else{
            	return NULL;
            }
            uintptr_t pa = page2pa(page);            // (5) get physical address of page
        memset(KADDR(pa), 0, PGSIZE);                // (6) clear page content using memset
        *pdep = pa | PTE_U | PTE_W | PTE_P;          // (7) set page directory entry's permission               
        }   
        else{
        	return NULL;
        }  
    }
    return  &( (pte_t *)KADDR ( PDE_ADDR(*pdep) ) )[PTX(la)];         // (8) return page table entry

}

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
    pte_t *ptep = get_pte(pgdir, la, 0);
    if (ptep_store != NULL) {
        *ptep_store = ptep;
    }
    if (ptep != NULL && *ptep & PTE_P) {
        return pte2page(*ptep);
    }
    return NULL;
}

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
    /* LAB2 EXERCISE 3: YOUR CODE
     *
     * Please check if ptep is valid, and tlb must be manually updated if mapping is updated
     *
     * Maybe you want help comment, BELOW comments can help you finish the code
     *
     * Some Useful MACROs and DEFINEs, you can use them in below implementation.
     * MACROs or Functions:
     *   struct Page *page pte2page(*ptep): get the according page from the value of a ptep
     *   free_page : free a page
     *   page_ref_dec(page) : decrease page->ref. NOTICE: ff page->ref == 0 , then this page should be free.
     *   tlb_invalidate(pde_t *pgdir, uintptr_t la) : Invalidate a TLB entry, but only if the page tables being
     *                        edited are the ones currently in use by the processor.
     * DEFINEs:
     *   PTE_P           0x001                   // page table/directory entry flags bit : Present
     */
/*
#if 0
    if (0) {                      //(1) check if this page table entry is present
        struct Page *page = NULL; //(2) find corresponding page to pte
                                  //(3) decrease page reference
                                  //(4) and free this page when page reference reachs 0
                                  //(5) clear second page table entry
                                  //(6) flush tlb
    }
#endif
*/

    if (*ptep & PTE_P) { //check if this page table entry is present，如果传入的页表条目是可用的
        struct Page *page = pte2page(*ptep); //find corresponding page to pte，获取该页表项所对应的地址 
        if (page_ref_dec(page) == 0) //decrease page reference，如果该页的引用次数在减1后为0
            free_page(page); //and free this page when page reference reachs 0，释放当前页
        *ptep = 0; //clear second page table entry，清空PTE
        tlb_invalidate(pgdir, la); //flush tlb，刷新TLB内的数据
    }


}

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
    pte_t *ptep = get_pte(pgdir, la, 0);
    if (ptep != NULL) {
        page_remove_pte(pgdir, la, ptep);
    }
}

//page_insert - build the map of phy addr of an Page with the linear addr la
// paramemters:
//  pgdir: the kernel virtual base address of PDT
//  page:  the Page which need to map
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
    pte_t *ptep = get_pte(pgdir, la, 1);
    if (ptep == NULL) {
        return -E_NO_MEM;
    }
    page_ref_inc(page);
    if (*ptep & PTE_P) {
        struct Page *p = pte2page(*ptep);
        if (p == page) {
            page_ref_dec(page);
        }
        else {
            page_remove_pte(pgdir, la, ptep);
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
    tlb_invalidate(pgdir, la);
    return 0;
}

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
//使TLB条目无效，但仅当正在编辑的页表是处理器当前使用的页表时
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
    if (rcr3() == PADDR(pgdir)) {
        invlpg((void *)la);
    }
}

static void
check_alloc_page(void) {
    pmm_manager->check();
    cprintf("check_alloc_page() succeeded!\n");
}

static void
check_pgdir(void) {
    assert(npage <= KMEMSIZE / PGSIZE);
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
    assert(pte2page(*ptep) == p1);
    assert(page_ref(p1) == 1);

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);

    p2 = alloc_page();
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
    assert(*ptep & PTE_U);
    assert(*ptep & PTE_W);
    assert(boot_pgdir[0] & PTE_U);
    assert(page_ref(p2) == 1);

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
    assert(page_ref(p1) == 2);
    assert(page_ref(p2) == 0);
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
    assert(pte2page(*ptep) == p1);
    assert((*ptep & PTE_U) == 0);

    page_remove(boot_pgdir, 0x0);
    assert(page_ref(p1) == 1);
    assert(page_ref(p2) == 0);

    page_remove(boot_pgdir, PGSIZE);
    assert(page_ref(p1) == 0);
    assert(page_ref(p2) == 0);

    assert(page_ref(pde2page(boot_pgdir[0])) == 1);
    free_page(pde2page(boot_pgdir[0]));
    boot_pgdir[0] = 0;

    cprintf("check_pgdir() succeeded!\n");
}

static void
check_boot_pgdir(void) {
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));

    assert(boot_pgdir[0] == 0);

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
    assert(page_ref(p) == 1);
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
    assert(page_ref(p) == 2);

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);

    *(char *)(page2kva(p) + 0x100) = '\0';
    assert(strlen((const char *)0x100) == 0);

    free_page(p);
    free_page(pde2page(boot_pgdir[0]));
    boot_pgdir[0] = 0;

    cprintf("check_boot_pgdir() succeeded!\n");
}

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
    str[1] = 'r';
    str[2] = (perm & PTE_W) ? 'w' : '-';
    str[3] = '\0';
    return str;
}

//get_pgtable_items - In [left, right] range of PDT or PT, find a continuous linear addr space
//                  - (left_store*X_SIZE~right_store*X_SIZE) for PDT or PT
//                  - X_SIZE=PTSIZE=4M, if PDT; X_SIZE=PGSIZE=4K, if PT
// paramemters:
//  left:        no use ???
//  right:       the high side of table's range
//  start:       the low side of table's range
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
    if (start >= right) {
        return 0;
    }
    while (start < right && !(table[start] & PTE_P)) {
        start ++;
    }
    if (start < right) {
        if (left_store != NULL) {
            *left_store = start;
        }
        int perm = (table[start ++] & PTE_USER);
        while (start < right && (table[start] & PTE_USER) == perm) {
            start ++;
        }
        if (right_store != NULL) {
            *right_store = start;
        }
        return perm;
    }
    return 0;
}

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
    cprintf("-------------------- BEGIN --------------------\n");
    size_t left, right = 0, perm;
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
        size_t l, r = left * NPTEENTRY;
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
        }
    }
    cprintf("--------------------- END ---------------------\n");
}


