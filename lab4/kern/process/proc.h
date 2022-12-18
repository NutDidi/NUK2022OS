#ifndef __KERN_PROCESS_PROC_H__
#define __KERN_PROCESS_PROC_H__

#include <defs.h>
#include <list.h>
#include <trap.h>
#include <memlayout.h>


// process's state in his life cycle
//进程状态 
enum proc_state {
    PROC_UNINIT = 0,  // uninitialized
    PROC_SLEEPING,    // sleeping
    PROC_RUNNABLE,    // runnable(maybe running)可运行 - 运行或就绪
    PROC_ZOMBIE,      // almost dead, and wait parent proc to reclaim his resource
};

// Saved registers for kernel context switches.
// Don't need to save all the %fs etc. segment registers,
// because they are constant across kernel contexts.
// Save all the regular registers so we don't need to care
// which are caller save, but not the return register %eax.
// (Not saving %eax just simplifies the switching code.)
// The layout of context must match code in switch.S.
//上下文切换所涉及的寄存器
struct context {
    uint32_t eip;//指令寄存器
    uint32_t esp;//栈寄存器
    uint32_t ebx;//基址寄存器
    uint32_t ecx;//计数器
    uint32_t edx;//数据寄存器
    uint32_t esi;//源寄存器
    uint32_t edi;//目标索引寄存器
    uint32_t ebp;//基址指针
};

#define PROC_NAME_LEN               15
#define MAX_PROCESS                 4096
#define MAX_PID                     (MAX_PROCESS * 2)

extern list_entry_t proc_list;//线程链表

//线程控制块
struct proc_struct {
    enum proc_state state;                      // Process state
    int pid;                                    // Process ID
    int runs;                                   // the running times of Proces
    uintptr_t kstack;                           // 内核栈Process kernel stack 2个连续物理页（memlayout.h KSTACKPAGE=2 KSTACKSIZE->内核栈大小）
    volatile bool need_resched;                 // 是否需要调度bool value: need to be rescheduled to release CPU?
    struct proc_struct *parent;                 // the parent process
    struct mm_struct *mm;                       // 进程内存管理 内核线程：null 用户态进程：有   Process's memory management field
    struct context context;                     // 上下文Switch here to run process
    struct trapframe *tf;                       // 中断保存Trap frame for current interrupt
    uintptr_t cr3;                              // 保存页表的物理基地址 方便进程切换 内核态：boot_cr3 用户态：mm->pgdir CR3 register: the base addr of Page Directroy Table(PDT)
    uint32_t flags;                             // Process flag
    char name[PROC_NAME_LEN + 1];               // Process name
    list_entry_t list_link;                     // Process link list
    list_entry_t hash_link;                     // Process hash list
};
//proc = le2proc(le, list_link);
#define le2proc(le, member)         \
    to_struct((le), struct proc_struct, member)
/*
#define to_struct(ptr, type, member)                               \
    (   (type *)  ((char *)  (ptr) - offsetof(type, member)   )  )
*/

extern struct proc_struct *idleproc, *initproc, *current;
//idleproc : 0号内核线程 功能：查询可执行线程
//initproc ： 1号内核线程
//current ： 当前占用CPU且处于“运行”状态进程控制块指针

void proc_init(void);
void proc_run(struct proc_struct *proc);
int kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags);

char *set_proc_name(struct proc_struct *proc, const char *name);
char *get_proc_name(struct proc_struct *proc);
void cpu_idle(void) __attribute__((noreturn));

struct proc_struct *find_proc(int pid);
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf);
int do_exit(int error_code);

#endif /* !__KERN_PROCESS_PROC_H__ */

