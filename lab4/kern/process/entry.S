.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)

    pushl %edx              # push arg 参数入栈
    call *%ebx              # call fn 调用函数

    pushl %eax              # save the return value of fn(arg) 保存函数返回值
    call do_exit            # call do_exit to terminate current thread 完成一些资源回收工作等

