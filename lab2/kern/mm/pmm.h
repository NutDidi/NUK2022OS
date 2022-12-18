#ifndef __KERN_MM_PMM_H__
#define __KERN_MM_PMM_H__

#include <defs.h>
#include <mmu.h>
#include <memlayout.h>
#include <atomic.h>
#include <assert.h>

// pmm_manager is a physical memory management class. A special pmm manager - XXX_pmm_manager
// only needs to implement the methods in pmm_manager class, then XXX_pmm_manager can be used
// by ucore to manage the total physical memory space.

//物理内存管理类
struct pmm_manager {
    // XXX_pmm_manager's name管理者名
    const char *name;
    // initialize internal description&management data structure
    //(free block list, number of free block) of XXX_pmm_manager 
    //初始化内部描述和管理数据结构（空闲块链表、空闲块数量）
    //初始化free_area变量 
    void (*init)(void);                                  
    // setup description&management data structcure according to the initial free physical memory space 
    // 根据初始可用物理内存空间设置描述和管理数据结构 
    void (*init_memmap)(struct Page *base, size_t n); 
    // allocate >=n pages, depend on the allocation algorithm
    //分配>=n页，取决于分配算法
    struct Page *(*alloc_pages)(size_t n);             
    // free >=n pages with "base" addr of Page descriptor structures(memlayout.h) 
    //释放>=n页和页面描述符结构基地址                                                 
    void (*free_pages)(struct Page *base, size_t n);  
    // return the number of free pages   
    //返回空闲页数量                                               
    size_t (*nr_free_pages)(void);                     
    // check the correctness of XXX_pmm_manager  
    //检查正确性                                                
    void (*check)(void);                                                                                  
};
/*把内存管理算法实现在
此结构中定义的
init（初始化）、
init_memmap（分析空闲物理内存并初始化管理）、
alloc_pages（分配物理页）、free_pages（释放物理页）
函数指针所对应的函数中。

而其他内存子系统需要与物理内存管理子系统交互时，
只需调用特定物理内存管理子系统所采用的
pmm_manager数据结构变量中的函数指针即可
*/

//物理内存管理者 pmm.cpp
extern const struct pmm_manager *pmm_manager;

//boot(引导)时 页目录虚拟地址
extern pde_t *boot_pgdir;

//boot(引导)时 页目录物理地址
extern uintptr_t boot_cr3;

//设置pmm以管理物理内存，构建PDT和PT以设置分页机制
//检查pmm和分页机制的正确性，打印PDT和PT
void pmm_init(void);

//调用pmm->alloc_pages分配连续的n*PAGESIZE大小内存（创建n个页）
struct Page *alloc_pages(size_t n);
//调用pmm->free_pages释放连续的n*PAGESIZE大小内存（删除n个页）
void free_pages(struct Page *base, size_t n);
//调用pmm->nr_free_pages t以获取当前可用内存n*PAGESIZE（n页）的大小
size_t nr_free_pages(void);


//预定义
#define alloc_page() alloc_pages(1)
#define free_page(page) free_pages(page, 1)

//获取页表项并返回其虚拟地址
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create);

struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store);
//删除页
void page_remove(pde_t *pgdir, uintptr_t la);
//插入页
int page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm);
//加载esp0
void load_esp0(uintptr_t esp0);

void tlb_invalidate(pde_t *pgdir, uintptr_t la);

void print_pgdir(void);
/* *
 * PADDR - takes a kernel virtual address (an address that points above KERNBASE),
 * where the machine's maximum 256MB of physical memory is mapped and returns the
 * corresponding physical address.  It panics if you pass it a non-kernel virtual address.
 * */
/*
PDDR
由虚拟地址得到物理地址
*/
#define PADDR(kva) ({                                                   \
            uintptr_t __m_kva = (uintptr_t)(kva);                       \
            if (__m_kva < KERNBASE) {                                   \
                panic("PADDR called with invalid kva %08lx", __m_kva);  \
            }                                                           \
            __m_kva - KERNBASE;                                         \
        })

/* *
 * KADDR - takes a physical address and returns the corresponding kernel virtual
 * address. It panics if you pass an invalid physical address.
 * */
/*
KADDR
由物理地址返回相应的内核虚拟地址
*/
#define KADDR(pa) ({                                                    \
            uintptr_t __m_pa = (pa);                                    \
            size_t __m_ppn = PPN(__m_pa);                               \
            if (__m_ppn >= npage) {                                     \
                panic("KADDR called with invalid pa %08lx", __m_pa);    \
            }                                                           \
            (void *) (__m_pa + KERNBASE);                               \
        })

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
    return page - pages;
}

static inline uintptr_t
page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
}

static inline struct Page *
pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa)];
}

static inline void *
page2kva(struct Page *page) {
    return KADDR(page2pa(page));
}

static inline struct Page *
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
    if (!(pte & PTE_P)) {
        panic("pte2page called with invalid pte");
    }
    return pa2page(PTE_ADDR(pte));
}

static inline struct Page *
pde2page(pde_t pde) {
    return pa2page(PDE_ADDR(pde));
}

//引用次数
static inline int
page_ref(struct Page *page) {
    return page->ref;
}

static inline void
set_page_ref(struct Page *page, int val) {
    page->ref = val;
}
//加
static inline int
page_ref_inc(struct Page *page) {
    page->ref += 1;
    return page->ref;
}
//减
static inline int
page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}

extern char bootstack[], bootstacktop[];








#endif /* !__KERN_MM_PMM_H__ */

