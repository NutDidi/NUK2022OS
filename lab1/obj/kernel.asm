
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	b8 08 0d 11 00       	mov    $0x110d08,%eax
  10000b:	2d 16 fa 10 00       	sub    $0x10fa16,%eax
  100010:	89 44 24 08          	mov    %eax,0x8(%esp)
  100014:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001b:	00 
  10001c:	c7 04 24 16 fa 10 00 	movl   $0x10fa16,(%esp)
  100023:	e8 ee 34 00 00       	call   103516 <memset>

    cons_init();                // init the console
  100028:	e8 e1 15 00 00       	call   10160e <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10002d:	c7 45 f4 c0 36 10 00 	movl   $0x1036c0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100034:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100037:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003b:	c7 04 24 dc 36 10 00 	movl   $0x1036dc,(%esp)
  100042:	e8 e9 02 00 00       	call   100330 <cprintf>

    print_kerninfo();
  100047:	e8 07 08 00 00       	call   100853 <print_kerninfo>

    grade_backtrace();
  10004c:	e8 95 00 00 00       	call   1000e6 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100051:	e8 17 2b 00 00       	call   102b6d <pmm_init>

    pic_init();                 // init interrupt controller
  100056:	e8 0e 17 00 00       	call   101769 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005b:	e8 72 18 00 00       	call   1018d2 <idt_init>

    clock_init();               // init clock interrupt
  100060:	e8 4a 0d 00 00       	call   100daf <clock_init>
    intr_enable();              // enable irq interrupt
  100065:	e8 5d 16 00 00       	call   1016c7 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006a:	e8 76 01 00 00       	call   1001e5 <lab1_switch_test>

    /* do nothing */
    while (1);
  10006f:	eb fe                	jmp    10006f <kern_init+0x6f>

00100071 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100071:	55                   	push   %ebp
  100072:	89 e5                	mov    %esp,%ebp
  100074:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  100077:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10007e:	00 
  10007f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100086:	00 
  100087:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10008e:	e8 37 0c 00 00       	call   100cca <mon_backtrace>
}
  100093:	90                   	nop
  100094:	89 ec                	mov    %ebp,%esp
  100096:	5d                   	pop    %ebp
  100097:	c3                   	ret    

00100098 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100098:	55                   	push   %ebp
  100099:	89 e5                	mov    %esp,%ebp
  10009b:	83 ec 18             	sub    $0x18,%esp
  10009e:	89 5d fc             	mov    %ebx,-0x4(%ebp)
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a1:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000a7:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000aa:	8b 45 08             	mov    0x8(%ebp),%eax
  1000ad:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1000b1:	89 54 24 08          	mov    %edx,0x8(%esp)
  1000b5:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1000b9:	89 04 24             	mov    %eax,(%esp)
  1000bc:	e8 b0 ff ff ff       	call   100071 <grade_backtrace2>
}
  1000c1:	90                   	nop
  1000c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000c5:	89 ec                	mov    %ebp,%esp
  1000c7:	5d                   	pop    %ebp
  1000c8:	c3                   	ret    

001000c9 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c9:	55                   	push   %ebp
  1000ca:	89 e5                	mov    %esp,%ebp
  1000cc:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000cf:	8b 45 10             	mov    0x10(%ebp),%eax
  1000d2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d9:	89 04 24             	mov    %eax,(%esp)
  1000dc:	e8 b7 ff ff ff       	call   100098 <grade_backtrace1>
}
  1000e1:	90                   	nop
  1000e2:	89 ec                	mov    %ebp,%esp
  1000e4:	5d                   	pop    %ebp
  1000e5:	c3                   	ret    

001000e6 <grade_backtrace>:

void
grade_backtrace(void) {
  1000e6:	55                   	push   %ebp
  1000e7:	89 e5                	mov    %esp,%ebp
  1000e9:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000ec:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000f1:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000f8:	ff 
  1000f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100104:	e8 c0 ff ff ff       	call   1000c9 <grade_backtrace0>
}
  100109:	90                   	nop
  10010a:	89 ec                	mov    %ebp,%esp
  10010c:	5d                   	pop    %ebp
  10010d:	c3                   	ret    

0010010e <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  10010e:	55                   	push   %ebp
  10010f:	89 e5                	mov    %esp,%ebp
  100111:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100114:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100117:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10011a:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10011d:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100120:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100124:	83 e0 03             	and    $0x3,%eax
  100127:	89 c2                	mov    %eax,%edx
  100129:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10012e:	89 54 24 08          	mov    %edx,0x8(%esp)
  100132:	89 44 24 04          	mov    %eax,0x4(%esp)
  100136:	c7 04 24 e1 36 10 00 	movl   $0x1036e1,(%esp)
  10013d:	e8 ee 01 00 00       	call   100330 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100142:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100146:	89 c2                	mov    %eax,%edx
  100148:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10014d:	89 54 24 08          	mov    %edx,0x8(%esp)
  100151:	89 44 24 04          	mov    %eax,0x4(%esp)
  100155:	c7 04 24 ef 36 10 00 	movl   $0x1036ef,(%esp)
  10015c:	e8 cf 01 00 00       	call   100330 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100161:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100165:	89 c2                	mov    %eax,%edx
  100167:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10016c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100170:	89 44 24 04          	mov    %eax,0x4(%esp)
  100174:	c7 04 24 fd 36 10 00 	movl   $0x1036fd,(%esp)
  10017b:	e8 b0 01 00 00       	call   100330 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  100180:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100184:	89 c2                	mov    %eax,%edx
  100186:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10018b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10018f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100193:	c7 04 24 0b 37 10 00 	movl   $0x10370b,(%esp)
  10019a:	e8 91 01 00 00       	call   100330 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  10019f:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001a3:	89 c2                	mov    %eax,%edx
  1001a5:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001aa:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001ae:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001b2:	c7 04 24 19 37 10 00 	movl   $0x103719,(%esp)
  1001b9:	e8 72 01 00 00       	call   100330 <cprintf>
    round ++;
  1001be:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001c3:	40                   	inc    %eax
  1001c4:	a3 20 fa 10 00       	mov    %eax,0x10fa20
}
  1001c9:	90                   	nop
  1001ca:	89 ec                	mov    %ebp,%esp
  1001cc:	5d                   	pop    %ebp
  1001cd:	c3                   	ret    

001001ce <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001ce:	55                   	push   %ebp
  1001cf:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
    asm volatile(
  1001d1:	83 ec 08             	sub    $0x8,%esp
  1001d4:	cd 78                	int    $0x78
  1001d6:	89 ec                	mov    %ebp,%esp
    "int %0 \n"                    //中断
    "movl %%ebp,%%esp"             //恢复栈指针
    :
    :"i"(T_SWITCH_TOU)             //中断号
    );
}
  1001d8:	90                   	nop
  1001d9:	5d                   	pop    %ebp
  1001da:	c3                   	ret    

001001db <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001db:	55                   	push   %ebp
  1001dc:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
    asm volatile (
  1001de:	cd 79                	int    $0x79
  1001e0:	89 ec                	mov    %ebp,%esp
     "int %0 \n"
     "movl %%ebp, %%esp \n"
     :
     : "i"(T_SWITCH_TOK)
     );
}
  1001e2:	90                   	nop
  1001e3:	5d                   	pop    %ebp
  1001e4:	c3                   	ret    

001001e5 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001e5:	55                   	push   %ebp
  1001e6:	89 e5                	mov    %esp,%ebp
  1001e8:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001eb:	e8 1e ff ff ff       	call   10010e <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001f0:	c7 04 24 28 37 10 00 	movl   $0x103728,(%esp)
  1001f7:	e8 34 01 00 00       	call   100330 <cprintf>
    lab1_switch_to_user();
  1001fc:	e8 cd ff ff ff       	call   1001ce <lab1_switch_to_user>
    lab1_print_cur_status();
  100201:	e8 08 ff ff ff       	call   10010e <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100206:	c7 04 24 48 37 10 00 	movl   $0x103748,(%esp)
  10020d:	e8 1e 01 00 00       	call   100330 <cprintf>
    lab1_switch_to_kernel();
  100212:	e8 c4 ff ff ff       	call   1001db <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100217:	e8 f2 fe ff ff       	call   10010e <lab1_print_cur_status>
}
  10021c:	90                   	nop
  10021d:	89 ec                	mov    %ebp,%esp
  10021f:	5d                   	pop    %ebp
  100220:	c3                   	ret    

00100221 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100221:	55                   	push   %ebp
  100222:	89 e5                	mov    %esp,%ebp
  100224:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100227:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10022b:	74 13                	je     100240 <readline+0x1f>
        cprintf("%s", prompt);
  10022d:	8b 45 08             	mov    0x8(%ebp),%eax
  100230:	89 44 24 04          	mov    %eax,0x4(%esp)
  100234:	c7 04 24 67 37 10 00 	movl   $0x103767,(%esp)
  10023b:	e8 f0 00 00 00       	call   100330 <cprintf>
    }
    int i = 0, c;
  100240:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100247:	e8 73 01 00 00       	call   1003bf <getchar>
  10024c:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10024f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100253:	79 07                	jns    10025c <readline+0x3b>
            return NULL;
  100255:	b8 00 00 00 00       	mov    $0x0,%eax
  10025a:	eb 78                	jmp    1002d4 <readline+0xb3>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10025c:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100260:	7e 28                	jle    10028a <readline+0x69>
  100262:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100269:	7f 1f                	jg     10028a <readline+0x69>
            cputchar(c);
  10026b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10026e:	89 04 24             	mov    %eax,(%esp)
  100271:	e8 e2 00 00 00       	call   100358 <cputchar>
            buf[i ++] = c;
  100276:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100279:	8d 50 01             	lea    0x1(%eax),%edx
  10027c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  10027f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100282:	88 90 40 fa 10 00    	mov    %dl,0x10fa40(%eax)
  100288:	eb 45                	jmp    1002cf <readline+0xae>
        }
        else if (c == '\b' && i > 0) {
  10028a:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  10028e:	75 16                	jne    1002a6 <readline+0x85>
  100290:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100294:	7e 10                	jle    1002a6 <readline+0x85>
            cputchar(c);
  100296:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100299:	89 04 24             	mov    %eax,(%esp)
  10029c:	e8 b7 00 00 00       	call   100358 <cputchar>
            i --;
  1002a1:	ff 4d f4             	decl   -0xc(%ebp)
  1002a4:	eb 29                	jmp    1002cf <readline+0xae>
        }
        else if (c == '\n' || c == '\r') {
  1002a6:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1002aa:	74 06                	je     1002b2 <readline+0x91>
  1002ac:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1002b0:	75 95                	jne    100247 <readline+0x26>
            cputchar(c);
  1002b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002b5:	89 04 24             	mov    %eax,(%esp)
  1002b8:	e8 9b 00 00 00       	call   100358 <cputchar>
            buf[i] = '\0';
  1002bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1002c0:	05 40 fa 10 00       	add    $0x10fa40,%eax
  1002c5:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1002c8:	b8 40 fa 10 00       	mov    $0x10fa40,%eax
  1002cd:	eb 05                	jmp    1002d4 <readline+0xb3>
        c = getchar();
  1002cf:	e9 73 ff ff ff       	jmp    100247 <readline+0x26>
        }
    }
}
  1002d4:	89 ec                	mov    %ebp,%esp
  1002d6:	5d                   	pop    %ebp
  1002d7:	c3                   	ret    

001002d8 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002d8:	55                   	push   %ebp
  1002d9:	89 e5                	mov    %esp,%ebp
  1002db:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002de:	8b 45 08             	mov    0x8(%ebp),%eax
  1002e1:	89 04 24             	mov    %eax,(%esp)
  1002e4:	e8 54 13 00 00       	call   10163d <cons_putc>
    (*cnt) ++;
  1002e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002ec:	8b 00                	mov    (%eax),%eax
  1002ee:	8d 50 01             	lea    0x1(%eax),%edx
  1002f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002f4:	89 10                	mov    %edx,(%eax)
}
  1002f6:	90                   	nop
  1002f7:	89 ec                	mov    %ebp,%esp
  1002f9:	5d                   	pop    %ebp
  1002fa:	c3                   	ret    

001002fb <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002fb:	55                   	push   %ebp
  1002fc:	89 e5                	mov    %esp,%ebp
  1002fe:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100301:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100308:	8b 45 0c             	mov    0xc(%ebp),%eax
  10030b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10030f:	8b 45 08             	mov    0x8(%ebp),%eax
  100312:	89 44 24 08          	mov    %eax,0x8(%esp)
  100316:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100319:	89 44 24 04          	mov    %eax,0x4(%esp)
  10031d:	c7 04 24 d8 02 10 00 	movl   $0x1002d8,(%esp)
  100324:	e8 18 2a 00 00       	call   102d41 <vprintfmt>
    return cnt;
  100329:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10032c:	89 ec                	mov    %ebp,%esp
  10032e:	5d                   	pop    %ebp
  10032f:	c3                   	ret    

00100330 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100330:	55                   	push   %ebp
  100331:	89 e5                	mov    %esp,%ebp
  100333:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100336:	8d 45 0c             	lea    0xc(%ebp),%eax
  100339:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10033c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10033f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100343:	8b 45 08             	mov    0x8(%ebp),%eax
  100346:	89 04 24             	mov    %eax,(%esp)
  100349:	e8 ad ff ff ff       	call   1002fb <vcprintf>
  10034e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100351:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100354:	89 ec                	mov    %ebp,%esp
  100356:	5d                   	pop    %ebp
  100357:	c3                   	ret    

00100358 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100358:	55                   	push   %ebp
  100359:	89 e5                	mov    %esp,%ebp
  10035b:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10035e:	8b 45 08             	mov    0x8(%ebp),%eax
  100361:	89 04 24             	mov    %eax,(%esp)
  100364:	e8 d4 12 00 00       	call   10163d <cons_putc>
}
  100369:	90                   	nop
  10036a:	89 ec                	mov    %ebp,%esp
  10036c:	5d                   	pop    %ebp
  10036d:	c3                   	ret    

0010036e <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10036e:	55                   	push   %ebp
  10036f:	89 e5                	mov    %esp,%ebp
  100371:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100374:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  10037b:	eb 13                	jmp    100390 <cputs+0x22>
        cputch(c, &cnt);
  10037d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  100381:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100384:	89 54 24 04          	mov    %edx,0x4(%esp)
  100388:	89 04 24             	mov    %eax,(%esp)
  10038b:	e8 48 ff ff ff       	call   1002d8 <cputch>
    while ((c = *str ++) != '\0') {
  100390:	8b 45 08             	mov    0x8(%ebp),%eax
  100393:	8d 50 01             	lea    0x1(%eax),%edx
  100396:	89 55 08             	mov    %edx,0x8(%ebp)
  100399:	0f b6 00             	movzbl (%eax),%eax
  10039c:	88 45 f7             	mov    %al,-0x9(%ebp)
  10039f:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1003a3:	75 d8                	jne    10037d <cputs+0xf>
    }
    cputch('\n', &cnt);
  1003a5:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1003a8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1003ac:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1003b3:	e8 20 ff ff ff       	call   1002d8 <cputch>
    return cnt;
  1003b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003bb:	89 ec                	mov    %ebp,%esp
  1003bd:	5d                   	pop    %ebp
  1003be:	c3                   	ret    

001003bf <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003bf:	55                   	push   %ebp
  1003c0:	89 e5                	mov    %esp,%ebp
  1003c2:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1003c5:	90                   	nop
  1003c6:	e8 9e 12 00 00       	call   101669 <cons_getc>
  1003cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003d2:	74 f2                	je     1003c6 <getchar+0x7>
        /* do nothing */;
    return c;
  1003d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003d7:	89 ec                	mov    %ebp,%esp
  1003d9:	5d                   	pop    %ebp
  1003da:	c3                   	ret    

001003db <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1003db:	55                   	push   %ebp
  1003dc:	89 e5                	mov    %esp,%ebp
  1003de:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1003e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003e4:	8b 00                	mov    (%eax),%eax
  1003e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003e9:	8b 45 10             	mov    0x10(%ebp),%eax
  1003ec:	8b 00                	mov    (%eax),%eax
  1003ee:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1003f8:	e9 ca 00 00 00       	jmp    1004c7 <stab_binsearch+0xec>
        int true_m = (l + r) / 2, m = true_m;
  1003fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100400:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100403:	01 d0                	add    %edx,%eax
  100405:	89 c2                	mov    %eax,%edx
  100407:	c1 ea 1f             	shr    $0x1f,%edx
  10040a:	01 d0                	add    %edx,%eax
  10040c:	d1 f8                	sar    %eax
  10040e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100411:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100414:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100417:	eb 03                	jmp    10041c <stab_binsearch+0x41>
            m --;
  100419:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  10041c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10041f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100422:	7c 1f                	jl     100443 <stab_binsearch+0x68>
  100424:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100427:	89 d0                	mov    %edx,%eax
  100429:	01 c0                	add    %eax,%eax
  10042b:	01 d0                	add    %edx,%eax
  10042d:	c1 e0 02             	shl    $0x2,%eax
  100430:	89 c2                	mov    %eax,%edx
  100432:	8b 45 08             	mov    0x8(%ebp),%eax
  100435:	01 d0                	add    %edx,%eax
  100437:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10043b:	0f b6 c0             	movzbl %al,%eax
  10043e:	39 45 14             	cmp    %eax,0x14(%ebp)
  100441:	75 d6                	jne    100419 <stab_binsearch+0x3e>
        }
        if (m < l) {    // no match in [l, m]
  100443:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100446:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100449:	7d 09                	jge    100454 <stab_binsearch+0x79>
            l = true_m + 1;
  10044b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10044e:	40                   	inc    %eax
  10044f:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100452:	eb 73                	jmp    1004c7 <stab_binsearch+0xec>
        }

        // actual binary search
        any_matches = 1;
  100454:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10045b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10045e:	89 d0                	mov    %edx,%eax
  100460:	01 c0                	add    %eax,%eax
  100462:	01 d0                	add    %edx,%eax
  100464:	c1 e0 02             	shl    $0x2,%eax
  100467:	89 c2                	mov    %eax,%edx
  100469:	8b 45 08             	mov    0x8(%ebp),%eax
  10046c:	01 d0                	add    %edx,%eax
  10046e:	8b 40 08             	mov    0x8(%eax),%eax
  100471:	39 45 18             	cmp    %eax,0x18(%ebp)
  100474:	76 11                	jbe    100487 <stab_binsearch+0xac>
            *region_left = m;
  100476:	8b 45 0c             	mov    0xc(%ebp),%eax
  100479:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10047c:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10047e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100481:	40                   	inc    %eax
  100482:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100485:	eb 40                	jmp    1004c7 <stab_binsearch+0xec>
        } else if (stabs[m].n_value > addr) {
  100487:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10048a:	89 d0                	mov    %edx,%eax
  10048c:	01 c0                	add    %eax,%eax
  10048e:	01 d0                	add    %edx,%eax
  100490:	c1 e0 02             	shl    $0x2,%eax
  100493:	89 c2                	mov    %eax,%edx
  100495:	8b 45 08             	mov    0x8(%ebp),%eax
  100498:	01 d0                	add    %edx,%eax
  10049a:	8b 40 08             	mov    0x8(%eax),%eax
  10049d:	39 45 18             	cmp    %eax,0x18(%ebp)
  1004a0:	73 14                	jae    1004b6 <stab_binsearch+0xdb>
            *region_right = m - 1;
  1004a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004a5:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004a8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004ab:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1004ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004b0:	48                   	dec    %eax
  1004b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004b4:	eb 11                	jmp    1004c7 <stab_binsearch+0xec>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1004b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004b9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004bc:	89 10                	mov    %edx,(%eax)
            l = m;
  1004be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1004c4:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  1004c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004ca:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1004cd:	0f 8e 2a ff ff ff    	jle    1003fd <stab_binsearch+0x22>
        }
    }

    if (!any_matches) {
  1004d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004d7:	75 0f                	jne    1004e8 <stab_binsearch+0x10d>
        *region_right = *region_left - 1;
  1004d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004dc:	8b 00                	mov    (%eax),%eax
  1004de:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004e1:	8b 45 10             	mov    0x10(%ebp),%eax
  1004e4:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1004e6:	eb 3e                	jmp    100526 <stab_binsearch+0x14b>
        l = *region_right;
  1004e8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004eb:	8b 00                	mov    (%eax),%eax
  1004ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1004f0:	eb 03                	jmp    1004f5 <stab_binsearch+0x11a>
  1004f2:	ff 4d fc             	decl   -0x4(%ebp)
  1004f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004f8:	8b 00                	mov    (%eax),%eax
  1004fa:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1004fd:	7e 1f                	jle    10051e <stab_binsearch+0x143>
  1004ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100502:	89 d0                	mov    %edx,%eax
  100504:	01 c0                	add    %eax,%eax
  100506:	01 d0                	add    %edx,%eax
  100508:	c1 e0 02             	shl    $0x2,%eax
  10050b:	89 c2                	mov    %eax,%edx
  10050d:	8b 45 08             	mov    0x8(%ebp),%eax
  100510:	01 d0                	add    %edx,%eax
  100512:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100516:	0f b6 c0             	movzbl %al,%eax
  100519:	39 45 14             	cmp    %eax,0x14(%ebp)
  10051c:	75 d4                	jne    1004f2 <stab_binsearch+0x117>
        *region_left = l;
  10051e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100521:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100524:	89 10                	mov    %edx,(%eax)
}
  100526:	90                   	nop
  100527:	89 ec                	mov    %ebp,%esp
  100529:	5d                   	pop    %ebp
  10052a:	c3                   	ret    

0010052b <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  10052b:	55                   	push   %ebp
  10052c:	89 e5                	mov    %esp,%ebp
  10052e:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100531:	8b 45 0c             	mov    0xc(%ebp),%eax
  100534:	c7 00 6c 37 10 00    	movl   $0x10376c,(%eax)
    info->eip_line = 0;
  10053a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10053d:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100544:	8b 45 0c             	mov    0xc(%ebp),%eax
  100547:	c7 40 08 6c 37 10 00 	movl   $0x10376c,0x8(%eax)
    info->eip_fn_namelen = 9;
  10054e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100551:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100558:	8b 45 0c             	mov    0xc(%ebp),%eax
  10055b:	8b 55 08             	mov    0x8(%ebp),%edx
  10055e:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100561:	8b 45 0c             	mov    0xc(%ebp),%eax
  100564:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  10056b:	c7 45 f4 2c 40 10 00 	movl   $0x10402c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100572:	c7 45 f0 c4 bf 10 00 	movl   $0x10bfc4,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100579:	c7 45 ec c5 bf 10 00 	movl   $0x10bfc5,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100580:	c7 45 e8 3c e9 10 00 	movl   $0x10e93c,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100587:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10058a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10058d:	76 0b                	jbe    10059a <debuginfo_eip+0x6f>
  10058f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100592:	48                   	dec    %eax
  100593:	0f b6 00             	movzbl (%eax),%eax
  100596:	84 c0                	test   %al,%al
  100598:	74 0a                	je     1005a4 <debuginfo_eip+0x79>
        return -1;
  10059a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10059f:	e9 ab 02 00 00       	jmp    10084f <debuginfo_eip+0x324>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1005a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1005ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005ae:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1005b1:	c1 f8 02             	sar    $0x2,%eax
  1005b4:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1005ba:	48                   	dec    %eax
  1005bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1005be:	8b 45 08             	mov    0x8(%ebp),%eax
  1005c1:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005c5:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1005cc:	00 
  1005cd:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1005d0:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1005d7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1005db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005de:	89 04 24             	mov    %eax,(%esp)
  1005e1:	e8 f5 fd ff ff       	call   1003db <stab_binsearch>
    if (lfile == 0)
  1005e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005e9:	85 c0                	test   %eax,%eax
  1005eb:	75 0a                	jne    1005f7 <debuginfo_eip+0xcc>
        return -1;
  1005ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005f2:	e9 58 02 00 00       	jmp    10084f <debuginfo_eip+0x324>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1005f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005fa:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1005fd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100600:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  100603:	8b 45 08             	mov    0x8(%ebp),%eax
  100606:	89 44 24 10          	mov    %eax,0x10(%esp)
  10060a:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100611:	00 
  100612:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100615:	89 44 24 08          	mov    %eax,0x8(%esp)
  100619:	8d 45 dc             	lea    -0x24(%ebp),%eax
  10061c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100620:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100623:	89 04 24             	mov    %eax,(%esp)
  100626:	e8 b0 fd ff ff       	call   1003db <stab_binsearch>

    if (lfun <= rfun) {
  10062b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10062e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100631:	39 c2                	cmp    %eax,%edx
  100633:	7f 78                	jg     1006ad <debuginfo_eip+0x182>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100635:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100638:	89 c2                	mov    %eax,%edx
  10063a:	89 d0                	mov    %edx,%eax
  10063c:	01 c0                	add    %eax,%eax
  10063e:	01 d0                	add    %edx,%eax
  100640:	c1 e0 02             	shl    $0x2,%eax
  100643:	89 c2                	mov    %eax,%edx
  100645:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100648:	01 d0                	add    %edx,%eax
  10064a:	8b 10                	mov    (%eax),%edx
  10064c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10064f:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100652:	39 c2                	cmp    %eax,%edx
  100654:	73 22                	jae    100678 <debuginfo_eip+0x14d>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100656:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100659:	89 c2                	mov    %eax,%edx
  10065b:	89 d0                	mov    %edx,%eax
  10065d:	01 c0                	add    %eax,%eax
  10065f:	01 d0                	add    %edx,%eax
  100661:	c1 e0 02             	shl    $0x2,%eax
  100664:	89 c2                	mov    %eax,%edx
  100666:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100669:	01 d0                	add    %edx,%eax
  10066b:	8b 10                	mov    (%eax),%edx
  10066d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100670:	01 c2                	add    %eax,%edx
  100672:	8b 45 0c             	mov    0xc(%ebp),%eax
  100675:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100678:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10067b:	89 c2                	mov    %eax,%edx
  10067d:	89 d0                	mov    %edx,%eax
  10067f:	01 c0                	add    %eax,%eax
  100681:	01 d0                	add    %edx,%eax
  100683:	c1 e0 02             	shl    $0x2,%eax
  100686:	89 c2                	mov    %eax,%edx
  100688:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10068b:	01 d0                	add    %edx,%eax
  10068d:	8b 50 08             	mov    0x8(%eax),%edx
  100690:	8b 45 0c             	mov    0xc(%ebp),%eax
  100693:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100696:	8b 45 0c             	mov    0xc(%ebp),%eax
  100699:	8b 40 10             	mov    0x10(%eax),%eax
  10069c:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10069f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006a2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1006a5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1006ab:	eb 15                	jmp    1006c2 <debuginfo_eip+0x197>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1006ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006b0:	8b 55 08             	mov    0x8(%ebp),%edx
  1006b3:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1006b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1006bc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006bf:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1006c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006c5:	8b 40 08             	mov    0x8(%eax),%eax
  1006c8:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1006cf:	00 
  1006d0:	89 04 24             	mov    %eax,(%esp)
  1006d3:	e8 b6 2c 00 00       	call   10338e <strfind>
  1006d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  1006db:	8b 4a 08             	mov    0x8(%edx),%ecx
  1006de:	29 c8                	sub    %ecx,%eax
  1006e0:	89 c2                	mov    %eax,%edx
  1006e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006e5:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1006e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1006eb:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006ef:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1006f6:	00 
  1006f7:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1006fa:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006fe:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100701:	89 44 24 04          	mov    %eax,0x4(%esp)
  100705:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100708:	89 04 24             	mov    %eax,(%esp)
  10070b:	e8 cb fc ff ff       	call   1003db <stab_binsearch>
    if (lline <= rline) {
  100710:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100713:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100716:	39 c2                	cmp    %eax,%edx
  100718:	7f 23                	jg     10073d <debuginfo_eip+0x212>
        info->eip_line = stabs[rline].n_desc;
  10071a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10071d:	89 c2                	mov    %eax,%edx
  10071f:	89 d0                	mov    %edx,%eax
  100721:	01 c0                	add    %eax,%eax
  100723:	01 d0                	add    %edx,%eax
  100725:	c1 e0 02             	shl    $0x2,%eax
  100728:	89 c2                	mov    %eax,%edx
  10072a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10072d:	01 d0                	add    %edx,%eax
  10072f:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100733:	89 c2                	mov    %eax,%edx
  100735:	8b 45 0c             	mov    0xc(%ebp),%eax
  100738:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10073b:	eb 11                	jmp    10074e <debuginfo_eip+0x223>
        return -1;
  10073d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100742:	e9 08 01 00 00       	jmp    10084f <debuginfo_eip+0x324>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100747:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10074a:	48                   	dec    %eax
  10074b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10074e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100751:	8b 45 e4             	mov    -0x1c(%ebp),%eax
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100754:	39 c2                	cmp    %eax,%edx
  100756:	7c 56                	jl     1007ae <debuginfo_eip+0x283>
           && stabs[lline].n_type != N_SOL
  100758:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10075b:	89 c2                	mov    %eax,%edx
  10075d:	89 d0                	mov    %edx,%eax
  10075f:	01 c0                	add    %eax,%eax
  100761:	01 d0                	add    %edx,%eax
  100763:	c1 e0 02             	shl    $0x2,%eax
  100766:	89 c2                	mov    %eax,%edx
  100768:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10076b:	01 d0                	add    %edx,%eax
  10076d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100771:	3c 84                	cmp    $0x84,%al
  100773:	74 39                	je     1007ae <debuginfo_eip+0x283>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100775:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100778:	89 c2                	mov    %eax,%edx
  10077a:	89 d0                	mov    %edx,%eax
  10077c:	01 c0                	add    %eax,%eax
  10077e:	01 d0                	add    %edx,%eax
  100780:	c1 e0 02             	shl    $0x2,%eax
  100783:	89 c2                	mov    %eax,%edx
  100785:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100788:	01 d0                	add    %edx,%eax
  10078a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10078e:	3c 64                	cmp    $0x64,%al
  100790:	75 b5                	jne    100747 <debuginfo_eip+0x21c>
  100792:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100795:	89 c2                	mov    %eax,%edx
  100797:	89 d0                	mov    %edx,%eax
  100799:	01 c0                	add    %eax,%eax
  10079b:	01 d0                	add    %edx,%eax
  10079d:	c1 e0 02             	shl    $0x2,%eax
  1007a0:	89 c2                	mov    %eax,%edx
  1007a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007a5:	01 d0                	add    %edx,%eax
  1007a7:	8b 40 08             	mov    0x8(%eax),%eax
  1007aa:	85 c0                	test   %eax,%eax
  1007ac:	74 99                	je     100747 <debuginfo_eip+0x21c>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1007ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b4:	39 c2                	cmp    %eax,%edx
  1007b6:	7c 42                	jl     1007fa <debuginfo_eip+0x2cf>
  1007b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007bb:	89 c2                	mov    %eax,%edx
  1007bd:	89 d0                	mov    %edx,%eax
  1007bf:	01 c0                	add    %eax,%eax
  1007c1:	01 d0                	add    %edx,%eax
  1007c3:	c1 e0 02             	shl    $0x2,%eax
  1007c6:	89 c2                	mov    %eax,%edx
  1007c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007cb:	01 d0                	add    %edx,%eax
  1007cd:	8b 10                	mov    (%eax),%edx
  1007cf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1007d2:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1007d5:	39 c2                	cmp    %eax,%edx
  1007d7:	73 21                	jae    1007fa <debuginfo_eip+0x2cf>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1007d9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007dc:	89 c2                	mov    %eax,%edx
  1007de:	89 d0                	mov    %edx,%eax
  1007e0:	01 c0                	add    %eax,%eax
  1007e2:	01 d0                	add    %edx,%eax
  1007e4:	c1 e0 02             	shl    $0x2,%eax
  1007e7:	89 c2                	mov    %eax,%edx
  1007e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007ec:	01 d0                	add    %edx,%eax
  1007ee:	8b 10                	mov    (%eax),%edx
  1007f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007f3:	01 c2                	add    %eax,%edx
  1007f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007f8:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1007fa:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1007fd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100800:	39 c2                	cmp    %eax,%edx
  100802:	7d 46                	jge    10084a <debuginfo_eip+0x31f>
        for (lline = lfun + 1;
  100804:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100807:	40                   	inc    %eax
  100808:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  10080b:	eb 16                	jmp    100823 <debuginfo_eip+0x2f8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  10080d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100810:	8b 40 14             	mov    0x14(%eax),%eax
  100813:	8d 50 01             	lea    0x1(%eax),%edx
  100816:	8b 45 0c             	mov    0xc(%ebp),%eax
  100819:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  10081c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10081f:	40                   	inc    %eax
  100820:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100823:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100826:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100829:	39 c2                	cmp    %eax,%edx
  10082b:	7d 1d                	jge    10084a <debuginfo_eip+0x31f>
  10082d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100830:	89 c2                	mov    %eax,%edx
  100832:	89 d0                	mov    %edx,%eax
  100834:	01 c0                	add    %eax,%eax
  100836:	01 d0                	add    %edx,%eax
  100838:	c1 e0 02             	shl    $0x2,%eax
  10083b:	89 c2                	mov    %eax,%edx
  10083d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100840:	01 d0                	add    %edx,%eax
  100842:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100846:	3c a0                	cmp    $0xa0,%al
  100848:	74 c3                	je     10080d <debuginfo_eip+0x2e2>
        }
    }
    return 0;
  10084a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10084f:	89 ec                	mov    %ebp,%esp
  100851:	5d                   	pop    %ebp
  100852:	c3                   	ret    

00100853 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100853:	55                   	push   %ebp
  100854:	89 e5                	mov    %esp,%ebp
  100856:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100859:	c7 04 24 76 37 10 00 	movl   $0x103776,(%esp)
  100860:	e8 cb fa ff ff       	call   100330 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100865:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10086c:	00 
  10086d:	c7 04 24 8f 37 10 00 	movl   $0x10378f,(%esp)
  100874:	e8 b7 fa ff ff       	call   100330 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100879:	c7 44 24 04 a2 36 10 	movl   $0x1036a2,0x4(%esp)
  100880:	00 
  100881:	c7 04 24 a7 37 10 00 	movl   $0x1037a7,(%esp)
  100888:	e8 a3 fa ff ff       	call   100330 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  10088d:	c7 44 24 04 16 fa 10 	movl   $0x10fa16,0x4(%esp)
  100894:	00 
  100895:	c7 04 24 bf 37 10 00 	movl   $0x1037bf,(%esp)
  10089c:	e8 8f fa ff ff       	call   100330 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1008a1:	c7 44 24 04 08 0d 11 	movl   $0x110d08,0x4(%esp)
  1008a8:	00 
  1008a9:	c7 04 24 d7 37 10 00 	movl   $0x1037d7,(%esp)
  1008b0:	e8 7b fa ff ff       	call   100330 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1008b5:	b8 08 0d 11 00       	mov    $0x110d08,%eax
  1008ba:	2d 00 00 10 00       	sub    $0x100000,%eax
  1008bf:	05 ff 03 00 00       	add    $0x3ff,%eax
  1008c4:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008ca:	85 c0                	test   %eax,%eax
  1008cc:	0f 48 c2             	cmovs  %edx,%eax
  1008cf:	c1 f8 0a             	sar    $0xa,%eax
  1008d2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008d6:	c7 04 24 f0 37 10 00 	movl   $0x1037f0,(%esp)
  1008dd:	e8 4e fa ff ff       	call   100330 <cprintf>
}
  1008e2:	90                   	nop
  1008e3:	89 ec                	mov    %ebp,%esp
  1008e5:	5d                   	pop    %ebp
  1008e6:	c3                   	ret    

001008e7 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1008e7:	55                   	push   %ebp
  1008e8:	89 e5                	mov    %esp,%ebp
  1008ea:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1008f0:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1008f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008f7:	8b 45 08             	mov    0x8(%ebp),%eax
  1008fa:	89 04 24             	mov    %eax,(%esp)
  1008fd:	e8 29 fc ff ff       	call   10052b <debuginfo_eip>
  100902:	85 c0                	test   %eax,%eax
  100904:	74 15                	je     10091b <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100906:	8b 45 08             	mov    0x8(%ebp),%eax
  100909:	89 44 24 04          	mov    %eax,0x4(%esp)
  10090d:	c7 04 24 1a 38 10 00 	movl   $0x10381a,(%esp)
  100914:	e8 17 fa ff ff       	call   100330 <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100919:	eb 6c                	jmp    100987 <print_debuginfo+0xa0>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  10091b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100922:	eb 1b                	jmp    10093f <print_debuginfo+0x58>
            fnname[j] = info.eip_fn_name[j];
  100924:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100927:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10092a:	01 d0                	add    %edx,%eax
  10092c:	0f b6 10             	movzbl (%eax),%edx
  10092f:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100935:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100938:	01 c8                	add    %ecx,%eax
  10093a:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  10093c:	ff 45 f4             	incl   -0xc(%ebp)
  10093f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100942:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100945:	7c dd                	jl     100924 <print_debuginfo+0x3d>
        fnname[j] = '\0';
  100947:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  10094d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100950:	01 d0                	add    %edx,%eax
  100952:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100955:	8b 55 ec             	mov    -0x14(%ebp),%edx
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100958:	8b 45 08             	mov    0x8(%ebp),%eax
  10095b:	29 d0                	sub    %edx,%eax
  10095d:	89 c1                	mov    %eax,%ecx
  10095f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100962:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100965:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100969:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  10096f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100973:	89 54 24 08          	mov    %edx,0x8(%esp)
  100977:	89 44 24 04          	mov    %eax,0x4(%esp)
  10097b:	c7 04 24 36 38 10 00 	movl   $0x103836,(%esp)
  100982:	e8 a9 f9 ff ff       	call   100330 <cprintf>
}
  100987:	90                   	nop
  100988:	89 ec                	mov    %ebp,%esp
  10098a:	5d                   	pop    %ebp
  10098b:	c3                   	ret    

0010098c <read_eip>:

static __noinline uint32_t
read_eip(void) {
  10098c:	55                   	push   %ebp
  10098d:	89 e5                	mov    %esp,%ebp
  10098f:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100992:	8b 45 04             	mov    0x4(%ebp),%eax
  100995:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100998:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10099b:	89 ec                	mov    %ebp,%esp
  10099d:	5d                   	pop    %ebp
  10099e:	c3                   	ret    

0010099f <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  10099f:	55                   	push   %ebp
  1009a0:	89 e5                	mov    %esp,%ebp
  1009a2:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  1009a5:	89 e8                	mov    %ebp,%eax
  1009a7:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  1009aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
      
	uint32_t ebp = read_ebp();
  1009ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip = read_eip();
  1009b0:	e8 d7 ff ff ff       	call   10098c <read_eip>
  1009b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	for(int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
  1009b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  1009bf:	e9 ad 00 00 00       	jmp    100a71 <print_stackframe+0xd2>
	{
		cprintf("ebp:0x%08x eip:0x%08x" , ebp, eip);
  1009c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1009c7:	89 44 24 08          	mov    %eax,0x8(%esp)
  1009cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009ce:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009d2:	c7 04 24 48 38 10 00 	movl   $0x103848,(%esp)
  1009d9:	e8 52 f9 ff ff       	call   100330 <cprintf>
		uint32_t *arguments = (uint32_t *)ebp + 2;
  1009de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009e1:	83 c0 08             	add    $0x8,%eax
  1009e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		for (int j = 0; j < 4; j++)
  1009e7:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  1009ee:	eb 4d                	jmp    100a3d <print_stackframe+0x9e>
		{
			if (j == 0) cprintf(" args:0x%08x" , arguments[j]);
  1009f0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1009f4:	75 23                	jne    100a19 <print_stackframe+0x7a>
  1009f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009f9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100a00:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100a03:	01 d0                	add    %edx,%eax
  100a05:	8b 00                	mov    (%eax),%eax
  100a07:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a0b:	c7 04 24 5e 38 10 00 	movl   $0x10385e,(%esp)
  100a12:	e8 19 f9 ff ff       	call   100330 <cprintf>
  100a17:	eb 21                	jmp    100a3a <print_stackframe+0x9b>
			else cprintf(" 0x%08x" , arguments[j]);
  100a19:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a1c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100a23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100a26:	01 d0                	add    %edx,%eax
  100a28:	8b 00                	mov    (%eax),%eax
  100a2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a2e:	c7 04 24 6b 38 10 00 	movl   $0x10386b,(%esp)
  100a35:	e8 f6 f8 ff ff       	call   100330 <cprintf>
		for (int j = 0; j < 4; j++)
  100a3a:	ff 45 e8             	incl   -0x18(%ebp)
  100a3d:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100a41:	7e ad                	jle    1009f0 <print_stackframe+0x51>
		}
		cprintf("\n");
  100a43:	c7 04 24 73 38 10 00 	movl   $0x103873,(%esp)
  100a4a:	e8 e1 f8 ff ff       	call   100330 <cprintf>
		print_debuginfo(eip-1);
  100a4f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a52:	48                   	dec    %eax
  100a53:	89 04 24             	mov    %eax,(%esp)
  100a56:	e8 8c fe ff ff       	call   1008e7 <print_debuginfo>
		eip = ((uint32_t *)ebp)[1];
  100a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a5e:	83 c0 04             	add    $0x4,%eax
  100a61:	8b 00                	mov    (%eax),%eax
  100a63:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp = ((uint32_t *)ebp)[0];
  100a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a69:	8b 00                	mov    (%eax),%eax
  100a6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for(int i = 0; i < STACKFRAME_DEPTH && ebp != 0; i++)
  100a6e:	ff 45 ec             	incl   -0x14(%ebp)
  100a71:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100a75:	7f 0a                	jg     100a81 <print_stackframe+0xe2>
  100a77:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100a7b:	0f 85 43 ff ff ff    	jne    1009c4 <print_stackframe+0x25>
	}
}
  100a81:	90                   	nop
  100a82:	89 ec                	mov    %ebp,%esp
  100a84:	5d                   	pop    %ebp
  100a85:	c3                   	ret    

00100a86 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100a86:	55                   	push   %ebp
  100a87:	89 e5                	mov    %esp,%ebp
  100a89:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100a8c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a93:	eb 0c                	jmp    100aa1 <parse+0x1b>
            *buf ++ = '\0';
  100a95:	8b 45 08             	mov    0x8(%ebp),%eax
  100a98:	8d 50 01             	lea    0x1(%eax),%edx
  100a9b:	89 55 08             	mov    %edx,0x8(%ebp)
  100a9e:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  100aa4:	0f b6 00             	movzbl (%eax),%eax
  100aa7:	84 c0                	test   %al,%al
  100aa9:	74 1d                	je     100ac8 <parse+0x42>
  100aab:	8b 45 08             	mov    0x8(%ebp),%eax
  100aae:	0f b6 00             	movzbl (%eax),%eax
  100ab1:	0f be c0             	movsbl %al,%eax
  100ab4:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ab8:	c7 04 24 f8 38 10 00 	movl   $0x1038f8,(%esp)
  100abf:	e8 96 28 00 00       	call   10335a <strchr>
  100ac4:	85 c0                	test   %eax,%eax
  100ac6:	75 cd                	jne    100a95 <parse+0xf>
        }
        if (*buf == '\0') {
  100ac8:	8b 45 08             	mov    0x8(%ebp),%eax
  100acb:	0f b6 00             	movzbl (%eax),%eax
  100ace:	84 c0                	test   %al,%al
  100ad0:	74 65                	je     100b37 <parse+0xb1>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100ad2:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100ad6:	75 14                	jne    100aec <parse+0x66>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100ad8:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100adf:	00 
  100ae0:	c7 04 24 fd 38 10 00 	movl   $0x1038fd,(%esp)
  100ae7:	e8 44 f8 ff ff       	call   100330 <cprintf>
        }
        argv[argc ++] = buf;
  100aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aef:	8d 50 01             	lea    0x1(%eax),%edx
  100af2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100af5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100afc:	8b 45 0c             	mov    0xc(%ebp),%eax
  100aff:	01 c2                	add    %eax,%edx
  100b01:	8b 45 08             	mov    0x8(%ebp),%eax
  100b04:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b06:	eb 03                	jmp    100b0b <parse+0x85>
            buf ++;
  100b08:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  100b0e:	0f b6 00             	movzbl (%eax),%eax
  100b11:	84 c0                	test   %al,%al
  100b13:	74 8c                	je     100aa1 <parse+0x1b>
  100b15:	8b 45 08             	mov    0x8(%ebp),%eax
  100b18:	0f b6 00             	movzbl (%eax),%eax
  100b1b:	0f be c0             	movsbl %al,%eax
  100b1e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b22:	c7 04 24 f8 38 10 00 	movl   $0x1038f8,(%esp)
  100b29:	e8 2c 28 00 00       	call   10335a <strchr>
  100b2e:	85 c0                	test   %eax,%eax
  100b30:	74 d6                	je     100b08 <parse+0x82>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b32:	e9 6a ff ff ff       	jmp    100aa1 <parse+0x1b>
            break;
  100b37:	90                   	nop
        }
    }
    return argc;
  100b38:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100b3b:	89 ec                	mov    %ebp,%esp
  100b3d:	5d                   	pop    %ebp
  100b3e:	c3                   	ret    

00100b3f <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100b3f:	55                   	push   %ebp
  100b40:	89 e5                	mov    %esp,%ebp
  100b42:	83 ec 68             	sub    $0x68,%esp
  100b45:	89 5d fc             	mov    %ebx,-0x4(%ebp)
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100b48:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100b4b:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  100b52:	89 04 24             	mov    %eax,(%esp)
  100b55:	e8 2c ff ff ff       	call   100a86 <parse>
  100b5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100b5d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100b61:	75 0a                	jne    100b6d <runcmd+0x2e>
        return 0;
  100b63:	b8 00 00 00 00       	mov    $0x0,%eax
  100b68:	e9 83 00 00 00       	jmp    100bf0 <runcmd+0xb1>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b6d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b74:	eb 5a                	jmp    100bd0 <runcmd+0x91>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100b76:	8b 55 b0             	mov    -0x50(%ebp),%edx
  100b79:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  100b7c:	89 c8                	mov    %ecx,%eax
  100b7e:	01 c0                	add    %eax,%eax
  100b80:	01 c8                	add    %ecx,%eax
  100b82:	c1 e0 02             	shl    $0x2,%eax
  100b85:	05 00 f0 10 00       	add    $0x10f000,%eax
  100b8a:	8b 00                	mov    (%eax),%eax
  100b8c:	89 54 24 04          	mov    %edx,0x4(%esp)
  100b90:	89 04 24             	mov    %eax,(%esp)
  100b93:	e8 26 27 00 00       	call   1032be <strcmp>
  100b98:	85 c0                	test   %eax,%eax
  100b9a:	75 31                	jne    100bcd <runcmd+0x8e>
            return commands[i].func(argc - 1, argv + 1, tf);
  100b9c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b9f:	89 d0                	mov    %edx,%eax
  100ba1:	01 c0                	add    %eax,%eax
  100ba3:	01 d0                	add    %edx,%eax
  100ba5:	c1 e0 02             	shl    $0x2,%eax
  100ba8:	05 08 f0 10 00       	add    $0x10f008,%eax
  100bad:	8b 10                	mov    (%eax),%edx
  100baf:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100bb2:	83 c0 04             	add    $0x4,%eax
  100bb5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100bb8:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100bbb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100bbe:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100bc2:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bc6:	89 1c 24             	mov    %ebx,(%esp)
  100bc9:	ff d2                	call   *%edx
  100bcb:	eb 23                	jmp    100bf0 <runcmd+0xb1>
    for (i = 0; i < NCOMMANDS; i ++) {
  100bcd:	ff 45 f4             	incl   -0xc(%ebp)
  100bd0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bd3:	83 f8 02             	cmp    $0x2,%eax
  100bd6:	76 9e                	jbe    100b76 <runcmd+0x37>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100bd8:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100bdb:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bdf:	c7 04 24 1b 39 10 00 	movl   $0x10391b,(%esp)
  100be6:	e8 45 f7 ff ff       	call   100330 <cprintf>
    return 0;
  100beb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100bf0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100bf3:	89 ec                	mov    %ebp,%esp
  100bf5:	5d                   	pop    %ebp
  100bf6:	c3                   	ret    

00100bf7 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100bf7:	55                   	push   %ebp
  100bf8:	89 e5                	mov    %esp,%ebp
  100bfa:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100bfd:	c7 04 24 34 39 10 00 	movl   $0x103934,(%esp)
  100c04:	e8 27 f7 ff ff       	call   100330 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100c09:	c7 04 24 5c 39 10 00 	movl   $0x10395c,(%esp)
  100c10:	e8 1b f7 ff ff       	call   100330 <cprintf>

    if (tf != NULL) {
  100c15:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100c19:	74 0b                	je     100c26 <kmonitor+0x2f>
        print_trapframe(tf);
  100c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  100c1e:	89 04 24             	mov    %eax,(%esp)
  100c21:	e8 66 0e 00 00       	call   101a8c <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100c26:	c7 04 24 81 39 10 00 	movl   $0x103981,(%esp)
  100c2d:	e8 ef f5 ff ff       	call   100221 <readline>
  100c32:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c35:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c39:	74 eb                	je     100c26 <kmonitor+0x2f>
            if (runcmd(buf, tf) < 0) {
  100c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  100c3e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c45:	89 04 24             	mov    %eax,(%esp)
  100c48:	e8 f2 fe ff ff       	call   100b3f <runcmd>
  100c4d:	85 c0                	test   %eax,%eax
  100c4f:	78 02                	js     100c53 <kmonitor+0x5c>
        if ((buf = readline("K> ")) != NULL) {
  100c51:	eb d3                	jmp    100c26 <kmonitor+0x2f>
                break;
  100c53:	90                   	nop
            }
        }
    }
}
  100c54:	90                   	nop
  100c55:	89 ec                	mov    %ebp,%esp
  100c57:	5d                   	pop    %ebp
  100c58:	c3                   	ret    

00100c59 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100c59:	55                   	push   %ebp
  100c5a:	89 e5                	mov    %esp,%ebp
  100c5c:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c66:	eb 3d                	jmp    100ca5 <mon_help+0x4c>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100c68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c6b:	89 d0                	mov    %edx,%eax
  100c6d:	01 c0                	add    %eax,%eax
  100c6f:	01 d0                	add    %edx,%eax
  100c71:	c1 e0 02             	shl    $0x2,%eax
  100c74:	05 04 f0 10 00       	add    $0x10f004,%eax
  100c79:	8b 10                	mov    (%eax),%edx
  100c7b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  100c7e:	89 c8                	mov    %ecx,%eax
  100c80:	01 c0                	add    %eax,%eax
  100c82:	01 c8                	add    %ecx,%eax
  100c84:	c1 e0 02             	shl    $0x2,%eax
  100c87:	05 00 f0 10 00       	add    $0x10f000,%eax
  100c8c:	8b 00                	mov    (%eax),%eax
  100c8e:	89 54 24 08          	mov    %edx,0x8(%esp)
  100c92:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c96:	c7 04 24 85 39 10 00 	movl   $0x103985,(%esp)
  100c9d:	e8 8e f6 ff ff       	call   100330 <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100ca2:	ff 45 f4             	incl   -0xc(%ebp)
  100ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ca8:	83 f8 02             	cmp    $0x2,%eax
  100cab:	76 bb                	jbe    100c68 <mon_help+0xf>
    }
    return 0;
  100cad:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cb2:	89 ec                	mov    %ebp,%esp
  100cb4:	5d                   	pop    %ebp
  100cb5:	c3                   	ret    

00100cb6 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100cb6:	55                   	push   %ebp
  100cb7:	89 e5                	mov    %esp,%ebp
  100cb9:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100cbc:	e8 92 fb ff ff       	call   100853 <print_kerninfo>
    return 0;
  100cc1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cc6:	89 ec                	mov    %ebp,%esp
  100cc8:	5d                   	pop    %ebp
  100cc9:	c3                   	ret    

00100cca <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100cca:	55                   	push   %ebp
  100ccb:	89 e5                	mov    %esp,%ebp
  100ccd:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100cd0:	e8 ca fc ff ff       	call   10099f <print_stackframe>
    return 0;
  100cd5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cda:	89 ec                	mov    %ebp,%esp
  100cdc:	5d                   	pop    %ebp
  100cdd:	c3                   	ret    

00100cde <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100cde:	55                   	push   %ebp
  100cdf:	89 e5                	mov    %esp,%ebp
  100ce1:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100ce4:	a1 40 fe 10 00       	mov    0x10fe40,%eax
  100ce9:	85 c0                	test   %eax,%eax
  100ceb:	75 5b                	jne    100d48 <__panic+0x6a>
        goto panic_dead;
    }
    is_panic = 1;
  100ced:	c7 05 40 fe 10 00 01 	movl   $0x1,0x10fe40
  100cf4:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100cf7:	8d 45 14             	lea    0x14(%ebp),%eax
  100cfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100cfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d00:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d04:	8b 45 08             	mov    0x8(%ebp),%eax
  100d07:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d0b:	c7 04 24 8e 39 10 00 	movl   $0x10398e,(%esp)
  100d12:	e8 19 f6 ff ff       	call   100330 <cprintf>
    vcprintf(fmt, ap);
  100d17:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d1a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d1e:	8b 45 10             	mov    0x10(%ebp),%eax
  100d21:	89 04 24             	mov    %eax,(%esp)
  100d24:	e8 d2 f5 ff ff       	call   1002fb <vcprintf>
    cprintf("\n");
  100d29:	c7 04 24 aa 39 10 00 	movl   $0x1039aa,(%esp)
  100d30:	e8 fb f5 ff ff       	call   100330 <cprintf>
    
    cprintf("stack trackback:\n");
  100d35:	c7 04 24 ac 39 10 00 	movl   $0x1039ac,(%esp)
  100d3c:	e8 ef f5 ff ff       	call   100330 <cprintf>
    print_stackframe();
  100d41:	e8 59 fc ff ff       	call   10099f <print_stackframe>
  100d46:	eb 01                	jmp    100d49 <__panic+0x6b>
        goto panic_dead;
  100d48:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  100d49:	e8 81 09 00 00       	call   1016cf <intr_disable>
    while (1) {
        kmonitor(NULL);
  100d4e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100d55:	e8 9d fe ff ff       	call   100bf7 <kmonitor>
  100d5a:	eb f2                	jmp    100d4e <__panic+0x70>

00100d5c <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100d5c:	55                   	push   %ebp
  100d5d:	89 e5                	mov    %esp,%ebp
  100d5f:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100d62:	8d 45 14             	lea    0x14(%ebp),%eax
  100d65:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100d68:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d6b:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d6f:	8b 45 08             	mov    0x8(%ebp),%eax
  100d72:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d76:	c7 04 24 be 39 10 00 	movl   $0x1039be,(%esp)
  100d7d:	e8 ae f5 ff ff       	call   100330 <cprintf>
    vcprintf(fmt, ap);
  100d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d85:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d89:	8b 45 10             	mov    0x10(%ebp),%eax
  100d8c:	89 04 24             	mov    %eax,(%esp)
  100d8f:	e8 67 f5 ff ff       	call   1002fb <vcprintf>
    cprintf("\n");
  100d94:	c7 04 24 aa 39 10 00 	movl   $0x1039aa,(%esp)
  100d9b:	e8 90 f5 ff ff       	call   100330 <cprintf>
    va_end(ap);
}
  100da0:	90                   	nop
  100da1:	89 ec                	mov    %ebp,%esp
  100da3:	5d                   	pop    %ebp
  100da4:	c3                   	ret    

00100da5 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100da5:	55                   	push   %ebp
  100da6:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100da8:	a1 40 fe 10 00       	mov    0x10fe40,%eax
}
  100dad:	5d                   	pop    %ebp
  100dae:	c3                   	ret    

00100daf <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100daf:	55                   	push   %ebp
  100db0:	89 e5                	mov    %esp,%ebp
  100db2:	83 ec 28             	sub    $0x28,%esp
  100db5:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100dbb:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dbf:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dc3:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100dc7:	ee                   	out    %al,(%dx)
}
  100dc8:	90                   	nop
  100dc9:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100dcf:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dd3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100dd7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100ddb:	ee                   	out    %al,(%dx)
}
  100ddc:	90                   	nop
  100ddd:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100de3:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100de7:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100deb:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100def:	ee                   	out    %al,(%dx)
}
  100df0:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100df1:	c7 05 44 fe 10 00 00 	movl   $0x0,0x10fe44
  100df8:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100dfb:	c7 04 24 dc 39 10 00 	movl   $0x1039dc,(%esp)
  100e02:	e8 29 f5 ff ff       	call   100330 <cprintf>
    pic_enable(IRQ_TIMER);
  100e07:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e0e:	e8 21 09 00 00       	call   101734 <pic_enable>
}
  100e13:	90                   	nop
  100e14:	89 ec                	mov    %ebp,%esp
  100e16:	5d                   	pop    %ebp
  100e17:	c3                   	ret    

00100e18 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e18:	55                   	push   %ebp
  100e19:	89 e5                	mov    %esp,%ebp
  100e1b:	83 ec 10             	sub    $0x10,%esp
  100e1e:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e24:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e28:	89 c2                	mov    %eax,%edx
  100e2a:	ec                   	in     (%dx),%al
  100e2b:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e2e:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e34:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e38:	89 c2                	mov    %eax,%edx
  100e3a:	ec                   	in     (%dx),%al
  100e3b:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e3e:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e44:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e48:	89 c2                	mov    %eax,%edx
  100e4a:	ec                   	in     (%dx),%al
  100e4b:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e4e:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e54:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e58:	89 c2                	mov    %eax,%edx
  100e5a:	ec                   	in     (%dx),%al
  100e5b:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e5e:	90                   	nop
  100e5f:	89 ec                	mov    %ebp,%esp
  100e61:	5d                   	pop    %ebp
  100e62:	c3                   	ret    

00100e63 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e63:	55                   	push   %ebp
  100e64:	89 e5                	mov    %esp,%ebp
  100e66:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e69:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100e70:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e73:	0f b7 00             	movzwl (%eax),%eax
  100e76:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100e7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e7d:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100e82:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e85:	0f b7 00             	movzwl (%eax),%eax
  100e88:	0f b7 c0             	movzwl %ax,%eax
  100e8b:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100e90:	74 12                	je     100ea4 <cga_init+0x41>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100e92:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100e99:	66 c7 05 66 fe 10 00 	movw   $0x3b4,0x10fe66
  100ea0:	b4 03 
  100ea2:	eb 13                	jmp    100eb7 <cga_init+0x54>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100ea4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ea7:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100eab:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100eae:	66 c7 05 66 fe 10 00 	movw   $0x3d4,0x10fe66
  100eb5:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100eb7:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ebe:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100ec2:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ec6:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100eca:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100ece:	ee                   	out    %al,(%dx)
}
  100ecf:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100ed0:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ed7:	40                   	inc    %eax
  100ed8:	0f b7 c0             	movzwl %ax,%eax
  100edb:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100edf:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100ee3:	89 c2                	mov    %eax,%edx
  100ee5:	ec                   	in     (%dx),%al
  100ee6:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100ee9:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100eed:	0f b6 c0             	movzbl %al,%eax
  100ef0:	c1 e0 08             	shl    $0x8,%eax
  100ef3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100ef6:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100efd:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f01:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f05:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f09:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f0d:	ee                   	out    %al,(%dx)
}
  100f0e:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100f0f:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f16:	40                   	inc    %eax
  100f17:	0f b7 c0             	movzwl %ax,%eax
  100f1a:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f1e:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f22:	89 c2                	mov    %eax,%edx
  100f24:	ec                   	in     (%dx),%al
  100f25:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f28:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f2c:	0f b6 c0             	movzbl %al,%eax
  100f2f:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f35:	a3 60 fe 10 00       	mov    %eax,0x10fe60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f3d:	0f b7 c0             	movzwl %ax,%eax
  100f40:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
}
  100f46:	90                   	nop
  100f47:	89 ec                	mov    %ebp,%esp
  100f49:	5d                   	pop    %ebp
  100f4a:	c3                   	ret    

00100f4b <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f4b:	55                   	push   %ebp
  100f4c:	89 e5                	mov    %esp,%ebp
  100f4e:	83 ec 48             	sub    $0x48,%esp
  100f51:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f57:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f5b:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f5f:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f63:	ee                   	out    %al,(%dx)
}
  100f64:	90                   	nop
  100f65:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f6b:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f6f:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f73:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f77:	ee                   	out    %al,(%dx)
}
  100f78:	90                   	nop
  100f79:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100f7f:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f83:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100f87:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100f8b:	ee                   	out    %al,(%dx)
}
  100f8c:	90                   	nop
  100f8d:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100f93:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f97:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100f9b:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100f9f:	ee                   	out    %al,(%dx)
}
  100fa0:	90                   	nop
  100fa1:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fa7:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fab:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100faf:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fb3:	ee                   	out    %al,(%dx)
}
  100fb4:	90                   	nop
  100fb5:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fbb:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fbf:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fc3:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fc7:	ee                   	out    %al,(%dx)
}
  100fc8:	90                   	nop
  100fc9:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100fcf:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fd3:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100fd7:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100fdb:	ee                   	out    %al,(%dx)
}
  100fdc:	90                   	nop
  100fdd:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fe3:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100fe7:	89 c2                	mov    %eax,%edx
  100fe9:	ec                   	in     (%dx),%al
  100fea:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100fed:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100ff1:	3c ff                	cmp    $0xff,%al
  100ff3:	0f 95 c0             	setne  %al
  100ff6:	0f b6 c0             	movzbl %al,%eax
  100ff9:	a3 68 fe 10 00       	mov    %eax,0x10fe68
  100ffe:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101004:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101008:	89 c2                	mov    %eax,%edx
  10100a:	ec                   	in     (%dx),%al
  10100b:	88 45 f1             	mov    %al,-0xf(%ebp)
  10100e:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101014:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101018:	89 c2                	mov    %eax,%edx
  10101a:	ec                   	in     (%dx),%al
  10101b:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  10101e:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101023:	85 c0                	test   %eax,%eax
  101025:	74 0c                	je     101033 <serial_init+0xe8>
        pic_enable(IRQ_COM1);
  101027:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10102e:	e8 01 07 00 00       	call   101734 <pic_enable>
    }
}
  101033:	90                   	nop
  101034:	89 ec                	mov    %ebp,%esp
  101036:	5d                   	pop    %ebp
  101037:	c3                   	ret    

00101038 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101038:	55                   	push   %ebp
  101039:	89 e5                	mov    %esp,%ebp
  10103b:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10103e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101045:	eb 08                	jmp    10104f <lpt_putc_sub+0x17>
        delay();
  101047:	e8 cc fd ff ff       	call   100e18 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10104c:	ff 45 fc             	incl   -0x4(%ebp)
  10104f:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  101055:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101059:	89 c2                	mov    %eax,%edx
  10105b:	ec                   	in     (%dx),%al
  10105c:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10105f:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101063:	84 c0                	test   %al,%al
  101065:	78 09                	js     101070 <lpt_putc_sub+0x38>
  101067:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10106e:	7e d7                	jle    101047 <lpt_putc_sub+0xf>
    }
    outb(LPTPORT + 0, c);
  101070:	8b 45 08             	mov    0x8(%ebp),%eax
  101073:	0f b6 c0             	movzbl %al,%eax
  101076:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  10107c:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10107f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101083:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101087:	ee                   	out    %al,(%dx)
}
  101088:	90                   	nop
  101089:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  10108f:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101093:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101097:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10109b:	ee                   	out    %al,(%dx)
}
  10109c:	90                   	nop
  10109d:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010a3:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010a7:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010ab:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010af:	ee                   	out    %al,(%dx)
}
  1010b0:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010b1:	90                   	nop
  1010b2:	89 ec                	mov    %ebp,%esp
  1010b4:	5d                   	pop    %ebp
  1010b5:	c3                   	ret    

001010b6 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010b6:	55                   	push   %ebp
  1010b7:	89 e5                	mov    %esp,%ebp
  1010b9:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010bc:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010c0:	74 0d                	je     1010cf <lpt_putc+0x19>
        lpt_putc_sub(c);
  1010c2:	8b 45 08             	mov    0x8(%ebp),%eax
  1010c5:	89 04 24             	mov    %eax,(%esp)
  1010c8:	e8 6b ff ff ff       	call   101038 <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010cd:	eb 24                	jmp    1010f3 <lpt_putc+0x3d>
        lpt_putc_sub('\b');
  1010cf:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010d6:	e8 5d ff ff ff       	call   101038 <lpt_putc_sub>
        lpt_putc_sub(' ');
  1010db:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1010e2:	e8 51 ff ff ff       	call   101038 <lpt_putc_sub>
        lpt_putc_sub('\b');
  1010e7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010ee:	e8 45 ff ff ff       	call   101038 <lpt_putc_sub>
}
  1010f3:	90                   	nop
  1010f4:	89 ec                	mov    %ebp,%esp
  1010f6:	5d                   	pop    %ebp
  1010f7:	c3                   	ret    

001010f8 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  1010f8:	55                   	push   %ebp
  1010f9:	89 e5                	mov    %esp,%ebp
  1010fb:	83 ec 38             	sub    $0x38,%esp
  1010fe:	89 5d fc             	mov    %ebx,-0x4(%ebp)
    // set black on white
    if (!(c & ~0xFF)) {
  101101:	8b 45 08             	mov    0x8(%ebp),%eax
  101104:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101109:	85 c0                	test   %eax,%eax
  10110b:	75 07                	jne    101114 <cga_putc+0x1c>
        c |= 0x0700;
  10110d:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101114:	8b 45 08             	mov    0x8(%ebp),%eax
  101117:	0f b6 c0             	movzbl %al,%eax
  10111a:	83 f8 0d             	cmp    $0xd,%eax
  10111d:	74 72                	je     101191 <cga_putc+0x99>
  10111f:	83 f8 0d             	cmp    $0xd,%eax
  101122:	0f 8f a3 00 00 00    	jg     1011cb <cga_putc+0xd3>
  101128:	83 f8 08             	cmp    $0x8,%eax
  10112b:	74 0a                	je     101137 <cga_putc+0x3f>
  10112d:	83 f8 0a             	cmp    $0xa,%eax
  101130:	74 4c                	je     10117e <cga_putc+0x86>
  101132:	e9 94 00 00 00       	jmp    1011cb <cga_putc+0xd3>
    case '\b':
        if (crt_pos > 0) {
  101137:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10113e:	85 c0                	test   %eax,%eax
  101140:	0f 84 af 00 00 00    	je     1011f5 <cga_putc+0xfd>
            crt_pos --;
  101146:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10114d:	48                   	dec    %eax
  10114e:	0f b7 c0             	movzwl %ax,%eax
  101151:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101157:	8b 45 08             	mov    0x8(%ebp),%eax
  10115a:	98                   	cwtl   
  10115b:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101160:	98                   	cwtl   
  101161:	83 c8 20             	or     $0x20,%eax
  101164:	98                   	cwtl   
  101165:	8b 0d 60 fe 10 00    	mov    0x10fe60,%ecx
  10116b:	0f b7 15 64 fe 10 00 	movzwl 0x10fe64,%edx
  101172:	01 d2                	add    %edx,%edx
  101174:	01 ca                	add    %ecx,%edx
  101176:	0f b7 c0             	movzwl %ax,%eax
  101179:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  10117c:	eb 77                	jmp    1011f5 <cga_putc+0xfd>
    case '\n':
        crt_pos += CRT_COLS;
  10117e:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101185:	83 c0 50             	add    $0x50,%eax
  101188:	0f b7 c0             	movzwl %ax,%eax
  10118b:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101191:	0f b7 1d 64 fe 10 00 	movzwl 0x10fe64,%ebx
  101198:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  10119f:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  1011a4:	89 c8                	mov    %ecx,%eax
  1011a6:	f7 e2                	mul    %edx
  1011a8:	c1 ea 06             	shr    $0x6,%edx
  1011ab:	89 d0                	mov    %edx,%eax
  1011ad:	c1 e0 02             	shl    $0x2,%eax
  1011b0:	01 d0                	add    %edx,%eax
  1011b2:	c1 e0 04             	shl    $0x4,%eax
  1011b5:	29 c1                	sub    %eax,%ecx
  1011b7:	89 ca                	mov    %ecx,%edx
  1011b9:	0f b7 d2             	movzwl %dx,%edx
  1011bc:	89 d8                	mov    %ebx,%eax
  1011be:	29 d0                	sub    %edx,%eax
  1011c0:	0f b7 c0             	movzwl %ax,%eax
  1011c3:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
        break;
  1011c9:	eb 2b                	jmp    1011f6 <cga_putc+0xfe>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011cb:	8b 0d 60 fe 10 00    	mov    0x10fe60,%ecx
  1011d1:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011d8:	8d 50 01             	lea    0x1(%eax),%edx
  1011db:	0f b7 d2             	movzwl %dx,%edx
  1011de:	66 89 15 64 fe 10 00 	mov    %dx,0x10fe64
  1011e5:	01 c0                	add    %eax,%eax
  1011e7:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  1011ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1011ed:	0f b7 c0             	movzwl %ax,%eax
  1011f0:	66 89 02             	mov    %ax,(%edx)
        break;
  1011f3:	eb 01                	jmp    1011f6 <cga_putc+0xfe>
        break;
  1011f5:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1011f6:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011fd:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  101202:	76 5e                	jbe    101262 <cga_putc+0x16a>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101204:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101209:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10120f:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101214:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  10121b:	00 
  10121c:	89 54 24 04          	mov    %edx,0x4(%esp)
  101220:	89 04 24             	mov    %eax,(%esp)
  101223:	e8 30 23 00 00       	call   103558 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101228:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10122f:	eb 15                	jmp    101246 <cga_putc+0x14e>
            crt_buf[i] = 0x0700 | ' ';
  101231:	8b 15 60 fe 10 00    	mov    0x10fe60,%edx
  101237:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10123a:	01 c0                	add    %eax,%eax
  10123c:	01 d0                	add    %edx,%eax
  10123e:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101243:	ff 45 f4             	incl   -0xc(%ebp)
  101246:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10124d:	7e e2                	jle    101231 <cga_putc+0x139>
        }
        crt_pos -= CRT_COLS;
  10124f:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101256:	83 e8 50             	sub    $0x50,%eax
  101259:	0f b7 c0             	movzwl %ax,%eax
  10125c:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101262:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  101269:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  10126d:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101271:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101275:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101279:	ee                   	out    %al,(%dx)
}
  10127a:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  10127b:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101282:	c1 e8 08             	shr    $0x8,%eax
  101285:	0f b7 c0             	movzwl %ax,%eax
  101288:	0f b6 c0             	movzbl %al,%eax
  10128b:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  101292:	42                   	inc    %edx
  101293:	0f b7 d2             	movzwl %dx,%edx
  101296:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  10129a:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10129d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012a1:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012a5:	ee                   	out    %al,(%dx)
}
  1012a6:	90                   	nop
    outb(addr_6845, 15);
  1012a7:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  1012ae:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012b2:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012b6:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012ba:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012be:	ee                   	out    %al,(%dx)
}
  1012bf:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012c0:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012c7:	0f b6 c0             	movzbl %al,%eax
  1012ca:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012d1:	42                   	inc    %edx
  1012d2:	0f b7 d2             	movzwl %dx,%edx
  1012d5:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1012d9:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012dc:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1012e0:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1012e4:	ee                   	out    %al,(%dx)
}
  1012e5:	90                   	nop
}
  1012e6:	90                   	nop
  1012e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1012ea:	89 ec                	mov    %ebp,%esp
  1012ec:	5d                   	pop    %ebp
  1012ed:	c3                   	ret    

001012ee <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1012ee:	55                   	push   %ebp
  1012ef:	89 e5                	mov    %esp,%ebp
  1012f1:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1012fb:	eb 08                	jmp    101305 <serial_putc_sub+0x17>
        delay();
  1012fd:	e8 16 fb ff ff       	call   100e18 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101302:	ff 45 fc             	incl   -0x4(%ebp)
  101305:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10130b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10130f:	89 c2                	mov    %eax,%edx
  101311:	ec                   	in     (%dx),%al
  101312:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101315:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101319:	0f b6 c0             	movzbl %al,%eax
  10131c:	83 e0 20             	and    $0x20,%eax
  10131f:	85 c0                	test   %eax,%eax
  101321:	75 09                	jne    10132c <serial_putc_sub+0x3e>
  101323:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10132a:	7e d1                	jle    1012fd <serial_putc_sub+0xf>
    }
    outb(COM1 + COM_TX, c);
  10132c:	8b 45 08             	mov    0x8(%ebp),%eax
  10132f:	0f b6 c0             	movzbl %al,%eax
  101332:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101338:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10133b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10133f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101343:	ee                   	out    %al,(%dx)
}
  101344:	90                   	nop
}
  101345:	90                   	nop
  101346:	89 ec                	mov    %ebp,%esp
  101348:	5d                   	pop    %ebp
  101349:	c3                   	ret    

0010134a <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  10134a:	55                   	push   %ebp
  10134b:	89 e5                	mov    %esp,%ebp
  10134d:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101350:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101354:	74 0d                	je     101363 <serial_putc+0x19>
        serial_putc_sub(c);
  101356:	8b 45 08             	mov    0x8(%ebp),%eax
  101359:	89 04 24             	mov    %eax,(%esp)
  10135c:	e8 8d ff ff ff       	call   1012ee <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101361:	eb 24                	jmp    101387 <serial_putc+0x3d>
        serial_putc_sub('\b');
  101363:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10136a:	e8 7f ff ff ff       	call   1012ee <serial_putc_sub>
        serial_putc_sub(' ');
  10136f:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101376:	e8 73 ff ff ff       	call   1012ee <serial_putc_sub>
        serial_putc_sub('\b');
  10137b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101382:	e8 67 ff ff ff       	call   1012ee <serial_putc_sub>
}
  101387:	90                   	nop
  101388:	89 ec                	mov    %ebp,%esp
  10138a:	5d                   	pop    %ebp
  10138b:	c3                   	ret    

0010138c <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10138c:	55                   	push   %ebp
  10138d:	89 e5                	mov    %esp,%ebp
  10138f:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101392:	eb 33                	jmp    1013c7 <cons_intr+0x3b>
        if (c != 0) {
  101394:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101398:	74 2d                	je     1013c7 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  10139a:	a1 84 00 11 00       	mov    0x110084,%eax
  10139f:	8d 50 01             	lea    0x1(%eax),%edx
  1013a2:	89 15 84 00 11 00    	mov    %edx,0x110084
  1013a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013ab:	88 90 80 fe 10 00    	mov    %dl,0x10fe80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013b1:	a1 84 00 11 00       	mov    0x110084,%eax
  1013b6:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013bb:	75 0a                	jne    1013c7 <cons_intr+0x3b>
                cons.wpos = 0;
  1013bd:	c7 05 84 00 11 00 00 	movl   $0x0,0x110084
  1013c4:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1013ca:	ff d0                	call   *%eax
  1013cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013cf:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013d3:	75 bf                	jne    101394 <cons_intr+0x8>
            }
        }
    }
}
  1013d5:	90                   	nop
  1013d6:	90                   	nop
  1013d7:	89 ec                	mov    %ebp,%esp
  1013d9:	5d                   	pop    %ebp
  1013da:	c3                   	ret    

001013db <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1013db:	55                   	push   %ebp
  1013dc:	89 e5                	mov    %esp,%ebp
  1013de:	83 ec 10             	sub    $0x10,%esp
  1013e1:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013e7:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1013eb:	89 c2                	mov    %eax,%edx
  1013ed:	ec                   	in     (%dx),%al
  1013ee:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1013f1:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1013f5:	0f b6 c0             	movzbl %al,%eax
  1013f8:	83 e0 01             	and    $0x1,%eax
  1013fb:	85 c0                	test   %eax,%eax
  1013fd:	75 07                	jne    101406 <serial_proc_data+0x2b>
        return -1;
  1013ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101404:	eb 2a                	jmp    101430 <serial_proc_data+0x55>
  101406:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10140c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101410:	89 c2                	mov    %eax,%edx
  101412:	ec                   	in     (%dx),%al
  101413:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101416:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10141a:	0f b6 c0             	movzbl %al,%eax
  10141d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101420:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101424:	75 07                	jne    10142d <serial_proc_data+0x52>
        c = '\b';
  101426:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10142d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101430:	89 ec                	mov    %ebp,%esp
  101432:	5d                   	pop    %ebp
  101433:	c3                   	ret    

00101434 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101434:	55                   	push   %ebp
  101435:	89 e5                	mov    %esp,%ebp
  101437:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  10143a:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  10143f:	85 c0                	test   %eax,%eax
  101441:	74 0c                	je     10144f <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  101443:	c7 04 24 db 13 10 00 	movl   $0x1013db,(%esp)
  10144a:	e8 3d ff ff ff       	call   10138c <cons_intr>
    }
}
  10144f:	90                   	nop
  101450:	89 ec                	mov    %ebp,%esp
  101452:	5d                   	pop    %ebp
  101453:	c3                   	ret    

00101454 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101454:	55                   	push   %ebp
  101455:	89 e5                	mov    %esp,%ebp
  101457:	83 ec 38             	sub    $0x38,%esp
  10145a:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101460:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101463:	89 c2                	mov    %eax,%edx
  101465:	ec                   	in     (%dx),%al
  101466:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101469:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10146d:	0f b6 c0             	movzbl %al,%eax
  101470:	83 e0 01             	and    $0x1,%eax
  101473:	85 c0                	test   %eax,%eax
  101475:	75 0a                	jne    101481 <kbd_proc_data+0x2d>
        return -1;
  101477:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10147c:	e9 56 01 00 00       	jmp    1015d7 <kbd_proc_data+0x183>
  101481:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101487:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10148a:	89 c2                	mov    %eax,%edx
  10148c:	ec                   	in     (%dx),%al
  10148d:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  101490:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101494:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101497:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  10149b:	75 17                	jne    1014b4 <kbd_proc_data+0x60>
        // E0 escape character
        shift |= E0ESC;
  10149d:	a1 88 00 11 00       	mov    0x110088,%eax
  1014a2:	83 c8 40             	or     $0x40,%eax
  1014a5:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  1014aa:	b8 00 00 00 00       	mov    $0x0,%eax
  1014af:	e9 23 01 00 00       	jmp    1015d7 <kbd_proc_data+0x183>
    } else if (data & 0x80) {
  1014b4:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014b8:	84 c0                	test   %al,%al
  1014ba:	79 45                	jns    101501 <kbd_proc_data+0xad>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014bc:	a1 88 00 11 00       	mov    0x110088,%eax
  1014c1:	83 e0 40             	and    $0x40,%eax
  1014c4:	85 c0                	test   %eax,%eax
  1014c6:	75 08                	jne    1014d0 <kbd_proc_data+0x7c>
  1014c8:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014cc:	24 7f                	and    $0x7f,%al
  1014ce:	eb 04                	jmp    1014d4 <kbd_proc_data+0x80>
  1014d0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014d4:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1014d7:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014db:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  1014e2:	0c 40                	or     $0x40,%al
  1014e4:	0f b6 c0             	movzbl %al,%eax
  1014e7:	f7 d0                	not    %eax
  1014e9:	89 c2                	mov    %eax,%edx
  1014eb:	a1 88 00 11 00       	mov    0x110088,%eax
  1014f0:	21 d0                	and    %edx,%eax
  1014f2:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  1014f7:	b8 00 00 00 00       	mov    $0x0,%eax
  1014fc:	e9 d6 00 00 00       	jmp    1015d7 <kbd_proc_data+0x183>
    } else if (shift & E0ESC) {
  101501:	a1 88 00 11 00       	mov    0x110088,%eax
  101506:	83 e0 40             	and    $0x40,%eax
  101509:	85 c0                	test   %eax,%eax
  10150b:	74 11                	je     10151e <kbd_proc_data+0xca>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10150d:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101511:	a1 88 00 11 00       	mov    0x110088,%eax
  101516:	83 e0 bf             	and    $0xffffffbf,%eax
  101519:	a3 88 00 11 00       	mov    %eax,0x110088
    }

    shift |= shiftcode[data];
  10151e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101522:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  101529:	0f b6 d0             	movzbl %al,%edx
  10152c:	a1 88 00 11 00       	mov    0x110088,%eax
  101531:	09 d0                	or     %edx,%eax
  101533:	a3 88 00 11 00       	mov    %eax,0x110088
    shift ^= togglecode[data];
  101538:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10153c:	0f b6 80 40 f1 10 00 	movzbl 0x10f140(%eax),%eax
  101543:	0f b6 d0             	movzbl %al,%edx
  101546:	a1 88 00 11 00       	mov    0x110088,%eax
  10154b:	31 d0                	xor    %edx,%eax
  10154d:	a3 88 00 11 00       	mov    %eax,0x110088

    c = charcode[shift & (CTL | SHIFT)][data];
  101552:	a1 88 00 11 00       	mov    0x110088,%eax
  101557:	83 e0 03             	and    $0x3,%eax
  10155a:	8b 14 85 40 f5 10 00 	mov    0x10f540(,%eax,4),%edx
  101561:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101565:	01 d0                	add    %edx,%eax
  101567:	0f b6 00             	movzbl (%eax),%eax
  10156a:	0f b6 c0             	movzbl %al,%eax
  10156d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101570:	a1 88 00 11 00       	mov    0x110088,%eax
  101575:	83 e0 08             	and    $0x8,%eax
  101578:	85 c0                	test   %eax,%eax
  10157a:	74 22                	je     10159e <kbd_proc_data+0x14a>
        if ('a' <= c && c <= 'z')
  10157c:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  101580:	7e 0c                	jle    10158e <kbd_proc_data+0x13a>
  101582:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101586:	7f 06                	jg     10158e <kbd_proc_data+0x13a>
            c += 'A' - 'a';
  101588:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  10158c:	eb 10                	jmp    10159e <kbd_proc_data+0x14a>
        else if ('A' <= c && c <= 'Z')
  10158e:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  101592:	7e 0a                	jle    10159e <kbd_proc_data+0x14a>
  101594:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  101598:	7f 04                	jg     10159e <kbd_proc_data+0x14a>
            c += 'a' - 'A';
  10159a:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10159e:	a1 88 00 11 00       	mov    0x110088,%eax
  1015a3:	f7 d0                	not    %eax
  1015a5:	83 e0 06             	and    $0x6,%eax
  1015a8:	85 c0                	test   %eax,%eax
  1015aa:	75 28                	jne    1015d4 <kbd_proc_data+0x180>
  1015ac:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015b3:	75 1f                	jne    1015d4 <kbd_proc_data+0x180>
        cprintf("Rebooting!\n");
  1015b5:	c7 04 24 f7 39 10 00 	movl   $0x1039f7,(%esp)
  1015bc:	e8 6f ed ff ff       	call   100330 <cprintf>
  1015c1:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015c7:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1015cb:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015cf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1015d2:	ee                   	out    %al,(%dx)
}
  1015d3:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1015d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1015d7:	89 ec                	mov    %ebp,%esp
  1015d9:	5d                   	pop    %ebp
  1015da:	c3                   	ret    

001015db <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1015db:	55                   	push   %ebp
  1015dc:	89 e5                	mov    %esp,%ebp
  1015de:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  1015e1:	c7 04 24 54 14 10 00 	movl   $0x101454,(%esp)
  1015e8:	e8 9f fd ff ff       	call   10138c <cons_intr>
}
  1015ed:	90                   	nop
  1015ee:	89 ec                	mov    %ebp,%esp
  1015f0:	5d                   	pop    %ebp
  1015f1:	c3                   	ret    

001015f2 <kbd_init>:

static void
kbd_init(void) {
  1015f2:	55                   	push   %ebp
  1015f3:	89 e5                	mov    %esp,%ebp
  1015f5:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  1015f8:	e8 de ff ff ff       	call   1015db <kbd_intr>
    pic_enable(IRQ_KBD);
  1015fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  101604:	e8 2b 01 00 00       	call   101734 <pic_enable>
}
  101609:	90                   	nop
  10160a:	89 ec                	mov    %ebp,%esp
  10160c:	5d                   	pop    %ebp
  10160d:	c3                   	ret    

0010160e <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10160e:	55                   	push   %ebp
  10160f:	89 e5                	mov    %esp,%ebp
  101611:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  101614:	e8 4a f8 ff ff       	call   100e63 <cga_init>
    serial_init();
  101619:	e8 2d f9 ff ff       	call   100f4b <serial_init>
    kbd_init();
  10161e:	e8 cf ff ff ff       	call   1015f2 <kbd_init>
    if (!serial_exists) {
  101623:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101628:	85 c0                	test   %eax,%eax
  10162a:	75 0c                	jne    101638 <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  10162c:	c7 04 24 03 3a 10 00 	movl   $0x103a03,(%esp)
  101633:	e8 f8 ec ff ff       	call   100330 <cprintf>
    }
}
  101638:	90                   	nop
  101639:	89 ec                	mov    %ebp,%esp
  10163b:	5d                   	pop    %ebp
  10163c:	c3                   	ret    

0010163d <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  10163d:	55                   	push   %ebp
  10163e:	89 e5                	mov    %esp,%ebp
  101640:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  101643:	8b 45 08             	mov    0x8(%ebp),%eax
  101646:	89 04 24             	mov    %eax,(%esp)
  101649:	e8 68 fa ff ff       	call   1010b6 <lpt_putc>
    cga_putc(c);
  10164e:	8b 45 08             	mov    0x8(%ebp),%eax
  101651:	89 04 24             	mov    %eax,(%esp)
  101654:	e8 9f fa ff ff       	call   1010f8 <cga_putc>
    serial_putc(c);
  101659:	8b 45 08             	mov    0x8(%ebp),%eax
  10165c:	89 04 24             	mov    %eax,(%esp)
  10165f:	e8 e6 fc ff ff       	call   10134a <serial_putc>
}
  101664:	90                   	nop
  101665:	89 ec                	mov    %ebp,%esp
  101667:	5d                   	pop    %ebp
  101668:	c3                   	ret    

00101669 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  101669:	55                   	push   %ebp
  10166a:	89 e5                	mov    %esp,%ebp
  10166c:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  10166f:	e8 c0 fd ff ff       	call   101434 <serial_intr>
    kbd_intr();
  101674:	e8 62 ff ff ff       	call   1015db <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  101679:	8b 15 80 00 11 00    	mov    0x110080,%edx
  10167f:	a1 84 00 11 00       	mov    0x110084,%eax
  101684:	39 c2                	cmp    %eax,%edx
  101686:	74 36                	je     1016be <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  101688:	a1 80 00 11 00       	mov    0x110080,%eax
  10168d:	8d 50 01             	lea    0x1(%eax),%edx
  101690:	89 15 80 00 11 00    	mov    %edx,0x110080
  101696:	0f b6 80 80 fe 10 00 	movzbl 0x10fe80(%eax),%eax
  10169d:	0f b6 c0             	movzbl %al,%eax
  1016a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016a3:	a1 80 00 11 00       	mov    0x110080,%eax
  1016a8:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016ad:	75 0a                	jne    1016b9 <cons_getc+0x50>
            cons.rpos = 0;
  1016af:	c7 05 80 00 11 00 00 	movl   $0x0,0x110080
  1016b6:	00 00 00 
        }
        return c;
  1016b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1016bc:	eb 05                	jmp    1016c3 <cons_getc+0x5a>
    }
    return 0;
  1016be:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1016c3:	89 ec                	mov    %ebp,%esp
  1016c5:	5d                   	pop    %ebp
  1016c6:	c3                   	ret    

001016c7 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1016c7:	55                   	push   %ebp
  1016c8:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1016ca:	fb                   	sti    
}
  1016cb:	90                   	nop
    sti();
}
  1016cc:	90                   	nop
  1016cd:	5d                   	pop    %ebp
  1016ce:	c3                   	ret    

001016cf <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1016cf:	55                   	push   %ebp
  1016d0:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  1016d2:	fa                   	cli    
}
  1016d3:	90                   	nop
    cli();
}
  1016d4:	90                   	nop
  1016d5:	5d                   	pop    %ebp
  1016d6:	c3                   	ret    

001016d7 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1016d7:	55                   	push   %ebp
  1016d8:	89 e5                	mov    %esp,%ebp
  1016da:	83 ec 14             	sub    $0x14,%esp
  1016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1016e0:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  1016e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1016e7:	66 a3 50 f5 10 00    	mov    %ax,0x10f550
    if (did_init) {
  1016ed:	a1 8c 00 11 00       	mov    0x11008c,%eax
  1016f2:	85 c0                	test   %eax,%eax
  1016f4:	74 39                	je     10172f <pic_setmask+0x58>
        outb(IO_PIC1 + 1, mask);
  1016f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1016f9:	0f b6 c0             	movzbl %al,%eax
  1016fc:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101702:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101705:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101709:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10170d:	ee                   	out    %al,(%dx)
}
  10170e:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  10170f:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101713:	c1 e8 08             	shr    $0x8,%eax
  101716:	0f b7 c0             	movzwl %ax,%eax
  101719:	0f b6 c0             	movzbl %al,%eax
  10171c:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101722:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101725:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101729:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10172d:	ee                   	out    %al,(%dx)
}
  10172e:	90                   	nop
    }
}
  10172f:	90                   	nop
  101730:	89 ec                	mov    %ebp,%esp
  101732:	5d                   	pop    %ebp
  101733:	c3                   	ret    

00101734 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101734:	55                   	push   %ebp
  101735:	89 e5                	mov    %esp,%ebp
  101737:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  10173a:	8b 45 08             	mov    0x8(%ebp),%eax
  10173d:	ba 01 00 00 00       	mov    $0x1,%edx
  101742:	88 c1                	mov    %al,%cl
  101744:	d3 e2                	shl    %cl,%edx
  101746:	89 d0                	mov    %edx,%eax
  101748:	98                   	cwtl   
  101749:	f7 d0                	not    %eax
  10174b:	0f bf d0             	movswl %ax,%edx
  10174e:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  101755:	98                   	cwtl   
  101756:	21 d0                	and    %edx,%eax
  101758:	98                   	cwtl   
  101759:	0f b7 c0             	movzwl %ax,%eax
  10175c:	89 04 24             	mov    %eax,(%esp)
  10175f:	e8 73 ff ff ff       	call   1016d7 <pic_setmask>
}
  101764:	90                   	nop
  101765:	89 ec                	mov    %ebp,%esp
  101767:	5d                   	pop    %ebp
  101768:	c3                   	ret    

00101769 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101769:	55                   	push   %ebp
  10176a:	89 e5                	mov    %esp,%ebp
  10176c:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  10176f:	c7 05 8c 00 11 00 01 	movl   $0x1,0x11008c
  101776:	00 00 00 
  101779:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  10177f:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101783:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  101787:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  10178b:	ee                   	out    %al,(%dx)
}
  10178c:	90                   	nop
  10178d:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  101793:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101797:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  10179b:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  10179f:	ee                   	out    %al,(%dx)
}
  1017a0:	90                   	nop
  1017a1:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017a7:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017ab:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017af:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017b3:	ee                   	out    %al,(%dx)
}
  1017b4:	90                   	nop
  1017b5:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017bb:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017bf:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017c3:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017c7:	ee                   	out    %al,(%dx)
}
  1017c8:	90                   	nop
  1017c9:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  1017cf:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017d3:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  1017d7:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  1017db:	ee                   	out    %al,(%dx)
}
  1017dc:	90                   	nop
  1017dd:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  1017e3:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017e7:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  1017eb:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  1017ef:	ee                   	out    %al,(%dx)
}
  1017f0:	90                   	nop
  1017f1:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  1017f7:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017fb:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  1017ff:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101803:	ee                   	out    %al,(%dx)
}
  101804:	90                   	nop
  101805:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  10180b:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10180f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101813:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101817:	ee                   	out    %al,(%dx)
}
  101818:	90                   	nop
  101819:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  10181f:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101823:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101827:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10182b:	ee                   	out    %al,(%dx)
}
  10182c:	90                   	nop
  10182d:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101833:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101837:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10183b:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10183f:	ee                   	out    %al,(%dx)
}
  101840:	90                   	nop
  101841:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101847:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10184b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10184f:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101853:	ee                   	out    %al,(%dx)
}
  101854:	90                   	nop
  101855:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  10185b:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10185f:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101863:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101867:	ee                   	out    %al,(%dx)
}
  101868:	90                   	nop
  101869:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  10186f:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101873:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101877:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10187b:	ee                   	out    %al,(%dx)
}
  10187c:	90                   	nop
  10187d:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  101883:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101887:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10188b:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10188f:	ee                   	out    %al,(%dx)
}
  101890:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101891:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  101898:	3d ff ff 00 00       	cmp    $0xffff,%eax
  10189d:	74 0f                	je     1018ae <pic_init+0x145>
        pic_setmask(irq_mask);
  10189f:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018a6:	89 04 24             	mov    %eax,(%esp)
  1018a9:	e8 29 fe ff ff       	call   1016d7 <pic_setmask>
    }
}
  1018ae:	90                   	nop
  1018af:	89 ec                	mov    %ebp,%esp
  1018b1:	5d                   	pop    %ebp
  1018b2:	c3                   	ret    

001018b3 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1018b3:	55                   	push   %ebp
  1018b4:	89 e5                	mov    %esp,%ebp
  1018b6:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1018b9:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  1018c0:	00 
  1018c1:	c7 04 24 40 3a 10 00 	movl   $0x103a40,(%esp)
  1018c8:	e8 63 ea ff ff       	call   100330 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  1018cd:	90                   	nop
  1018ce:	89 ec                	mov    %ebp,%esp
  1018d0:	5d                   	pop    %ebp
  1018d1:	c3                   	ret    

001018d2 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  1018d2:	55                   	push   %ebp
  1018d3:	89 e5                	mov    %esp,%ebp
  1018d5:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];//存储了中断处理程序的入口地址

	for (int i = 0 ; i < 256; i++)  SETGATE(idt[i],0,GD_KTEXT,__vectors[i],DPL_KERNEL);
  1018d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1018df:	e9 c4 00 00 00       	jmp    1019a8 <idt_init+0xd6>
  1018e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018e7:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  1018ee:	0f b7 d0             	movzwl %ax,%edx
  1018f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018f4:	66 89 14 c5 a0 00 11 	mov    %dx,0x1100a0(,%eax,8)
  1018fb:	00 
  1018fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018ff:	66 c7 04 c5 a2 00 11 	movw   $0x8,0x1100a2(,%eax,8)
  101906:	00 08 00 
  101909:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10190c:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101913:	00 
  101914:	80 e2 e0             	and    $0xe0,%dl
  101917:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  10191e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101921:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101928:	00 
  101929:	80 e2 1f             	and    $0x1f,%dl
  10192c:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  101933:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101936:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  10193d:	00 
  10193e:	80 e2 f0             	and    $0xf0,%dl
  101941:	80 ca 0e             	or     $0xe,%dl
  101944:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  10194b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10194e:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  101955:	00 
  101956:	80 e2 ef             	and    $0xef,%dl
  101959:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  101960:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101963:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  10196a:	00 
  10196b:	80 e2 9f             	and    $0x9f,%dl
  10196e:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  101975:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101978:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  10197f:	00 
  101980:	80 ca 80             	or     $0x80,%dl
  101983:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  10198a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10198d:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  101994:	c1 e8 10             	shr    $0x10,%eax
  101997:	0f b7 d0             	movzwl %ax,%edx
  10199a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10199d:	66 89 14 c5 a6 00 11 	mov    %dx,0x1100a6(,%eax,8)
  1019a4:	00 
  1019a5:	ff 45 fc             	incl   -0x4(%ebp)
  1019a8:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  1019af:	0f 8e 2f ff ff ff    	jle    1018e4 <idt_init+0x12>
	SETGATE(idt[T_SWITCH_TOK],0,GD_KTEXT,__vectors[T_SWITCH_TOK],DPL_USER);//kernel/mm/memlayout
  1019b5:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  1019ba:	0f b7 c0             	movzwl %ax,%eax
  1019bd:	66 a3 68 04 11 00    	mov    %ax,0x110468
  1019c3:	66 c7 05 6a 04 11 00 	movw   $0x8,0x11046a
  1019ca:	08 00 
  1019cc:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  1019d3:	24 e0                	and    $0xe0,%al
  1019d5:	a2 6c 04 11 00       	mov    %al,0x11046c
  1019da:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  1019e1:	24 1f                	and    $0x1f,%al
  1019e3:	a2 6c 04 11 00       	mov    %al,0x11046c
  1019e8:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  1019ef:	24 f0                	and    $0xf0,%al
  1019f1:	0c 0e                	or     $0xe,%al
  1019f3:	a2 6d 04 11 00       	mov    %al,0x11046d
  1019f8:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  1019ff:	24 ef                	and    $0xef,%al
  101a01:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a06:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a0d:	0c 60                	or     $0x60,%al
  101a0f:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a14:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a1b:	0c 80                	or     $0x80,%al
  101a1d:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a22:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a27:	c1 e8 10             	shr    $0x10,%eax
  101a2a:	0f b7 c0             	movzwl %ax,%eax
  101a2d:	66 a3 6e 04 11 00    	mov    %ax,0x11046e
  101a33:	c7 45 f8 60 f5 10 00 	movl   $0x10f560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101a3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101a3d:	0f 01 18             	lidtl  (%eax)
}
  101a40:	90                   	nop
	//args:(gate, istrap, sel, off, dpl) 1:trap(= exception)gate,0:interruptgate向量首地址 gate类型 段选择子 偏移地址 DPL
	//特权级不同
	//段选择子:.text的段选择子GD_KTEXT 中断处理函数属于.text vector.s  .text段基址为0 中断处理函数地址的偏移量=地址__vectors i 
	lidt(&idt_pd);//将IDT表的起始地址加载到IDTR寄存器中,
}
  101a41:	90                   	nop
  101a42:	89 ec                	mov    %ebp,%esp
  101a44:	5d                   	pop    %ebp
  101a45:	c3                   	ret    

00101a46 <trapname>:

static const char *
trapname(int trapno) {
  101a46:	55                   	push   %ebp
  101a47:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101a49:	8b 45 08             	mov    0x8(%ebp),%eax
  101a4c:	83 f8 13             	cmp    $0x13,%eax
  101a4f:	77 0c                	ja     101a5d <trapname+0x17>
        return excnames[trapno];
  101a51:	8b 45 08             	mov    0x8(%ebp),%eax
  101a54:	8b 04 85 e0 3d 10 00 	mov    0x103de0(,%eax,4),%eax
  101a5b:	eb 18                	jmp    101a75 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101a5d:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101a61:	7e 0d                	jle    101a70 <trapname+0x2a>
  101a63:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101a67:	7f 07                	jg     101a70 <trapname+0x2a>
        return "Hardware Interrupt";
  101a69:	b8 4a 3a 10 00       	mov    $0x103a4a,%eax
  101a6e:	eb 05                	jmp    101a75 <trapname+0x2f>
    }
    return "(unknown trap)";
  101a70:	b8 5d 3a 10 00       	mov    $0x103a5d,%eax
}
  101a75:	5d                   	pop    %ebp
  101a76:	c3                   	ret    

00101a77 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101a77:	55                   	push   %ebp
  101a78:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  101a7d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101a81:	83 f8 08             	cmp    $0x8,%eax
  101a84:	0f 94 c0             	sete   %al
  101a87:	0f b6 c0             	movzbl %al,%eax
}
  101a8a:	5d                   	pop    %ebp
  101a8b:	c3                   	ret    

00101a8c <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101a8c:	55                   	push   %ebp
  101a8d:	89 e5                	mov    %esp,%ebp
  101a8f:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101a92:	8b 45 08             	mov    0x8(%ebp),%eax
  101a95:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a99:	c7 04 24 9e 3a 10 00 	movl   $0x103a9e,(%esp)
  101aa0:	e8 8b e8 ff ff       	call   100330 <cprintf>
    print_regs(&tf->tf_regs);
  101aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa8:	89 04 24             	mov    %eax,(%esp)
  101aab:	e8 8f 01 00 00       	call   101c3f <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  101ab3:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101ab7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101abb:	c7 04 24 af 3a 10 00 	movl   $0x103aaf,(%esp)
  101ac2:	e8 69 e8 ff ff       	call   100330 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  101aca:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101ace:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ad2:	c7 04 24 c2 3a 10 00 	movl   $0x103ac2,(%esp)
  101ad9:	e8 52 e8 ff ff       	call   100330 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101ade:	8b 45 08             	mov    0x8(%ebp),%eax
  101ae1:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101ae5:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ae9:	c7 04 24 d5 3a 10 00 	movl   $0x103ad5,(%esp)
  101af0:	e8 3b e8 ff ff       	call   100330 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101af5:	8b 45 08             	mov    0x8(%ebp),%eax
  101af8:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101afc:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b00:	c7 04 24 e8 3a 10 00 	movl   $0x103ae8,(%esp)
  101b07:	e8 24 e8 ff ff       	call   100330 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b0f:	8b 40 30             	mov    0x30(%eax),%eax
  101b12:	89 04 24             	mov    %eax,(%esp)
  101b15:	e8 2c ff ff ff       	call   101a46 <trapname>
  101b1a:	8b 55 08             	mov    0x8(%ebp),%edx
  101b1d:	8b 52 30             	mov    0x30(%edx),%edx
  101b20:	89 44 24 08          	mov    %eax,0x8(%esp)
  101b24:	89 54 24 04          	mov    %edx,0x4(%esp)
  101b28:	c7 04 24 fb 3a 10 00 	movl   $0x103afb,(%esp)
  101b2f:	e8 fc e7 ff ff       	call   100330 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101b34:	8b 45 08             	mov    0x8(%ebp),%eax
  101b37:	8b 40 34             	mov    0x34(%eax),%eax
  101b3a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b3e:	c7 04 24 0d 3b 10 00 	movl   $0x103b0d,(%esp)
  101b45:	e8 e6 e7 ff ff       	call   100330 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b4d:	8b 40 38             	mov    0x38(%eax),%eax
  101b50:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b54:	c7 04 24 1c 3b 10 00 	movl   $0x103b1c,(%esp)
  101b5b:	e8 d0 e7 ff ff       	call   100330 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101b60:	8b 45 08             	mov    0x8(%ebp),%eax
  101b63:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b67:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b6b:	c7 04 24 2b 3b 10 00 	movl   $0x103b2b,(%esp)
  101b72:	e8 b9 e7 ff ff       	call   100330 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101b77:	8b 45 08             	mov    0x8(%ebp),%eax
  101b7a:	8b 40 40             	mov    0x40(%eax),%eax
  101b7d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b81:	c7 04 24 3e 3b 10 00 	movl   $0x103b3e,(%esp)
  101b88:	e8 a3 e7 ff ff       	call   100330 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101b94:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101b9b:	eb 3d                	jmp    101bda <print_trapframe+0x14e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  101ba0:	8b 50 40             	mov    0x40(%eax),%edx
  101ba3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101ba6:	21 d0                	and    %edx,%eax
  101ba8:	85 c0                	test   %eax,%eax
  101baa:	74 28                	je     101bd4 <print_trapframe+0x148>
  101bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101baf:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101bb6:	85 c0                	test   %eax,%eax
  101bb8:	74 1a                	je     101bd4 <print_trapframe+0x148>
            cprintf("%s,", IA32flags[i]);
  101bba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101bbd:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101bc4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bc8:	c7 04 24 4d 3b 10 00 	movl   $0x103b4d,(%esp)
  101bcf:	e8 5c e7 ff ff       	call   100330 <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101bd4:	ff 45 f4             	incl   -0xc(%ebp)
  101bd7:	d1 65 f0             	shll   -0x10(%ebp)
  101bda:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101bdd:	83 f8 17             	cmp    $0x17,%eax
  101be0:	76 bb                	jbe    101b9d <print_trapframe+0x111>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101be2:	8b 45 08             	mov    0x8(%ebp),%eax
  101be5:	8b 40 40             	mov    0x40(%eax),%eax
  101be8:	c1 e8 0c             	shr    $0xc,%eax
  101beb:	83 e0 03             	and    $0x3,%eax
  101bee:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bf2:	c7 04 24 51 3b 10 00 	movl   $0x103b51,(%esp)
  101bf9:	e8 32 e7 ff ff       	call   100330 <cprintf>

    if (!trap_in_kernel(tf)) {
  101bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  101c01:	89 04 24             	mov    %eax,(%esp)
  101c04:	e8 6e fe ff ff       	call   101a77 <trap_in_kernel>
  101c09:	85 c0                	test   %eax,%eax
  101c0b:	75 2d                	jne    101c3a <print_trapframe+0x1ae>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101c10:	8b 40 44             	mov    0x44(%eax),%eax
  101c13:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c17:	c7 04 24 5a 3b 10 00 	movl   $0x103b5a,(%esp)
  101c1e:	e8 0d e7 ff ff       	call   100330 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c23:	8b 45 08             	mov    0x8(%ebp),%eax
  101c26:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101c2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c2e:	c7 04 24 69 3b 10 00 	movl   $0x103b69,(%esp)
  101c35:	e8 f6 e6 ff ff       	call   100330 <cprintf>
    }
}
  101c3a:	90                   	nop
  101c3b:	89 ec                	mov    %ebp,%esp
  101c3d:	5d                   	pop    %ebp
  101c3e:	c3                   	ret    

00101c3f <print_regs>:

void
print_regs(struct pushregs *regs) {
  101c3f:	55                   	push   %ebp
  101c40:	89 e5                	mov    %esp,%ebp
  101c42:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101c45:	8b 45 08             	mov    0x8(%ebp),%eax
  101c48:	8b 00                	mov    (%eax),%eax
  101c4a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c4e:	c7 04 24 7c 3b 10 00 	movl   $0x103b7c,(%esp)
  101c55:	e8 d6 e6 ff ff       	call   100330 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  101c5d:	8b 40 04             	mov    0x4(%eax),%eax
  101c60:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c64:	c7 04 24 8b 3b 10 00 	movl   $0x103b8b,(%esp)
  101c6b:	e8 c0 e6 ff ff       	call   100330 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101c70:	8b 45 08             	mov    0x8(%ebp),%eax
  101c73:	8b 40 08             	mov    0x8(%eax),%eax
  101c76:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c7a:	c7 04 24 9a 3b 10 00 	movl   $0x103b9a,(%esp)
  101c81:	e8 aa e6 ff ff       	call   100330 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101c86:	8b 45 08             	mov    0x8(%ebp),%eax
  101c89:	8b 40 0c             	mov    0xc(%eax),%eax
  101c8c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c90:	c7 04 24 a9 3b 10 00 	movl   $0x103ba9,(%esp)
  101c97:	e8 94 e6 ff ff       	call   100330 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  101c9f:	8b 40 10             	mov    0x10(%eax),%eax
  101ca2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ca6:	c7 04 24 b8 3b 10 00 	movl   $0x103bb8,(%esp)
  101cad:	e8 7e e6 ff ff       	call   100330 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb5:	8b 40 14             	mov    0x14(%eax),%eax
  101cb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cbc:	c7 04 24 c7 3b 10 00 	movl   $0x103bc7,(%esp)
  101cc3:	e8 68 e6 ff ff       	call   100330 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  101ccb:	8b 40 18             	mov    0x18(%eax),%eax
  101cce:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cd2:	c7 04 24 d6 3b 10 00 	movl   $0x103bd6,(%esp)
  101cd9:	e8 52 e6 ff ff       	call   100330 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101cde:	8b 45 08             	mov    0x8(%ebp),%eax
  101ce1:	8b 40 1c             	mov    0x1c(%eax),%eax
  101ce4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ce8:	c7 04 24 e5 3b 10 00 	movl   $0x103be5,(%esp)
  101cef:	e8 3c e6 ff ff       	call   100330 <cprintf>
}
  101cf4:	90                   	nop
  101cf5:	89 ec                	mov    %ebp,%esp
  101cf7:	5d                   	pop    %ebp
  101cf8:	c3                   	ret    

00101cf9 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101cf9:	55                   	push   %ebp
  101cfa:	89 e5                	mov    %esp,%ebp
  101cfc:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101cff:	8b 45 08             	mov    0x8(%ebp),%eax
  101d02:	8b 40 30             	mov    0x30(%eax),%eax
  101d05:	83 f8 79             	cmp    $0x79,%eax
  101d08:	0f 84 fe 01 00 00    	je     101f0c <trap_dispatch+0x213>
  101d0e:	83 f8 79             	cmp    $0x79,%eax
  101d11:	0f 87 36 02 00 00    	ja     101f4d <trap_dispatch+0x254>
  101d17:	83 f8 78             	cmp    $0x78,%eax
  101d1a:	0f 84 99 01 00 00    	je     101eb9 <trap_dispatch+0x1c0>
  101d20:	83 f8 78             	cmp    $0x78,%eax
  101d23:	0f 87 24 02 00 00    	ja     101f4d <trap_dispatch+0x254>
  101d29:	83 f8 2f             	cmp    $0x2f,%eax
  101d2c:	0f 87 1b 02 00 00    	ja     101f4d <trap_dispatch+0x254>
  101d32:	83 f8 2e             	cmp    $0x2e,%eax
  101d35:	0f 83 47 02 00 00    	jae    101f82 <trap_dispatch+0x289>
  101d3b:	83 f8 24             	cmp    $0x24,%eax
  101d3e:	74 45                	je     101d85 <trap_dispatch+0x8c>
  101d40:	83 f8 24             	cmp    $0x24,%eax
  101d43:	0f 87 04 02 00 00    	ja     101f4d <trap_dispatch+0x254>
  101d49:	83 f8 20             	cmp    $0x20,%eax
  101d4c:	74 0a                	je     101d58 <trap_dispatch+0x5f>
  101d4e:	83 f8 21             	cmp    $0x21,%eax
  101d51:	74 5b                	je     101dae <trap_dispatch+0xb5>
  101d53:	e9 f5 01 00 00       	jmp    101f4d <trap_dispatch+0x254>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
	    ticks = ticks + 1;
  101d58:	a1 44 fe 10 00       	mov    0x10fe44,%eax
  101d5d:	40                   	inc    %eax
  101d5e:	a3 44 fe 10 00       	mov    %eax,0x10fe44
	    if(ticks == TICK_NUM) 
  101d63:	a1 44 fe 10 00       	mov    0x10fe44,%eax
  101d68:	83 f8 64             	cmp    $0x64,%eax
  101d6b:	0f 85 14 02 00 00    	jne    101f85 <trap_dispatch+0x28c>
	    {
		    print_ticks();
  101d71:	e8 3d fb ff ff       	call   1018b3 <print_ticks>
		    ticks=0;
  101d76:	c7 05 44 fe 10 00 00 	movl   $0x0,0x10fe44
  101d7d:	00 00 00 
	    }
        break;
  101d80:	e9 00 02 00 00       	jmp    101f85 <trap_dispatch+0x28c>
        
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101d85:	e8 df f8 ff ff       	call   101669 <cons_getc>
  101d8a:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101d8d:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101d91:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101d95:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d99:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d9d:	c7 04 24 f4 3b 10 00 	movl   $0x103bf4,(%esp)
  101da4:	e8 87 e5 ff ff       	call   100330 <cprintf>
        break;
  101da9:	e9 de 01 00 00       	jmp    101f8c <trap_dispatch+0x293>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101dae:	e8 b6 f8 ff ff       	call   101669 <cons_getc>
  101db3:	88 45 f7             	mov    %al,-0x9(%ebp)
        if(c=='3')
  101db6:	80 7d f7 33          	cmpb   $0x33,-0x9(%ebp)
  101dba:	75 72                	jne    101e2e <trap_dispatch+0x135>
        {
                
		if (tf->tf_cs != USER_CS) 
  101dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  101dbf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101dc3:	83 f8 1b             	cmp    $0x1b,%eax
  101dc6:	74 5a                	je     101e22 <trap_dispatch+0x129>
		{
		    cprintf("Switch To User:");
  101dc8:	c7 04 24 06 3c 10 00 	movl   $0x103c06,(%esp)
  101dcf:	e8 5c e5 ff ff       	call   100330 <cprintf>
		    tf->tf_cs=USER_CS;
  101dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  101dd7:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
		    tf->tf_ds=tf->tf_es=tf->tf_ss=USER_DS;
  101ddd:	8b 45 08             	mov    0x8(%ebp),%eax
  101de0:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  101de6:	8b 45 08             	mov    0x8(%ebp),%eax
  101de9:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  101ded:	8b 45 08             	mov    0x8(%ebp),%eax
  101df0:	66 89 50 28          	mov    %dx,0x28(%eax)
  101df4:	8b 45 08             	mov    0x8(%ebp),%eax
  101df7:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101dfb:	8b 45 08             	mov    0x8(%ebp),%eax
  101dfe:	66 89 50 2c          	mov    %dx,0x2c(%eax)
		    tf->tf_eflags |= FL_IOPL_MASK;
  101e02:	8b 45 08             	mov    0x8(%ebp),%eax
  101e05:	8b 40 40             	mov    0x40(%eax),%eax
  101e08:	0d 00 30 00 00       	or     $0x3000,%eax
  101e0d:	89 c2                	mov    %eax,%edx
  101e0f:	8b 45 08             	mov    0x8(%ebp),%eax
  101e12:	89 50 40             	mov    %edx,0x40(%eax)
		    print_trapframe(tf);
  101e15:	8b 45 08             	mov    0x8(%ebp),%eax
  101e18:	89 04 24             	mov    %eax,(%esp)
  101e1b:	e8 6c fc ff ff       	call   101a8c <print_trapframe>
  101e20:	eb 0c                	jmp    101e2e <trap_dispatch+0x135>
                }
                else cprintf("Already In User");
  101e22:	c7 04 24 16 3c 10 00 	movl   $0x103c16,(%esp)
  101e29:	e8 02 e5 ff ff       	call   100330 <cprintf>
        
        }     
        if(c=='0')
  101e2e:	80 7d f7 30          	cmpb   $0x30,-0x9(%ebp)
  101e32:	75 64                	jne    101e98 <trap_dispatch+0x19f>
        {
		if (tf->tf_cs != KERNEL_CS) 
  101e34:	8b 45 08             	mov    0x8(%ebp),%eax
  101e37:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e3b:	83 f8 08             	cmp    $0x8,%eax
  101e3e:	74 4c                	je     101e8c <trap_dispatch+0x193>
		{
		    cprintf("Switch To Kernel:");
  101e40:	c7 04 24 26 3c 10 00 	movl   $0x103c26,(%esp)
  101e47:	e8 e4 e4 ff ff       	call   100330 <cprintf>
		    tf->tf_cs = KERNEL_CS;
  101e4c:	8b 45 08             	mov    0x8(%ebp),%eax
  101e4f:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
		    tf->tf_ds = tf->tf_es = KERNEL_DS;
  101e55:	8b 45 08             	mov    0x8(%ebp),%eax
  101e58:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101e5e:	8b 45 08             	mov    0x8(%ebp),%eax
  101e61:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101e65:	8b 45 08             	mov    0x8(%ebp),%eax
  101e68:	66 89 50 2c          	mov    %dx,0x2c(%eax)
		    tf->tf_eflags &= ~FL_IOPL_MASK;
  101e6c:	8b 45 08             	mov    0x8(%ebp),%eax
  101e6f:	8b 40 40             	mov    0x40(%eax),%eax
  101e72:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101e77:	89 c2                	mov    %eax,%edx
  101e79:	8b 45 08             	mov    0x8(%ebp),%eax
  101e7c:	89 50 40             	mov    %edx,0x40(%eax)
		    print_trapframe(tf);
  101e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  101e82:	89 04 24             	mov    %eax,(%esp)
  101e85:	e8 02 fc ff ff       	call   101a8c <print_trapframe>
  101e8a:	eb 0c                	jmp    101e98 <trap_dispatch+0x19f>
        	}
        	else cprintf("Already In Kernel");
  101e8c:	c7 04 24 38 3c 10 00 	movl   $0x103c38,(%esp)
  101e93:	e8 98 e4 ff ff       	call   100330 <cprintf>
        
        }
        cprintf("kbd [%03d] %c\n", c, c);
  101e98:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e9c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101ea0:	89 54 24 08          	mov    %edx,0x8(%esp)
  101ea4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ea8:	c7 04 24 4a 3c 10 00 	movl   $0x103c4a,(%esp)
  101eaf:	e8 7c e4 ff ff       	call   100330 <cprintf>
        break;
  101eb4:	e9 d3 00 00 00       	jmp    101f8c <trap_dispatch+0x293>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) {
  101eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  101ebc:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ec0:	83 f8 1b             	cmp    $0x1b,%eax
  101ec3:	0f 84 bf 00 00 00    	je     101f88 <trap_dispatch+0x28f>
	    tf->tf_cs=USER_CS;
  101ec9:	8b 45 08             	mov    0x8(%ebp),%eax
  101ecc:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
	    tf->tf_ds=tf->tf_es=tf->tf_ss=USER_DS;
  101ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ed5:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  101edb:	8b 45 08             	mov    0x8(%ebp),%eax
  101ede:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  101ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee5:	66 89 50 28          	mov    %dx,0x28(%eax)
  101ee9:	8b 45 08             	mov    0x8(%ebp),%eax
  101eec:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101ef0:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef3:	66 89 50 2c          	mov    %dx,0x2c(%eax)
        tf->tf_eflags |= FL_IOPL_MASK;
  101ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  101efa:	8b 40 40             	mov    0x40(%eax),%eax
  101efd:	0d 00 30 00 00       	or     $0x3000,%eax
  101f02:	89 c2                	mov    %eax,%edx
  101f04:	8b 45 08             	mov    0x8(%ebp),%eax
  101f07:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101f0a:	eb 7c                	jmp    101f88 <trap_dispatch+0x28f>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  101f0f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f13:	83 f8 08             	cmp    $0x8,%eax
  101f16:	74 73                	je     101f8b <trap_dispatch+0x292>
            tf->tf_cs = KERNEL_CS;
  101f18:	8b 45 08             	mov    0x8(%ebp),%eax
  101f1b:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101f21:	8b 45 08             	mov    0x8(%ebp),%eax
  101f24:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  101f2d:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101f31:	8b 45 08             	mov    0x8(%ebp),%eax
  101f34:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101f38:	8b 45 08             	mov    0x8(%ebp),%eax
  101f3b:	8b 40 40             	mov    0x40(%eax),%eax
  101f3e:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101f43:	89 c2                	mov    %eax,%edx
  101f45:	8b 45 08             	mov    0x8(%ebp),%eax
  101f48:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101f4b:	eb 3e                	jmp    101f8b <trap_dispatch+0x292>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  101f50:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f54:	83 e0 03             	and    $0x3,%eax
  101f57:	85 c0                	test   %eax,%eax
  101f59:	75 31                	jne    101f8c <trap_dispatch+0x293>
            print_trapframe(tf);
  101f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f5e:	89 04 24             	mov    %eax,(%esp)
  101f61:	e8 26 fb ff ff       	call   101a8c <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101f66:	c7 44 24 08 59 3c 10 	movl   $0x103c59,0x8(%esp)
  101f6d:	00 
  101f6e:	c7 44 24 04 e2 00 00 	movl   $0xe2,0x4(%esp)
  101f75:	00 
  101f76:	c7 04 24 75 3c 10 00 	movl   $0x103c75,(%esp)
  101f7d:	e8 5c ed ff ff       	call   100cde <__panic>
        break;
  101f82:	90                   	nop
  101f83:	eb 07                	jmp    101f8c <trap_dispatch+0x293>
        break;
  101f85:	90                   	nop
  101f86:	eb 04                	jmp    101f8c <trap_dispatch+0x293>
        break;
  101f88:	90                   	nop
  101f89:	eb 01                	jmp    101f8c <trap_dispatch+0x293>
        break;
  101f8b:	90                   	nop
        }
    }
}
  101f8c:	90                   	nop
  101f8d:	89 ec                	mov    %ebp,%esp
  101f8f:	5d                   	pop    %ebp
  101f90:	c3                   	ret    

00101f91 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f91:	55                   	push   %ebp
  101f92:	89 e5                	mov    %esp,%ebp
  101f94:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f97:	8b 45 08             	mov    0x8(%ebp),%eax
  101f9a:	89 04 24             	mov    %eax,(%esp)
  101f9d:	e8 57 fd ff ff       	call   101cf9 <trap_dispatch>
}
  101fa2:	90                   	nop
  101fa3:	89 ec                	mov    %ebp,%esp
  101fa5:	5d                   	pop    %ebp
  101fa6:	c3                   	ret    

00101fa7 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101fa7:	1e                   	push   %ds
    pushl %es
  101fa8:	06                   	push   %es
    pushl %fs
  101fa9:	0f a0                	push   %fs
    pushl %gs
  101fab:	0f a8                	push   %gs
    pushal
  101fad:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101fae:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101fb3:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101fb5:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101fb7:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101fb8:	e8 d4 ff ff ff       	call   101f91 <trap>

    # pop the pushed stack pointer
    popl %esp
  101fbd:	5c                   	pop    %esp

00101fbe <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101fbe:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101fbf:	0f a9                	pop    %gs
    popl %fs
  101fc1:	0f a1                	pop    %fs
    popl %es
  101fc3:	07                   	pop    %es
    popl %ds
  101fc4:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101fc5:	83 c4 08             	add    $0x8,%esp
    iret
  101fc8:	cf                   	iret   

00101fc9 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101fc9:	6a 00                	push   $0x0
  pushl $0
  101fcb:	6a 00                	push   $0x0
  jmp __alltraps
  101fcd:	e9 d5 ff ff ff       	jmp    101fa7 <__alltraps>

00101fd2 <vector1>:
.globl vector1
vector1:
  pushl $0
  101fd2:	6a 00                	push   $0x0
  pushl $1
  101fd4:	6a 01                	push   $0x1
  jmp __alltraps
  101fd6:	e9 cc ff ff ff       	jmp    101fa7 <__alltraps>

00101fdb <vector2>:
.globl vector2
vector2:
  pushl $0
  101fdb:	6a 00                	push   $0x0
  pushl $2
  101fdd:	6a 02                	push   $0x2
  jmp __alltraps
  101fdf:	e9 c3 ff ff ff       	jmp    101fa7 <__alltraps>

00101fe4 <vector3>:
.globl vector3
vector3:
  pushl $0
  101fe4:	6a 00                	push   $0x0
  pushl $3
  101fe6:	6a 03                	push   $0x3
  jmp __alltraps
  101fe8:	e9 ba ff ff ff       	jmp    101fa7 <__alltraps>

00101fed <vector4>:
.globl vector4
vector4:
  pushl $0
  101fed:	6a 00                	push   $0x0
  pushl $4
  101fef:	6a 04                	push   $0x4
  jmp __alltraps
  101ff1:	e9 b1 ff ff ff       	jmp    101fa7 <__alltraps>

00101ff6 <vector5>:
.globl vector5
vector5:
  pushl $0
  101ff6:	6a 00                	push   $0x0
  pushl $5
  101ff8:	6a 05                	push   $0x5
  jmp __alltraps
  101ffa:	e9 a8 ff ff ff       	jmp    101fa7 <__alltraps>

00101fff <vector6>:
.globl vector6
vector6:
  pushl $0
  101fff:	6a 00                	push   $0x0
  pushl $6
  102001:	6a 06                	push   $0x6
  jmp __alltraps
  102003:	e9 9f ff ff ff       	jmp    101fa7 <__alltraps>

00102008 <vector7>:
.globl vector7
vector7:
  pushl $0
  102008:	6a 00                	push   $0x0
  pushl $7
  10200a:	6a 07                	push   $0x7
  jmp __alltraps
  10200c:	e9 96 ff ff ff       	jmp    101fa7 <__alltraps>

00102011 <vector8>:
.globl vector8
vector8:
  pushl $8
  102011:	6a 08                	push   $0x8
  jmp __alltraps
  102013:	e9 8f ff ff ff       	jmp    101fa7 <__alltraps>

00102018 <vector9>:
.globl vector9
vector9:
  pushl $0
  102018:	6a 00                	push   $0x0
  pushl $9
  10201a:	6a 09                	push   $0x9
  jmp __alltraps
  10201c:	e9 86 ff ff ff       	jmp    101fa7 <__alltraps>

00102021 <vector10>:
.globl vector10
vector10:
  pushl $10
  102021:	6a 0a                	push   $0xa
  jmp __alltraps
  102023:	e9 7f ff ff ff       	jmp    101fa7 <__alltraps>

00102028 <vector11>:
.globl vector11
vector11:
  pushl $11
  102028:	6a 0b                	push   $0xb
  jmp __alltraps
  10202a:	e9 78 ff ff ff       	jmp    101fa7 <__alltraps>

0010202f <vector12>:
.globl vector12
vector12:
  pushl $12
  10202f:	6a 0c                	push   $0xc
  jmp __alltraps
  102031:	e9 71 ff ff ff       	jmp    101fa7 <__alltraps>

00102036 <vector13>:
.globl vector13
vector13:
  pushl $13
  102036:	6a 0d                	push   $0xd
  jmp __alltraps
  102038:	e9 6a ff ff ff       	jmp    101fa7 <__alltraps>

0010203d <vector14>:
.globl vector14
vector14:
  pushl $14
  10203d:	6a 0e                	push   $0xe
  jmp __alltraps
  10203f:	e9 63 ff ff ff       	jmp    101fa7 <__alltraps>

00102044 <vector15>:
.globl vector15
vector15:
  pushl $0
  102044:	6a 00                	push   $0x0
  pushl $15
  102046:	6a 0f                	push   $0xf
  jmp __alltraps
  102048:	e9 5a ff ff ff       	jmp    101fa7 <__alltraps>

0010204d <vector16>:
.globl vector16
vector16:
  pushl $0
  10204d:	6a 00                	push   $0x0
  pushl $16
  10204f:	6a 10                	push   $0x10
  jmp __alltraps
  102051:	e9 51 ff ff ff       	jmp    101fa7 <__alltraps>

00102056 <vector17>:
.globl vector17
vector17:
  pushl $17
  102056:	6a 11                	push   $0x11
  jmp __alltraps
  102058:	e9 4a ff ff ff       	jmp    101fa7 <__alltraps>

0010205d <vector18>:
.globl vector18
vector18:
  pushl $0
  10205d:	6a 00                	push   $0x0
  pushl $18
  10205f:	6a 12                	push   $0x12
  jmp __alltraps
  102061:	e9 41 ff ff ff       	jmp    101fa7 <__alltraps>

00102066 <vector19>:
.globl vector19
vector19:
  pushl $0
  102066:	6a 00                	push   $0x0
  pushl $19
  102068:	6a 13                	push   $0x13
  jmp __alltraps
  10206a:	e9 38 ff ff ff       	jmp    101fa7 <__alltraps>

0010206f <vector20>:
.globl vector20
vector20:
  pushl $0
  10206f:	6a 00                	push   $0x0
  pushl $20
  102071:	6a 14                	push   $0x14
  jmp __alltraps
  102073:	e9 2f ff ff ff       	jmp    101fa7 <__alltraps>

00102078 <vector21>:
.globl vector21
vector21:
  pushl $0
  102078:	6a 00                	push   $0x0
  pushl $21
  10207a:	6a 15                	push   $0x15
  jmp __alltraps
  10207c:	e9 26 ff ff ff       	jmp    101fa7 <__alltraps>

00102081 <vector22>:
.globl vector22
vector22:
  pushl $0
  102081:	6a 00                	push   $0x0
  pushl $22
  102083:	6a 16                	push   $0x16
  jmp __alltraps
  102085:	e9 1d ff ff ff       	jmp    101fa7 <__alltraps>

0010208a <vector23>:
.globl vector23
vector23:
  pushl $0
  10208a:	6a 00                	push   $0x0
  pushl $23
  10208c:	6a 17                	push   $0x17
  jmp __alltraps
  10208e:	e9 14 ff ff ff       	jmp    101fa7 <__alltraps>

00102093 <vector24>:
.globl vector24
vector24:
  pushl $0
  102093:	6a 00                	push   $0x0
  pushl $24
  102095:	6a 18                	push   $0x18
  jmp __alltraps
  102097:	e9 0b ff ff ff       	jmp    101fa7 <__alltraps>

0010209c <vector25>:
.globl vector25
vector25:
  pushl $0
  10209c:	6a 00                	push   $0x0
  pushl $25
  10209e:	6a 19                	push   $0x19
  jmp __alltraps
  1020a0:	e9 02 ff ff ff       	jmp    101fa7 <__alltraps>

001020a5 <vector26>:
.globl vector26
vector26:
  pushl $0
  1020a5:	6a 00                	push   $0x0
  pushl $26
  1020a7:	6a 1a                	push   $0x1a
  jmp __alltraps
  1020a9:	e9 f9 fe ff ff       	jmp    101fa7 <__alltraps>

001020ae <vector27>:
.globl vector27
vector27:
  pushl $0
  1020ae:	6a 00                	push   $0x0
  pushl $27
  1020b0:	6a 1b                	push   $0x1b
  jmp __alltraps
  1020b2:	e9 f0 fe ff ff       	jmp    101fa7 <__alltraps>

001020b7 <vector28>:
.globl vector28
vector28:
  pushl $0
  1020b7:	6a 00                	push   $0x0
  pushl $28
  1020b9:	6a 1c                	push   $0x1c
  jmp __alltraps
  1020bb:	e9 e7 fe ff ff       	jmp    101fa7 <__alltraps>

001020c0 <vector29>:
.globl vector29
vector29:
  pushl $0
  1020c0:	6a 00                	push   $0x0
  pushl $29
  1020c2:	6a 1d                	push   $0x1d
  jmp __alltraps
  1020c4:	e9 de fe ff ff       	jmp    101fa7 <__alltraps>

001020c9 <vector30>:
.globl vector30
vector30:
  pushl $0
  1020c9:	6a 00                	push   $0x0
  pushl $30
  1020cb:	6a 1e                	push   $0x1e
  jmp __alltraps
  1020cd:	e9 d5 fe ff ff       	jmp    101fa7 <__alltraps>

001020d2 <vector31>:
.globl vector31
vector31:
  pushl $0
  1020d2:	6a 00                	push   $0x0
  pushl $31
  1020d4:	6a 1f                	push   $0x1f
  jmp __alltraps
  1020d6:	e9 cc fe ff ff       	jmp    101fa7 <__alltraps>

001020db <vector32>:
.globl vector32
vector32:
  pushl $0
  1020db:	6a 00                	push   $0x0
  pushl $32
  1020dd:	6a 20                	push   $0x20
  jmp __alltraps
  1020df:	e9 c3 fe ff ff       	jmp    101fa7 <__alltraps>

001020e4 <vector33>:
.globl vector33
vector33:
  pushl $0
  1020e4:	6a 00                	push   $0x0
  pushl $33
  1020e6:	6a 21                	push   $0x21
  jmp __alltraps
  1020e8:	e9 ba fe ff ff       	jmp    101fa7 <__alltraps>

001020ed <vector34>:
.globl vector34
vector34:
  pushl $0
  1020ed:	6a 00                	push   $0x0
  pushl $34
  1020ef:	6a 22                	push   $0x22
  jmp __alltraps
  1020f1:	e9 b1 fe ff ff       	jmp    101fa7 <__alltraps>

001020f6 <vector35>:
.globl vector35
vector35:
  pushl $0
  1020f6:	6a 00                	push   $0x0
  pushl $35
  1020f8:	6a 23                	push   $0x23
  jmp __alltraps
  1020fa:	e9 a8 fe ff ff       	jmp    101fa7 <__alltraps>

001020ff <vector36>:
.globl vector36
vector36:
  pushl $0
  1020ff:	6a 00                	push   $0x0
  pushl $36
  102101:	6a 24                	push   $0x24
  jmp __alltraps
  102103:	e9 9f fe ff ff       	jmp    101fa7 <__alltraps>

00102108 <vector37>:
.globl vector37
vector37:
  pushl $0
  102108:	6a 00                	push   $0x0
  pushl $37
  10210a:	6a 25                	push   $0x25
  jmp __alltraps
  10210c:	e9 96 fe ff ff       	jmp    101fa7 <__alltraps>

00102111 <vector38>:
.globl vector38
vector38:
  pushl $0
  102111:	6a 00                	push   $0x0
  pushl $38
  102113:	6a 26                	push   $0x26
  jmp __alltraps
  102115:	e9 8d fe ff ff       	jmp    101fa7 <__alltraps>

0010211a <vector39>:
.globl vector39
vector39:
  pushl $0
  10211a:	6a 00                	push   $0x0
  pushl $39
  10211c:	6a 27                	push   $0x27
  jmp __alltraps
  10211e:	e9 84 fe ff ff       	jmp    101fa7 <__alltraps>

00102123 <vector40>:
.globl vector40
vector40:
  pushl $0
  102123:	6a 00                	push   $0x0
  pushl $40
  102125:	6a 28                	push   $0x28
  jmp __alltraps
  102127:	e9 7b fe ff ff       	jmp    101fa7 <__alltraps>

0010212c <vector41>:
.globl vector41
vector41:
  pushl $0
  10212c:	6a 00                	push   $0x0
  pushl $41
  10212e:	6a 29                	push   $0x29
  jmp __alltraps
  102130:	e9 72 fe ff ff       	jmp    101fa7 <__alltraps>

00102135 <vector42>:
.globl vector42
vector42:
  pushl $0
  102135:	6a 00                	push   $0x0
  pushl $42
  102137:	6a 2a                	push   $0x2a
  jmp __alltraps
  102139:	e9 69 fe ff ff       	jmp    101fa7 <__alltraps>

0010213e <vector43>:
.globl vector43
vector43:
  pushl $0
  10213e:	6a 00                	push   $0x0
  pushl $43
  102140:	6a 2b                	push   $0x2b
  jmp __alltraps
  102142:	e9 60 fe ff ff       	jmp    101fa7 <__alltraps>

00102147 <vector44>:
.globl vector44
vector44:
  pushl $0
  102147:	6a 00                	push   $0x0
  pushl $44
  102149:	6a 2c                	push   $0x2c
  jmp __alltraps
  10214b:	e9 57 fe ff ff       	jmp    101fa7 <__alltraps>

00102150 <vector45>:
.globl vector45
vector45:
  pushl $0
  102150:	6a 00                	push   $0x0
  pushl $45
  102152:	6a 2d                	push   $0x2d
  jmp __alltraps
  102154:	e9 4e fe ff ff       	jmp    101fa7 <__alltraps>

00102159 <vector46>:
.globl vector46
vector46:
  pushl $0
  102159:	6a 00                	push   $0x0
  pushl $46
  10215b:	6a 2e                	push   $0x2e
  jmp __alltraps
  10215d:	e9 45 fe ff ff       	jmp    101fa7 <__alltraps>

00102162 <vector47>:
.globl vector47
vector47:
  pushl $0
  102162:	6a 00                	push   $0x0
  pushl $47
  102164:	6a 2f                	push   $0x2f
  jmp __alltraps
  102166:	e9 3c fe ff ff       	jmp    101fa7 <__alltraps>

0010216b <vector48>:
.globl vector48
vector48:
  pushl $0
  10216b:	6a 00                	push   $0x0
  pushl $48
  10216d:	6a 30                	push   $0x30
  jmp __alltraps
  10216f:	e9 33 fe ff ff       	jmp    101fa7 <__alltraps>

00102174 <vector49>:
.globl vector49
vector49:
  pushl $0
  102174:	6a 00                	push   $0x0
  pushl $49
  102176:	6a 31                	push   $0x31
  jmp __alltraps
  102178:	e9 2a fe ff ff       	jmp    101fa7 <__alltraps>

0010217d <vector50>:
.globl vector50
vector50:
  pushl $0
  10217d:	6a 00                	push   $0x0
  pushl $50
  10217f:	6a 32                	push   $0x32
  jmp __alltraps
  102181:	e9 21 fe ff ff       	jmp    101fa7 <__alltraps>

00102186 <vector51>:
.globl vector51
vector51:
  pushl $0
  102186:	6a 00                	push   $0x0
  pushl $51
  102188:	6a 33                	push   $0x33
  jmp __alltraps
  10218a:	e9 18 fe ff ff       	jmp    101fa7 <__alltraps>

0010218f <vector52>:
.globl vector52
vector52:
  pushl $0
  10218f:	6a 00                	push   $0x0
  pushl $52
  102191:	6a 34                	push   $0x34
  jmp __alltraps
  102193:	e9 0f fe ff ff       	jmp    101fa7 <__alltraps>

00102198 <vector53>:
.globl vector53
vector53:
  pushl $0
  102198:	6a 00                	push   $0x0
  pushl $53
  10219a:	6a 35                	push   $0x35
  jmp __alltraps
  10219c:	e9 06 fe ff ff       	jmp    101fa7 <__alltraps>

001021a1 <vector54>:
.globl vector54
vector54:
  pushl $0
  1021a1:	6a 00                	push   $0x0
  pushl $54
  1021a3:	6a 36                	push   $0x36
  jmp __alltraps
  1021a5:	e9 fd fd ff ff       	jmp    101fa7 <__alltraps>

001021aa <vector55>:
.globl vector55
vector55:
  pushl $0
  1021aa:	6a 00                	push   $0x0
  pushl $55
  1021ac:	6a 37                	push   $0x37
  jmp __alltraps
  1021ae:	e9 f4 fd ff ff       	jmp    101fa7 <__alltraps>

001021b3 <vector56>:
.globl vector56
vector56:
  pushl $0
  1021b3:	6a 00                	push   $0x0
  pushl $56
  1021b5:	6a 38                	push   $0x38
  jmp __alltraps
  1021b7:	e9 eb fd ff ff       	jmp    101fa7 <__alltraps>

001021bc <vector57>:
.globl vector57
vector57:
  pushl $0
  1021bc:	6a 00                	push   $0x0
  pushl $57
  1021be:	6a 39                	push   $0x39
  jmp __alltraps
  1021c0:	e9 e2 fd ff ff       	jmp    101fa7 <__alltraps>

001021c5 <vector58>:
.globl vector58
vector58:
  pushl $0
  1021c5:	6a 00                	push   $0x0
  pushl $58
  1021c7:	6a 3a                	push   $0x3a
  jmp __alltraps
  1021c9:	e9 d9 fd ff ff       	jmp    101fa7 <__alltraps>

001021ce <vector59>:
.globl vector59
vector59:
  pushl $0
  1021ce:	6a 00                	push   $0x0
  pushl $59
  1021d0:	6a 3b                	push   $0x3b
  jmp __alltraps
  1021d2:	e9 d0 fd ff ff       	jmp    101fa7 <__alltraps>

001021d7 <vector60>:
.globl vector60
vector60:
  pushl $0
  1021d7:	6a 00                	push   $0x0
  pushl $60
  1021d9:	6a 3c                	push   $0x3c
  jmp __alltraps
  1021db:	e9 c7 fd ff ff       	jmp    101fa7 <__alltraps>

001021e0 <vector61>:
.globl vector61
vector61:
  pushl $0
  1021e0:	6a 00                	push   $0x0
  pushl $61
  1021e2:	6a 3d                	push   $0x3d
  jmp __alltraps
  1021e4:	e9 be fd ff ff       	jmp    101fa7 <__alltraps>

001021e9 <vector62>:
.globl vector62
vector62:
  pushl $0
  1021e9:	6a 00                	push   $0x0
  pushl $62
  1021eb:	6a 3e                	push   $0x3e
  jmp __alltraps
  1021ed:	e9 b5 fd ff ff       	jmp    101fa7 <__alltraps>

001021f2 <vector63>:
.globl vector63
vector63:
  pushl $0
  1021f2:	6a 00                	push   $0x0
  pushl $63
  1021f4:	6a 3f                	push   $0x3f
  jmp __alltraps
  1021f6:	e9 ac fd ff ff       	jmp    101fa7 <__alltraps>

001021fb <vector64>:
.globl vector64
vector64:
  pushl $0
  1021fb:	6a 00                	push   $0x0
  pushl $64
  1021fd:	6a 40                	push   $0x40
  jmp __alltraps
  1021ff:	e9 a3 fd ff ff       	jmp    101fa7 <__alltraps>

00102204 <vector65>:
.globl vector65
vector65:
  pushl $0
  102204:	6a 00                	push   $0x0
  pushl $65
  102206:	6a 41                	push   $0x41
  jmp __alltraps
  102208:	e9 9a fd ff ff       	jmp    101fa7 <__alltraps>

0010220d <vector66>:
.globl vector66
vector66:
  pushl $0
  10220d:	6a 00                	push   $0x0
  pushl $66
  10220f:	6a 42                	push   $0x42
  jmp __alltraps
  102211:	e9 91 fd ff ff       	jmp    101fa7 <__alltraps>

00102216 <vector67>:
.globl vector67
vector67:
  pushl $0
  102216:	6a 00                	push   $0x0
  pushl $67
  102218:	6a 43                	push   $0x43
  jmp __alltraps
  10221a:	e9 88 fd ff ff       	jmp    101fa7 <__alltraps>

0010221f <vector68>:
.globl vector68
vector68:
  pushl $0
  10221f:	6a 00                	push   $0x0
  pushl $68
  102221:	6a 44                	push   $0x44
  jmp __alltraps
  102223:	e9 7f fd ff ff       	jmp    101fa7 <__alltraps>

00102228 <vector69>:
.globl vector69
vector69:
  pushl $0
  102228:	6a 00                	push   $0x0
  pushl $69
  10222a:	6a 45                	push   $0x45
  jmp __alltraps
  10222c:	e9 76 fd ff ff       	jmp    101fa7 <__alltraps>

00102231 <vector70>:
.globl vector70
vector70:
  pushl $0
  102231:	6a 00                	push   $0x0
  pushl $70
  102233:	6a 46                	push   $0x46
  jmp __alltraps
  102235:	e9 6d fd ff ff       	jmp    101fa7 <__alltraps>

0010223a <vector71>:
.globl vector71
vector71:
  pushl $0
  10223a:	6a 00                	push   $0x0
  pushl $71
  10223c:	6a 47                	push   $0x47
  jmp __alltraps
  10223e:	e9 64 fd ff ff       	jmp    101fa7 <__alltraps>

00102243 <vector72>:
.globl vector72
vector72:
  pushl $0
  102243:	6a 00                	push   $0x0
  pushl $72
  102245:	6a 48                	push   $0x48
  jmp __alltraps
  102247:	e9 5b fd ff ff       	jmp    101fa7 <__alltraps>

0010224c <vector73>:
.globl vector73
vector73:
  pushl $0
  10224c:	6a 00                	push   $0x0
  pushl $73
  10224e:	6a 49                	push   $0x49
  jmp __alltraps
  102250:	e9 52 fd ff ff       	jmp    101fa7 <__alltraps>

00102255 <vector74>:
.globl vector74
vector74:
  pushl $0
  102255:	6a 00                	push   $0x0
  pushl $74
  102257:	6a 4a                	push   $0x4a
  jmp __alltraps
  102259:	e9 49 fd ff ff       	jmp    101fa7 <__alltraps>

0010225e <vector75>:
.globl vector75
vector75:
  pushl $0
  10225e:	6a 00                	push   $0x0
  pushl $75
  102260:	6a 4b                	push   $0x4b
  jmp __alltraps
  102262:	e9 40 fd ff ff       	jmp    101fa7 <__alltraps>

00102267 <vector76>:
.globl vector76
vector76:
  pushl $0
  102267:	6a 00                	push   $0x0
  pushl $76
  102269:	6a 4c                	push   $0x4c
  jmp __alltraps
  10226b:	e9 37 fd ff ff       	jmp    101fa7 <__alltraps>

00102270 <vector77>:
.globl vector77
vector77:
  pushl $0
  102270:	6a 00                	push   $0x0
  pushl $77
  102272:	6a 4d                	push   $0x4d
  jmp __alltraps
  102274:	e9 2e fd ff ff       	jmp    101fa7 <__alltraps>

00102279 <vector78>:
.globl vector78
vector78:
  pushl $0
  102279:	6a 00                	push   $0x0
  pushl $78
  10227b:	6a 4e                	push   $0x4e
  jmp __alltraps
  10227d:	e9 25 fd ff ff       	jmp    101fa7 <__alltraps>

00102282 <vector79>:
.globl vector79
vector79:
  pushl $0
  102282:	6a 00                	push   $0x0
  pushl $79
  102284:	6a 4f                	push   $0x4f
  jmp __alltraps
  102286:	e9 1c fd ff ff       	jmp    101fa7 <__alltraps>

0010228b <vector80>:
.globl vector80
vector80:
  pushl $0
  10228b:	6a 00                	push   $0x0
  pushl $80
  10228d:	6a 50                	push   $0x50
  jmp __alltraps
  10228f:	e9 13 fd ff ff       	jmp    101fa7 <__alltraps>

00102294 <vector81>:
.globl vector81
vector81:
  pushl $0
  102294:	6a 00                	push   $0x0
  pushl $81
  102296:	6a 51                	push   $0x51
  jmp __alltraps
  102298:	e9 0a fd ff ff       	jmp    101fa7 <__alltraps>

0010229d <vector82>:
.globl vector82
vector82:
  pushl $0
  10229d:	6a 00                	push   $0x0
  pushl $82
  10229f:	6a 52                	push   $0x52
  jmp __alltraps
  1022a1:	e9 01 fd ff ff       	jmp    101fa7 <__alltraps>

001022a6 <vector83>:
.globl vector83
vector83:
  pushl $0
  1022a6:	6a 00                	push   $0x0
  pushl $83
  1022a8:	6a 53                	push   $0x53
  jmp __alltraps
  1022aa:	e9 f8 fc ff ff       	jmp    101fa7 <__alltraps>

001022af <vector84>:
.globl vector84
vector84:
  pushl $0
  1022af:	6a 00                	push   $0x0
  pushl $84
  1022b1:	6a 54                	push   $0x54
  jmp __alltraps
  1022b3:	e9 ef fc ff ff       	jmp    101fa7 <__alltraps>

001022b8 <vector85>:
.globl vector85
vector85:
  pushl $0
  1022b8:	6a 00                	push   $0x0
  pushl $85
  1022ba:	6a 55                	push   $0x55
  jmp __alltraps
  1022bc:	e9 e6 fc ff ff       	jmp    101fa7 <__alltraps>

001022c1 <vector86>:
.globl vector86
vector86:
  pushl $0
  1022c1:	6a 00                	push   $0x0
  pushl $86
  1022c3:	6a 56                	push   $0x56
  jmp __alltraps
  1022c5:	e9 dd fc ff ff       	jmp    101fa7 <__alltraps>

001022ca <vector87>:
.globl vector87
vector87:
  pushl $0
  1022ca:	6a 00                	push   $0x0
  pushl $87
  1022cc:	6a 57                	push   $0x57
  jmp __alltraps
  1022ce:	e9 d4 fc ff ff       	jmp    101fa7 <__alltraps>

001022d3 <vector88>:
.globl vector88
vector88:
  pushl $0
  1022d3:	6a 00                	push   $0x0
  pushl $88
  1022d5:	6a 58                	push   $0x58
  jmp __alltraps
  1022d7:	e9 cb fc ff ff       	jmp    101fa7 <__alltraps>

001022dc <vector89>:
.globl vector89
vector89:
  pushl $0
  1022dc:	6a 00                	push   $0x0
  pushl $89
  1022de:	6a 59                	push   $0x59
  jmp __alltraps
  1022e0:	e9 c2 fc ff ff       	jmp    101fa7 <__alltraps>

001022e5 <vector90>:
.globl vector90
vector90:
  pushl $0
  1022e5:	6a 00                	push   $0x0
  pushl $90
  1022e7:	6a 5a                	push   $0x5a
  jmp __alltraps
  1022e9:	e9 b9 fc ff ff       	jmp    101fa7 <__alltraps>

001022ee <vector91>:
.globl vector91
vector91:
  pushl $0
  1022ee:	6a 00                	push   $0x0
  pushl $91
  1022f0:	6a 5b                	push   $0x5b
  jmp __alltraps
  1022f2:	e9 b0 fc ff ff       	jmp    101fa7 <__alltraps>

001022f7 <vector92>:
.globl vector92
vector92:
  pushl $0
  1022f7:	6a 00                	push   $0x0
  pushl $92
  1022f9:	6a 5c                	push   $0x5c
  jmp __alltraps
  1022fb:	e9 a7 fc ff ff       	jmp    101fa7 <__alltraps>

00102300 <vector93>:
.globl vector93
vector93:
  pushl $0
  102300:	6a 00                	push   $0x0
  pushl $93
  102302:	6a 5d                	push   $0x5d
  jmp __alltraps
  102304:	e9 9e fc ff ff       	jmp    101fa7 <__alltraps>

00102309 <vector94>:
.globl vector94
vector94:
  pushl $0
  102309:	6a 00                	push   $0x0
  pushl $94
  10230b:	6a 5e                	push   $0x5e
  jmp __alltraps
  10230d:	e9 95 fc ff ff       	jmp    101fa7 <__alltraps>

00102312 <vector95>:
.globl vector95
vector95:
  pushl $0
  102312:	6a 00                	push   $0x0
  pushl $95
  102314:	6a 5f                	push   $0x5f
  jmp __alltraps
  102316:	e9 8c fc ff ff       	jmp    101fa7 <__alltraps>

0010231b <vector96>:
.globl vector96
vector96:
  pushl $0
  10231b:	6a 00                	push   $0x0
  pushl $96
  10231d:	6a 60                	push   $0x60
  jmp __alltraps
  10231f:	e9 83 fc ff ff       	jmp    101fa7 <__alltraps>

00102324 <vector97>:
.globl vector97
vector97:
  pushl $0
  102324:	6a 00                	push   $0x0
  pushl $97
  102326:	6a 61                	push   $0x61
  jmp __alltraps
  102328:	e9 7a fc ff ff       	jmp    101fa7 <__alltraps>

0010232d <vector98>:
.globl vector98
vector98:
  pushl $0
  10232d:	6a 00                	push   $0x0
  pushl $98
  10232f:	6a 62                	push   $0x62
  jmp __alltraps
  102331:	e9 71 fc ff ff       	jmp    101fa7 <__alltraps>

00102336 <vector99>:
.globl vector99
vector99:
  pushl $0
  102336:	6a 00                	push   $0x0
  pushl $99
  102338:	6a 63                	push   $0x63
  jmp __alltraps
  10233a:	e9 68 fc ff ff       	jmp    101fa7 <__alltraps>

0010233f <vector100>:
.globl vector100
vector100:
  pushl $0
  10233f:	6a 00                	push   $0x0
  pushl $100
  102341:	6a 64                	push   $0x64
  jmp __alltraps
  102343:	e9 5f fc ff ff       	jmp    101fa7 <__alltraps>

00102348 <vector101>:
.globl vector101
vector101:
  pushl $0
  102348:	6a 00                	push   $0x0
  pushl $101
  10234a:	6a 65                	push   $0x65
  jmp __alltraps
  10234c:	e9 56 fc ff ff       	jmp    101fa7 <__alltraps>

00102351 <vector102>:
.globl vector102
vector102:
  pushl $0
  102351:	6a 00                	push   $0x0
  pushl $102
  102353:	6a 66                	push   $0x66
  jmp __alltraps
  102355:	e9 4d fc ff ff       	jmp    101fa7 <__alltraps>

0010235a <vector103>:
.globl vector103
vector103:
  pushl $0
  10235a:	6a 00                	push   $0x0
  pushl $103
  10235c:	6a 67                	push   $0x67
  jmp __alltraps
  10235e:	e9 44 fc ff ff       	jmp    101fa7 <__alltraps>

00102363 <vector104>:
.globl vector104
vector104:
  pushl $0
  102363:	6a 00                	push   $0x0
  pushl $104
  102365:	6a 68                	push   $0x68
  jmp __alltraps
  102367:	e9 3b fc ff ff       	jmp    101fa7 <__alltraps>

0010236c <vector105>:
.globl vector105
vector105:
  pushl $0
  10236c:	6a 00                	push   $0x0
  pushl $105
  10236e:	6a 69                	push   $0x69
  jmp __alltraps
  102370:	e9 32 fc ff ff       	jmp    101fa7 <__alltraps>

00102375 <vector106>:
.globl vector106
vector106:
  pushl $0
  102375:	6a 00                	push   $0x0
  pushl $106
  102377:	6a 6a                	push   $0x6a
  jmp __alltraps
  102379:	e9 29 fc ff ff       	jmp    101fa7 <__alltraps>

0010237e <vector107>:
.globl vector107
vector107:
  pushl $0
  10237e:	6a 00                	push   $0x0
  pushl $107
  102380:	6a 6b                	push   $0x6b
  jmp __alltraps
  102382:	e9 20 fc ff ff       	jmp    101fa7 <__alltraps>

00102387 <vector108>:
.globl vector108
vector108:
  pushl $0
  102387:	6a 00                	push   $0x0
  pushl $108
  102389:	6a 6c                	push   $0x6c
  jmp __alltraps
  10238b:	e9 17 fc ff ff       	jmp    101fa7 <__alltraps>

00102390 <vector109>:
.globl vector109
vector109:
  pushl $0
  102390:	6a 00                	push   $0x0
  pushl $109
  102392:	6a 6d                	push   $0x6d
  jmp __alltraps
  102394:	e9 0e fc ff ff       	jmp    101fa7 <__alltraps>

00102399 <vector110>:
.globl vector110
vector110:
  pushl $0
  102399:	6a 00                	push   $0x0
  pushl $110
  10239b:	6a 6e                	push   $0x6e
  jmp __alltraps
  10239d:	e9 05 fc ff ff       	jmp    101fa7 <__alltraps>

001023a2 <vector111>:
.globl vector111
vector111:
  pushl $0
  1023a2:	6a 00                	push   $0x0
  pushl $111
  1023a4:	6a 6f                	push   $0x6f
  jmp __alltraps
  1023a6:	e9 fc fb ff ff       	jmp    101fa7 <__alltraps>

001023ab <vector112>:
.globl vector112
vector112:
  pushl $0
  1023ab:	6a 00                	push   $0x0
  pushl $112
  1023ad:	6a 70                	push   $0x70
  jmp __alltraps
  1023af:	e9 f3 fb ff ff       	jmp    101fa7 <__alltraps>

001023b4 <vector113>:
.globl vector113
vector113:
  pushl $0
  1023b4:	6a 00                	push   $0x0
  pushl $113
  1023b6:	6a 71                	push   $0x71
  jmp __alltraps
  1023b8:	e9 ea fb ff ff       	jmp    101fa7 <__alltraps>

001023bd <vector114>:
.globl vector114
vector114:
  pushl $0
  1023bd:	6a 00                	push   $0x0
  pushl $114
  1023bf:	6a 72                	push   $0x72
  jmp __alltraps
  1023c1:	e9 e1 fb ff ff       	jmp    101fa7 <__alltraps>

001023c6 <vector115>:
.globl vector115
vector115:
  pushl $0
  1023c6:	6a 00                	push   $0x0
  pushl $115
  1023c8:	6a 73                	push   $0x73
  jmp __alltraps
  1023ca:	e9 d8 fb ff ff       	jmp    101fa7 <__alltraps>

001023cf <vector116>:
.globl vector116
vector116:
  pushl $0
  1023cf:	6a 00                	push   $0x0
  pushl $116
  1023d1:	6a 74                	push   $0x74
  jmp __alltraps
  1023d3:	e9 cf fb ff ff       	jmp    101fa7 <__alltraps>

001023d8 <vector117>:
.globl vector117
vector117:
  pushl $0
  1023d8:	6a 00                	push   $0x0
  pushl $117
  1023da:	6a 75                	push   $0x75
  jmp __alltraps
  1023dc:	e9 c6 fb ff ff       	jmp    101fa7 <__alltraps>

001023e1 <vector118>:
.globl vector118
vector118:
  pushl $0
  1023e1:	6a 00                	push   $0x0
  pushl $118
  1023e3:	6a 76                	push   $0x76
  jmp __alltraps
  1023e5:	e9 bd fb ff ff       	jmp    101fa7 <__alltraps>

001023ea <vector119>:
.globl vector119
vector119:
  pushl $0
  1023ea:	6a 00                	push   $0x0
  pushl $119
  1023ec:	6a 77                	push   $0x77
  jmp __alltraps
  1023ee:	e9 b4 fb ff ff       	jmp    101fa7 <__alltraps>

001023f3 <vector120>:
.globl vector120
vector120:
  pushl $0
  1023f3:	6a 00                	push   $0x0
  pushl $120
  1023f5:	6a 78                	push   $0x78
  jmp __alltraps
  1023f7:	e9 ab fb ff ff       	jmp    101fa7 <__alltraps>

001023fc <vector121>:
.globl vector121
vector121:
  pushl $0
  1023fc:	6a 00                	push   $0x0
  pushl $121
  1023fe:	6a 79                	push   $0x79
  jmp __alltraps
  102400:	e9 a2 fb ff ff       	jmp    101fa7 <__alltraps>

00102405 <vector122>:
.globl vector122
vector122:
  pushl $0
  102405:	6a 00                	push   $0x0
  pushl $122
  102407:	6a 7a                	push   $0x7a
  jmp __alltraps
  102409:	e9 99 fb ff ff       	jmp    101fa7 <__alltraps>

0010240e <vector123>:
.globl vector123
vector123:
  pushl $0
  10240e:	6a 00                	push   $0x0
  pushl $123
  102410:	6a 7b                	push   $0x7b
  jmp __alltraps
  102412:	e9 90 fb ff ff       	jmp    101fa7 <__alltraps>

00102417 <vector124>:
.globl vector124
vector124:
  pushl $0
  102417:	6a 00                	push   $0x0
  pushl $124
  102419:	6a 7c                	push   $0x7c
  jmp __alltraps
  10241b:	e9 87 fb ff ff       	jmp    101fa7 <__alltraps>

00102420 <vector125>:
.globl vector125
vector125:
  pushl $0
  102420:	6a 00                	push   $0x0
  pushl $125
  102422:	6a 7d                	push   $0x7d
  jmp __alltraps
  102424:	e9 7e fb ff ff       	jmp    101fa7 <__alltraps>

00102429 <vector126>:
.globl vector126
vector126:
  pushl $0
  102429:	6a 00                	push   $0x0
  pushl $126
  10242b:	6a 7e                	push   $0x7e
  jmp __alltraps
  10242d:	e9 75 fb ff ff       	jmp    101fa7 <__alltraps>

00102432 <vector127>:
.globl vector127
vector127:
  pushl $0
  102432:	6a 00                	push   $0x0
  pushl $127
  102434:	6a 7f                	push   $0x7f
  jmp __alltraps
  102436:	e9 6c fb ff ff       	jmp    101fa7 <__alltraps>

0010243b <vector128>:
.globl vector128
vector128:
  pushl $0
  10243b:	6a 00                	push   $0x0
  pushl $128
  10243d:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102442:	e9 60 fb ff ff       	jmp    101fa7 <__alltraps>

00102447 <vector129>:
.globl vector129
vector129:
  pushl $0
  102447:	6a 00                	push   $0x0
  pushl $129
  102449:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  10244e:	e9 54 fb ff ff       	jmp    101fa7 <__alltraps>

00102453 <vector130>:
.globl vector130
vector130:
  pushl $0
  102453:	6a 00                	push   $0x0
  pushl $130
  102455:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10245a:	e9 48 fb ff ff       	jmp    101fa7 <__alltraps>

0010245f <vector131>:
.globl vector131
vector131:
  pushl $0
  10245f:	6a 00                	push   $0x0
  pushl $131
  102461:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102466:	e9 3c fb ff ff       	jmp    101fa7 <__alltraps>

0010246b <vector132>:
.globl vector132
vector132:
  pushl $0
  10246b:	6a 00                	push   $0x0
  pushl $132
  10246d:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102472:	e9 30 fb ff ff       	jmp    101fa7 <__alltraps>

00102477 <vector133>:
.globl vector133
vector133:
  pushl $0
  102477:	6a 00                	push   $0x0
  pushl $133
  102479:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10247e:	e9 24 fb ff ff       	jmp    101fa7 <__alltraps>

00102483 <vector134>:
.globl vector134
vector134:
  pushl $0
  102483:	6a 00                	push   $0x0
  pushl $134
  102485:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10248a:	e9 18 fb ff ff       	jmp    101fa7 <__alltraps>

0010248f <vector135>:
.globl vector135
vector135:
  pushl $0
  10248f:	6a 00                	push   $0x0
  pushl $135
  102491:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102496:	e9 0c fb ff ff       	jmp    101fa7 <__alltraps>

0010249b <vector136>:
.globl vector136
vector136:
  pushl $0
  10249b:	6a 00                	push   $0x0
  pushl $136
  10249d:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1024a2:	e9 00 fb ff ff       	jmp    101fa7 <__alltraps>

001024a7 <vector137>:
.globl vector137
vector137:
  pushl $0
  1024a7:	6a 00                	push   $0x0
  pushl $137
  1024a9:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1024ae:	e9 f4 fa ff ff       	jmp    101fa7 <__alltraps>

001024b3 <vector138>:
.globl vector138
vector138:
  pushl $0
  1024b3:	6a 00                	push   $0x0
  pushl $138
  1024b5:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1024ba:	e9 e8 fa ff ff       	jmp    101fa7 <__alltraps>

001024bf <vector139>:
.globl vector139
vector139:
  pushl $0
  1024bf:	6a 00                	push   $0x0
  pushl $139
  1024c1:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1024c6:	e9 dc fa ff ff       	jmp    101fa7 <__alltraps>

001024cb <vector140>:
.globl vector140
vector140:
  pushl $0
  1024cb:	6a 00                	push   $0x0
  pushl $140
  1024cd:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1024d2:	e9 d0 fa ff ff       	jmp    101fa7 <__alltraps>

001024d7 <vector141>:
.globl vector141
vector141:
  pushl $0
  1024d7:	6a 00                	push   $0x0
  pushl $141
  1024d9:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1024de:	e9 c4 fa ff ff       	jmp    101fa7 <__alltraps>

001024e3 <vector142>:
.globl vector142
vector142:
  pushl $0
  1024e3:	6a 00                	push   $0x0
  pushl $142
  1024e5:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1024ea:	e9 b8 fa ff ff       	jmp    101fa7 <__alltraps>

001024ef <vector143>:
.globl vector143
vector143:
  pushl $0
  1024ef:	6a 00                	push   $0x0
  pushl $143
  1024f1:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1024f6:	e9 ac fa ff ff       	jmp    101fa7 <__alltraps>

001024fb <vector144>:
.globl vector144
vector144:
  pushl $0
  1024fb:	6a 00                	push   $0x0
  pushl $144
  1024fd:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102502:	e9 a0 fa ff ff       	jmp    101fa7 <__alltraps>

00102507 <vector145>:
.globl vector145
vector145:
  pushl $0
  102507:	6a 00                	push   $0x0
  pushl $145
  102509:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10250e:	e9 94 fa ff ff       	jmp    101fa7 <__alltraps>

00102513 <vector146>:
.globl vector146
vector146:
  pushl $0
  102513:	6a 00                	push   $0x0
  pushl $146
  102515:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  10251a:	e9 88 fa ff ff       	jmp    101fa7 <__alltraps>

0010251f <vector147>:
.globl vector147
vector147:
  pushl $0
  10251f:	6a 00                	push   $0x0
  pushl $147
  102521:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102526:	e9 7c fa ff ff       	jmp    101fa7 <__alltraps>

0010252b <vector148>:
.globl vector148
vector148:
  pushl $0
  10252b:	6a 00                	push   $0x0
  pushl $148
  10252d:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102532:	e9 70 fa ff ff       	jmp    101fa7 <__alltraps>

00102537 <vector149>:
.globl vector149
vector149:
  pushl $0
  102537:	6a 00                	push   $0x0
  pushl $149
  102539:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  10253e:	e9 64 fa ff ff       	jmp    101fa7 <__alltraps>

00102543 <vector150>:
.globl vector150
vector150:
  pushl $0
  102543:	6a 00                	push   $0x0
  pushl $150
  102545:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10254a:	e9 58 fa ff ff       	jmp    101fa7 <__alltraps>

0010254f <vector151>:
.globl vector151
vector151:
  pushl $0
  10254f:	6a 00                	push   $0x0
  pushl $151
  102551:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102556:	e9 4c fa ff ff       	jmp    101fa7 <__alltraps>

0010255b <vector152>:
.globl vector152
vector152:
  pushl $0
  10255b:	6a 00                	push   $0x0
  pushl $152
  10255d:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102562:	e9 40 fa ff ff       	jmp    101fa7 <__alltraps>

00102567 <vector153>:
.globl vector153
vector153:
  pushl $0
  102567:	6a 00                	push   $0x0
  pushl $153
  102569:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10256e:	e9 34 fa ff ff       	jmp    101fa7 <__alltraps>

00102573 <vector154>:
.globl vector154
vector154:
  pushl $0
  102573:	6a 00                	push   $0x0
  pushl $154
  102575:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10257a:	e9 28 fa ff ff       	jmp    101fa7 <__alltraps>

0010257f <vector155>:
.globl vector155
vector155:
  pushl $0
  10257f:	6a 00                	push   $0x0
  pushl $155
  102581:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102586:	e9 1c fa ff ff       	jmp    101fa7 <__alltraps>

0010258b <vector156>:
.globl vector156
vector156:
  pushl $0
  10258b:	6a 00                	push   $0x0
  pushl $156
  10258d:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102592:	e9 10 fa ff ff       	jmp    101fa7 <__alltraps>

00102597 <vector157>:
.globl vector157
vector157:
  pushl $0
  102597:	6a 00                	push   $0x0
  pushl $157
  102599:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10259e:	e9 04 fa ff ff       	jmp    101fa7 <__alltraps>

001025a3 <vector158>:
.globl vector158
vector158:
  pushl $0
  1025a3:	6a 00                	push   $0x0
  pushl $158
  1025a5:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1025aa:	e9 f8 f9 ff ff       	jmp    101fa7 <__alltraps>

001025af <vector159>:
.globl vector159
vector159:
  pushl $0
  1025af:	6a 00                	push   $0x0
  pushl $159
  1025b1:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1025b6:	e9 ec f9 ff ff       	jmp    101fa7 <__alltraps>

001025bb <vector160>:
.globl vector160
vector160:
  pushl $0
  1025bb:	6a 00                	push   $0x0
  pushl $160
  1025bd:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1025c2:	e9 e0 f9 ff ff       	jmp    101fa7 <__alltraps>

001025c7 <vector161>:
.globl vector161
vector161:
  pushl $0
  1025c7:	6a 00                	push   $0x0
  pushl $161
  1025c9:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1025ce:	e9 d4 f9 ff ff       	jmp    101fa7 <__alltraps>

001025d3 <vector162>:
.globl vector162
vector162:
  pushl $0
  1025d3:	6a 00                	push   $0x0
  pushl $162
  1025d5:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1025da:	e9 c8 f9 ff ff       	jmp    101fa7 <__alltraps>

001025df <vector163>:
.globl vector163
vector163:
  pushl $0
  1025df:	6a 00                	push   $0x0
  pushl $163
  1025e1:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1025e6:	e9 bc f9 ff ff       	jmp    101fa7 <__alltraps>

001025eb <vector164>:
.globl vector164
vector164:
  pushl $0
  1025eb:	6a 00                	push   $0x0
  pushl $164
  1025ed:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1025f2:	e9 b0 f9 ff ff       	jmp    101fa7 <__alltraps>

001025f7 <vector165>:
.globl vector165
vector165:
  pushl $0
  1025f7:	6a 00                	push   $0x0
  pushl $165
  1025f9:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1025fe:	e9 a4 f9 ff ff       	jmp    101fa7 <__alltraps>

00102603 <vector166>:
.globl vector166
vector166:
  pushl $0
  102603:	6a 00                	push   $0x0
  pushl $166
  102605:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  10260a:	e9 98 f9 ff ff       	jmp    101fa7 <__alltraps>

0010260f <vector167>:
.globl vector167
vector167:
  pushl $0
  10260f:	6a 00                	push   $0x0
  pushl $167
  102611:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102616:	e9 8c f9 ff ff       	jmp    101fa7 <__alltraps>

0010261b <vector168>:
.globl vector168
vector168:
  pushl $0
  10261b:	6a 00                	push   $0x0
  pushl $168
  10261d:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  102622:	e9 80 f9 ff ff       	jmp    101fa7 <__alltraps>

00102627 <vector169>:
.globl vector169
vector169:
  pushl $0
  102627:	6a 00                	push   $0x0
  pushl $169
  102629:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  10262e:	e9 74 f9 ff ff       	jmp    101fa7 <__alltraps>

00102633 <vector170>:
.globl vector170
vector170:
  pushl $0
  102633:	6a 00                	push   $0x0
  pushl $170
  102635:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10263a:	e9 68 f9 ff ff       	jmp    101fa7 <__alltraps>

0010263f <vector171>:
.globl vector171
vector171:
  pushl $0
  10263f:	6a 00                	push   $0x0
  pushl $171
  102641:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102646:	e9 5c f9 ff ff       	jmp    101fa7 <__alltraps>

0010264b <vector172>:
.globl vector172
vector172:
  pushl $0
  10264b:	6a 00                	push   $0x0
  pushl $172
  10264d:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102652:	e9 50 f9 ff ff       	jmp    101fa7 <__alltraps>

00102657 <vector173>:
.globl vector173
vector173:
  pushl $0
  102657:	6a 00                	push   $0x0
  pushl $173
  102659:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  10265e:	e9 44 f9 ff ff       	jmp    101fa7 <__alltraps>

00102663 <vector174>:
.globl vector174
vector174:
  pushl $0
  102663:	6a 00                	push   $0x0
  pushl $174
  102665:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  10266a:	e9 38 f9 ff ff       	jmp    101fa7 <__alltraps>

0010266f <vector175>:
.globl vector175
vector175:
  pushl $0
  10266f:	6a 00                	push   $0x0
  pushl $175
  102671:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102676:	e9 2c f9 ff ff       	jmp    101fa7 <__alltraps>

0010267b <vector176>:
.globl vector176
vector176:
  pushl $0
  10267b:	6a 00                	push   $0x0
  pushl $176
  10267d:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102682:	e9 20 f9 ff ff       	jmp    101fa7 <__alltraps>

00102687 <vector177>:
.globl vector177
vector177:
  pushl $0
  102687:	6a 00                	push   $0x0
  pushl $177
  102689:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10268e:	e9 14 f9 ff ff       	jmp    101fa7 <__alltraps>

00102693 <vector178>:
.globl vector178
vector178:
  pushl $0
  102693:	6a 00                	push   $0x0
  pushl $178
  102695:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10269a:	e9 08 f9 ff ff       	jmp    101fa7 <__alltraps>

0010269f <vector179>:
.globl vector179
vector179:
  pushl $0
  10269f:	6a 00                	push   $0x0
  pushl $179
  1026a1:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1026a6:	e9 fc f8 ff ff       	jmp    101fa7 <__alltraps>

001026ab <vector180>:
.globl vector180
vector180:
  pushl $0
  1026ab:	6a 00                	push   $0x0
  pushl $180
  1026ad:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1026b2:	e9 f0 f8 ff ff       	jmp    101fa7 <__alltraps>

001026b7 <vector181>:
.globl vector181
vector181:
  pushl $0
  1026b7:	6a 00                	push   $0x0
  pushl $181
  1026b9:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1026be:	e9 e4 f8 ff ff       	jmp    101fa7 <__alltraps>

001026c3 <vector182>:
.globl vector182
vector182:
  pushl $0
  1026c3:	6a 00                	push   $0x0
  pushl $182
  1026c5:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1026ca:	e9 d8 f8 ff ff       	jmp    101fa7 <__alltraps>

001026cf <vector183>:
.globl vector183
vector183:
  pushl $0
  1026cf:	6a 00                	push   $0x0
  pushl $183
  1026d1:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1026d6:	e9 cc f8 ff ff       	jmp    101fa7 <__alltraps>

001026db <vector184>:
.globl vector184
vector184:
  pushl $0
  1026db:	6a 00                	push   $0x0
  pushl $184
  1026dd:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1026e2:	e9 c0 f8 ff ff       	jmp    101fa7 <__alltraps>

001026e7 <vector185>:
.globl vector185
vector185:
  pushl $0
  1026e7:	6a 00                	push   $0x0
  pushl $185
  1026e9:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1026ee:	e9 b4 f8 ff ff       	jmp    101fa7 <__alltraps>

001026f3 <vector186>:
.globl vector186
vector186:
  pushl $0
  1026f3:	6a 00                	push   $0x0
  pushl $186
  1026f5:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1026fa:	e9 a8 f8 ff ff       	jmp    101fa7 <__alltraps>

001026ff <vector187>:
.globl vector187
vector187:
  pushl $0
  1026ff:	6a 00                	push   $0x0
  pushl $187
  102701:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102706:	e9 9c f8 ff ff       	jmp    101fa7 <__alltraps>

0010270b <vector188>:
.globl vector188
vector188:
  pushl $0
  10270b:	6a 00                	push   $0x0
  pushl $188
  10270d:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102712:	e9 90 f8 ff ff       	jmp    101fa7 <__alltraps>

00102717 <vector189>:
.globl vector189
vector189:
  pushl $0
  102717:	6a 00                	push   $0x0
  pushl $189
  102719:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  10271e:	e9 84 f8 ff ff       	jmp    101fa7 <__alltraps>

00102723 <vector190>:
.globl vector190
vector190:
  pushl $0
  102723:	6a 00                	push   $0x0
  pushl $190
  102725:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  10272a:	e9 78 f8 ff ff       	jmp    101fa7 <__alltraps>

0010272f <vector191>:
.globl vector191
vector191:
  pushl $0
  10272f:	6a 00                	push   $0x0
  pushl $191
  102731:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102736:	e9 6c f8 ff ff       	jmp    101fa7 <__alltraps>

0010273b <vector192>:
.globl vector192
vector192:
  pushl $0
  10273b:	6a 00                	push   $0x0
  pushl $192
  10273d:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102742:	e9 60 f8 ff ff       	jmp    101fa7 <__alltraps>

00102747 <vector193>:
.globl vector193
vector193:
  pushl $0
  102747:	6a 00                	push   $0x0
  pushl $193
  102749:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  10274e:	e9 54 f8 ff ff       	jmp    101fa7 <__alltraps>

00102753 <vector194>:
.globl vector194
vector194:
  pushl $0
  102753:	6a 00                	push   $0x0
  pushl $194
  102755:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10275a:	e9 48 f8 ff ff       	jmp    101fa7 <__alltraps>

0010275f <vector195>:
.globl vector195
vector195:
  pushl $0
  10275f:	6a 00                	push   $0x0
  pushl $195
  102761:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102766:	e9 3c f8 ff ff       	jmp    101fa7 <__alltraps>

0010276b <vector196>:
.globl vector196
vector196:
  pushl $0
  10276b:	6a 00                	push   $0x0
  pushl $196
  10276d:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102772:	e9 30 f8 ff ff       	jmp    101fa7 <__alltraps>

00102777 <vector197>:
.globl vector197
vector197:
  pushl $0
  102777:	6a 00                	push   $0x0
  pushl $197
  102779:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10277e:	e9 24 f8 ff ff       	jmp    101fa7 <__alltraps>

00102783 <vector198>:
.globl vector198
vector198:
  pushl $0
  102783:	6a 00                	push   $0x0
  pushl $198
  102785:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10278a:	e9 18 f8 ff ff       	jmp    101fa7 <__alltraps>

0010278f <vector199>:
.globl vector199
vector199:
  pushl $0
  10278f:	6a 00                	push   $0x0
  pushl $199
  102791:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102796:	e9 0c f8 ff ff       	jmp    101fa7 <__alltraps>

0010279b <vector200>:
.globl vector200
vector200:
  pushl $0
  10279b:	6a 00                	push   $0x0
  pushl $200
  10279d:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1027a2:	e9 00 f8 ff ff       	jmp    101fa7 <__alltraps>

001027a7 <vector201>:
.globl vector201
vector201:
  pushl $0
  1027a7:	6a 00                	push   $0x0
  pushl $201
  1027a9:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1027ae:	e9 f4 f7 ff ff       	jmp    101fa7 <__alltraps>

001027b3 <vector202>:
.globl vector202
vector202:
  pushl $0
  1027b3:	6a 00                	push   $0x0
  pushl $202
  1027b5:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1027ba:	e9 e8 f7 ff ff       	jmp    101fa7 <__alltraps>

001027bf <vector203>:
.globl vector203
vector203:
  pushl $0
  1027bf:	6a 00                	push   $0x0
  pushl $203
  1027c1:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1027c6:	e9 dc f7 ff ff       	jmp    101fa7 <__alltraps>

001027cb <vector204>:
.globl vector204
vector204:
  pushl $0
  1027cb:	6a 00                	push   $0x0
  pushl $204
  1027cd:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1027d2:	e9 d0 f7 ff ff       	jmp    101fa7 <__alltraps>

001027d7 <vector205>:
.globl vector205
vector205:
  pushl $0
  1027d7:	6a 00                	push   $0x0
  pushl $205
  1027d9:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1027de:	e9 c4 f7 ff ff       	jmp    101fa7 <__alltraps>

001027e3 <vector206>:
.globl vector206
vector206:
  pushl $0
  1027e3:	6a 00                	push   $0x0
  pushl $206
  1027e5:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1027ea:	e9 b8 f7 ff ff       	jmp    101fa7 <__alltraps>

001027ef <vector207>:
.globl vector207
vector207:
  pushl $0
  1027ef:	6a 00                	push   $0x0
  pushl $207
  1027f1:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1027f6:	e9 ac f7 ff ff       	jmp    101fa7 <__alltraps>

001027fb <vector208>:
.globl vector208
vector208:
  pushl $0
  1027fb:	6a 00                	push   $0x0
  pushl $208
  1027fd:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102802:	e9 a0 f7 ff ff       	jmp    101fa7 <__alltraps>

00102807 <vector209>:
.globl vector209
vector209:
  pushl $0
  102807:	6a 00                	push   $0x0
  pushl $209
  102809:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10280e:	e9 94 f7 ff ff       	jmp    101fa7 <__alltraps>

00102813 <vector210>:
.globl vector210
vector210:
  pushl $0
  102813:	6a 00                	push   $0x0
  pushl $210
  102815:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  10281a:	e9 88 f7 ff ff       	jmp    101fa7 <__alltraps>

0010281f <vector211>:
.globl vector211
vector211:
  pushl $0
  10281f:	6a 00                	push   $0x0
  pushl $211
  102821:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102826:	e9 7c f7 ff ff       	jmp    101fa7 <__alltraps>

0010282b <vector212>:
.globl vector212
vector212:
  pushl $0
  10282b:	6a 00                	push   $0x0
  pushl $212
  10282d:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102832:	e9 70 f7 ff ff       	jmp    101fa7 <__alltraps>

00102837 <vector213>:
.globl vector213
vector213:
  pushl $0
  102837:	6a 00                	push   $0x0
  pushl $213
  102839:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  10283e:	e9 64 f7 ff ff       	jmp    101fa7 <__alltraps>

00102843 <vector214>:
.globl vector214
vector214:
  pushl $0
  102843:	6a 00                	push   $0x0
  pushl $214
  102845:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10284a:	e9 58 f7 ff ff       	jmp    101fa7 <__alltraps>

0010284f <vector215>:
.globl vector215
vector215:
  pushl $0
  10284f:	6a 00                	push   $0x0
  pushl $215
  102851:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102856:	e9 4c f7 ff ff       	jmp    101fa7 <__alltraps>

0010285b <vector216>:
.globl vector216
vector216:
  pushl $0
  10285b:	6a 00                	push   $0x0
  pushl $216
  10285d:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102862:	e9 40 f7 ff ff       	jmp    101fa7 <__alltraps>

00102867 <vector217>:
.globl vector217
vector217:
  pushl $0
  102867:	6a 00                	push   $0x0
  pushl $217
  102869:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  10286e:	e9 34 f7 ff ff       	jmp    101fa7 <__alltraps>

00102873 <vector218>:
.globl vector218
vector218:
  pushl $0
  102873:	6a 00                	push   $0x0
  pushl $218
  102875:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  10287a:	e9 28 f7 ff ff       	jmp    101fa7 <__alltraps>

0010287f <vector219>:
.globl vector219
vector219:
  pushl $0
  10287f:	6a 00                	push   $0x0
  pushl $219
  102881:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102886:	e9 1c f7 ff ff       	jmp    101fa7 <__alltraps>

0010288b <vector220>:
.globl vector220
vector220:
  pushl $0
  10288b:	6a 00                	push   $0x0
  pushl $220
  10288d:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102892:	e9 10 f7 ff ff       	jmp    101fa7 <__alltraps>

00102897 <vector221>:
.globl vector221
vector221:
  pushl $0
  102897:	6a 00                	push   $0x0
  pushl $221
  102899:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  10289e:	e9 04 f7 ff ff       	jmp    101fa7 <__alltraps>

001028a3 <vector222>:
.globl vector222
vector222:
  pushl $0
  1028a3:	6a 00                	push   $0x0
  pushl $222
  1028a5:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1028aa:	e9 f8 f6 ff ff       	jmp    101fa7 <__alltraps>

001028af <vector223>:
.globl vector223
vector223:
  pushl $0
  1028af:	6a 00                	push   $0x0
  pushl $223
  1028b1:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1028b6:	e9 ec f6 ff ff       	jmp    101fa7 <__alltraps>

001028bb <vector224>:
.globl vector224
vector224:
  pushl $0
  1028bb:	6a 00                	push   $0x0
  pushl $224
  1028bd:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1028c2:	e9 e0 f6 ff ff       	jmp    101fa7 <__alltraps>

001028c7 <vector225>:
.globl vector225
vector225:
  pushl $0
  1028c7:	6a 00                	push   $0x0
  pushl $225
  1028c9:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1028ce:	e9 d4 f6 ff ff       	jmp    101fa7 <__alltraps>

001028d3 <vector226>:
.globl vector226
vector226:
  pushl $0
  1028d3:	6a 00                	push   $0x0
  pushl $226
  1028d5:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1028da:	e9 c8 f6 ff ff       	jmp    101fa7 <__alltraps>

001028df <vector227>:
.globl vector227
vector227:
  pushl $0
  1028df:	6a 00                	push   $0x0
  pushl $227
  1028e1:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1028e6:	e9 bc f6 ff ff       	jmp    101fa7 <__alltraps>

001028eb <vector228>:
.globl vector228
vector228:
  pushl $0
  1028eb:	6a 00                	push   $0x0
  pushl $228
  1028ed:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1028f2:	e9 b0 f6 ff ff       	jmp    101fa7 <__alltraps>

001028f7 <vector229>:
.globl vector229
vector229:
  pushl $0
  1028f7:	6a 00                	push   $0x0
  pushl $229
  1028f9:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1028fe:	e9 a4 f6 ff ff       	jmp    101fa7 <__alltraps>

00102903 <vector230>:
.globl vector230
vector230:
  pushl $0
  102903:	6a 00                	push   $0x0
  pushl $230
  102905:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  10290a:	e9 98 f6 ff ff       	jmp    101fa7 <__alltraps>

0010290f <vector231>:
.globl vector231
vector231:
  pushl $0
  10290f:	6a 00                	push   $0x0
  pushl $231
  102911:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102916:	e9 8c f6 ff ff       	jmp    101fa7 <__alltraps>

0010291b <vector232>:
.globl vector232
vector232:
  pushl $0
  10291b:	6a 00                	push   $0x0
  pushl $232
  10291d:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102922:	e9 80 f6 ff ff       	jmp    101fa7 <__alltraps>

00102927 <vector233>:
.globl vector233
vector233:
  pushl $0
  102927:	6a 00                	push   $0x0
  pushl $233
  102929:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  10292e:	e9 74 f6 ff ff       	jmp    101fa7 <__alltraps>

00102933 <vector234>:
.globl vector234
vector234:
  pushl $0
  102933:	6a 00                	push   $0x0
  pushl $234
  102935:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  10293a:	e9 68 f6 ff ff       	jmp    101fa7 <__alltraps>

0010293f <vector235>:
.globl vector235
vector235:
  pushl $0
  10293f:	6a 00                	push   $0x0
  pushl $235
  102941:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102946:	e9 5c f6 ff ff       	jmp    101fa7 <__alltraps>

0010294b <vector236>:
.globl vector236
vector236:
  pushl $0
  10294b:	6a 00                	push   $0x0
  pushl $236
  10294d:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102952:	e9 50 f6 ff ff       	jmp    101fa7 <__alltraps>

00102957 <vector237>:
.globl vector237
vector237:
  pushl $0
  102957:	6a 00                	push   $0x0
  pushl $237
  102959:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  10295e:	e9 44 f6 ff ff       	jmp    101fa7 <__alltraps>

00102963 <vector238>:
.globl vector238
vector238:
  pushl $0
  102963:	6a 00                	push   $0x0
  pushl $238
  102965:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  10296a:	e9 38 f6 ff ff       	jmp    101fa7 <__alltraps>

0010296f <vector239>:
.globl vector239
vector239:
  pushl $0
  10296f:	6a 00                	push   $0x0
  pushl $239
  102971:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102976:	e9 2c f6 ff ff       	jmp    101fa7 <__alltraps>

0010297b <vector240>:
.globl vector240
vector240:
  pushl $0
  10297b:	6a 00                	push   $0x0
  pushl $240
  10297d:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102982:	e9 20 f6 ff ff       	jmp    101fa7 <__alltraps>

00102987 <vector241>:
.globl vector241
vector241:
  pushl $0
  102987:	6a 00                	push   $0x0
  pushl $241
  102989:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  10298e:	e9 14 f6 ff ff       	jmp    101fa7 <__alltraps>

00102993 <vector242>:
.globl vector242
vector242:
  pushl $0
  102993:	6a 00                	push   $0x0
  pushl $242
  102995:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  10299a:	e9 08 f6 ff ff       	jmp    101fa7 <__alltraps>

0010299f <vector243>:
.globl vector243
vector243:
  pushl $0
  10299f:	6a 00                	push   $0x0
  pushl $243
  1029a1:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1029a6:	e9 fc f5 ff ff       	jmp    101fa7 <__alltraps>

001029ab <vector244>:
.globl vector244
vector244:
  pushl $0
  1029ab:	6a 00                	push   $0x0
  pushl $244
  1029ad:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1029b2:	e9 f0 f5 ff ff       	jmp    101fa7 <__alltraps>

001029b7 <vector245>:
.globl vector245
vector245:
  pushl $0
  1029b7:	6a 00                	push   $0x0
  pushl $245
  1029b9:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1029be:	e9 e4 f5 ff ff       	jmp    101fa7 <__alltraps>

001029c3 <vector246>:
.globl vector246
vector246:
  pushl $0
  1029c3:	6a 00                	push   $0x0
  pushl $246
  1029c5:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1029ca:	e9 d8 f5 ff ff       	jmp    101fa7 <__alltraps>

001029cf <vector247>:
.globl vector247
vector247:
  pushl $0
  1029cf:	6a 00                	push   $0x0
  pushl $247
  1029d1:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1029d6:	e9 cc f5 ff ff       	jmp    101fa7 <__alltraps>

001029db <vector248>:
.globl vector248
vector248:
  pushl $0
  1029db:	6a 00                	push   $0x0
  pushl $248
  1029dd:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1029e2:	e9 c0 f5 ff ff       	jmp    101fa7 <__alltraps>

001029e7 <vector249>:
.globl vector249
vector249:
  pushl $0
  1029e7:	6a 00                	push   $0x0
  pushl $249
  1029e9:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1029ee:	e9 b4 f5 ff ff       	jmp    101fa7 <__alltraps>

001029f3 <vector250>:
.globl vector250
vector250:
  pushl $0
  1029f3:	6a 00                	push   $0x0
  pushl $250
  1029f5:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1029fa:	e9 a8 f5 ff ff       	jmp    101fa7 <__alltraps>

001029ff <vector251>:
.globl vector251
vector251:
  pushl $0
  1029ff:	6a 00                	push   $0x0
  pushl $251
  102a01:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102a06:	e9 9c f5 ff ff       	jmp    101fa7 <__alltraps>

00102a0b <vector252>:
.globl vector252
vector252:
  pushl $0
  102a0b:	6a 00                	push   $0x0
  pushl $252
  102a0d:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102a12:	e9 90 f5 ff ff       	jmp    101fa7 <__alltraps>

00102a17 <vector253>:
.globl vector253
vector253:
  pushl $0
  102a17:	6a 00                	push   $0x0
  pushl $253
  102a19:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102a1e:	e9 84 f5 ff ff       	jmp    101fa7 <__alltraps>

00102a23 <vector254>:
.globl vector254
vector254:
  pushl $0
  102a23:	6a 00                	push   $0x0
  pushl $254
  102a25:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102a2a:	e9 78 f5 ff ff       	jmp    101fa7 <__alltraps>

00102a2f <vector255>:
.globl vector255
vector255:
  pushl $0
  102a2f:	6a 00                	push   $0x0
  pushl $255
  102a31:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102a36:	e9 6c f5 ff ff       	jmp    101fa7 <__alltraps>

00102a3b <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102a3b:	55                   	push   %ebp
  102a3c:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102a3e:	8b 45 08             	mov    0x8(%ebp),%eax
  102a41:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102a44:	b8 23 00 00 00       	mov    $0x23,%eax
  102a49:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102a4b:	b8 23 00 00 00       	mov    $0x23,%eax
  102a50:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102a52:	b8 10 00 00 00       	mov    $0x10,%eax
  102a57:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102a59:	b8 10 00 00 00       	mov    $0x10,%eax
  102a5e:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102a60:	b8 10 00 00 00       	mov    $0x10,%eax
  102a65:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102a67:	ea 6e 2a 10 00 08 00 	ljmp   $0x8,$0x102a6e
}
  102a6e:	90                   	nop
  102a6f:	5d                   	pop    %ebp
  102a70:	c3                   	ret    

00102a71 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102a71:	55                   	push   %ebp
  102a72:	89 e5                	mov    %esp,%ebp
  102a74:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102a77:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a7c:	05 00 04 00 00       	add    $0x400,%eax
  102a81:	a3 a4 0c 11 00       	mov    %eax,0x110ca4
    ts.ts_ss0 = KERNEL_DS;
  102a86:	66 c7 05 a8 0c 11 00 	movw   $0x10,0x110ca8
  102a8d:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102a8f:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  102a96:	68 00 
  102a98:	b8 a0 0c 11 00       	mov    $0x110ca0,%eax
  102a9d:	0f b7 c0             	movzwl %ax,%eax
  102aa0:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  102aa6:	b8 a0 0c 11 00       	mov    $0x110ca0,%eax
  102aab:	c1 e8 10             	shr    $0x10,%eax
  102aae:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  102ab3:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102aba:	24 f0                	and    $0xf0,%al
  102abc:	0c 09                	or     $0x9,%al
  102abe:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ac3:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102aca:	0c 10                	or     $0x10,%al
  102acc:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ad1:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102ad8:	24 9f                	and    $0x9f,%al
  102ada:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102adf:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102ae6:	0c 80                	or     $0x80,%al
  102ae8:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102aed:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102af4:	24 f0                	and    $0xf0,%al
  102af6:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102afb:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b02:	24 ef                	and    $0xef,%al
  102b04:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b09:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b10:	24 df                	and    $0xdf,%al
  102b12:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b17:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b1e:	0c 40                	or     $0x40,%al
  102b20:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b25:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b2c:	24 7f                	and    $0x7f,%al
  102b2e:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b33:	b8 a0 0c 11 00       	mov    $0x110ca0,%eax
  102b38:	c1 e8 18             	shr    $0x18,%eax
  102b3b:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102b40:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b47:	24 ef                	and    $0xef,%al
  102b49:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102b4e:	c7 04 24 10 fa 10 00 	movl   $0x10fa10,(%esp)
  102b55:	e8 e1 fe ff ff       	call   102a3b <lgdt>
  102b5a:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102b60:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102b64:	0f 00 d8             	ltr    %ax
}
  102b67:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102b68:	90                   	nop
  102b69:	89 ec                	mov    %ebp,%esp
  102b6b:	5d                   	pop    %ebp
  102b6c:	c3                   	ret    

00102b6d <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102b6d:	55                   	push   %ebp
  102b6e:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102b70:	e8 fc fe ff ff       	call   102a71 <gdt_init>
}
  102b75:	90                   	nop
  102b76:	5d                   	pop    %ebp
  102b77:	c3                   	ret    

00102b78 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102b78:	55                   	push   %ebp
  102b79:	89 e5                	mov    %esp,%ebp
  102b7b:	83 ec 58             	sub    $0x58,%esp
  102b7e:	8b 45 10             	mov    0x10(%ebp),%eax
  102b81:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102b84:	8b 45 14             	mov    0x14(%ebp),%eax
  102b87:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102b8a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102b8d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102b90:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102b93:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102b96:	8b 45 18             	mov    0x18(%ebp),%eax
  102b99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102b9c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102b9f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102ba2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ba5:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102ba8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102bae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102bb2:	74 1c                	je     102bd0 <printnum+0x58>
  102bb4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bb7:	ba 00 00 00 00       	mov    $0x0,%edx
  102bbc:	f7 75 e4             	divl   -0x1c(%ebp)
  102bbf:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102bc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102bc5:	ba 00 00 00 00       	mov    $0x0,%edx
  102bca:	f7 75 e4             	divl   -0x1c(%ebp)
  102bcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102bd0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102bd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102bd6:	f7 75 e4             	divl   -0x1c(%ebp)
  102bd9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102bdc:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102bdf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102be2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102be5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102be8:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102beb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102bee:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102bf1:	8b 45 18             	mov    0x18(%ebp),%eax
  102bf4:	ba 00 00 00 00       	mov    $0x0,%edx
  102bf9:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  102bfc:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  102bff:	19 d1                	sbb    %edx,%ecx
  102c01:	72 4c                	jb     102c4f <printnum+0xd7>
        printnum(putch, putdat, result, base, width - 1, padc);
  102c03:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102c06:	8d 50 ff             	lea    -0x1(%eax),%edx
  102c09:	8b 45 20             	mov    0x20(%ebp),%eax
  102c0c:	89 44 24 18          	mov    %eax,0x18(%esp)
  102c10:	89 54 24 14          	mov    %edx,0x14(%esp)
  102c14:	8b 45 18             	mov    0x18(%ebp),%eax
  102c17:	89 44 24 10          	mov    %eax,0x10(%esp)
  102c1b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102c1e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102c21:	89 44 24 08          	mov    %eax,0x8(%esp)
  102c25:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102c29:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c2c:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c30:	8b 45 08             	mov    0x8(%ebp),%eax
  102c33:	89 04 24             	mov    %eax,(%esp)
  102c36:	e8 3d ff ff ff       	call   102b78 <printnum>
  102c3b:	eb 1b                	jmp    102c58 <printnum+0xe0>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c40:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c44:	8b 45 20             	mov    0x20(%ebp),%eax
  102c47:	89 04 24             	mov    %eax,(%esp)
  102c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  102c4d:	ff d0                	call   *%eax
        while (-- width > 0)
  102c4f:	ff 4d 1c             	decl   0x1c(%ebp)
  102c52:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102c56:	7f e5                	jg     102c3d <printnum+0xc5>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102c58:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102c5b:	05 b0 3e 10 00       	add    $0x103eb0,%eax
  102c60:	0f b6 00             	movzbl (%eax),%eax
  102c63:	0f be c0             	movsbl %al,%eax
  102c66:	8b 55 0c             	mov    0xc(%ebp),%edx
  102c69:	89 54 24 04          	mov    %edx,0x4(%esp)
  102c6d:	89 04 24             	mov    %eax,(%esp)
  102c70:	8b 45 08             	mov    0x8(%ebp),%eax
  102c73:	ff d0                	call   *%eax
}
  102c75:	90                   	nop
  102c76:	89 ec                	mov    %ebp,%esp
  102c78:	5d                   	pop    %ebp
  102c79:	c3                   	ret    

00102c7a <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102c7a:	55                   	push   %ebp
  102c7b:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102c7d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102c81:	7e 14                	jle    102c97 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102c83:	8b 45 08             	mov    0x8(%ebp),%eax
  102c86:	8b 00                	mov    (%eax),%eax
  102c88:	8d 48 08             	lea    0x8(%eax),%ecx
  102c8b:	8b 55 08             	mov    0x8(%ebp),%edx
  102c8e:	89 0a                	mov    %ecx,(%edx)
  102c90:	8b 50 04             	mov    0x4(%eax),%edx
  102c93:	8b 00                	mov    (%eax),%eax
  102c95:	eb 30                	jmp    102cc7 <getuint+0x4d>
    }
    else if (lflag) {
  102c97:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102c9b:	74 16                	je     102cb3 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102c9d:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca0:	8b 00                	mov    (%eax),%eax
  102ca2:	8d 48 04             	lea    0x4(%eax),%ecx
  102ca5:	8b 55 08             	mov    0x8(%ebp),%edx
  102ca8:	89 0a                	mov    %ecx,(%edx)
  102caa:	8b 00                	mov    (%eax),%eax
  102cac:	ba 00 00 00 00       	mov    $0x0,%edx
  102cb1:	eb 14                	jmp    102cc7 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  102cb6:	8b 00                	mov    (%eax),%eax
  102cb8:	8d 48 04             	lea    0x4(%eax),%ecx
  102cbb:	8b 55 08             	mov    0x8(%ebp),%edx
  102cbe:	89 0a                	mov    %ecx,(%edx)
  102cc0:	8b 00                	mov    (%eax),%eax
  102cc2:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102cc7:	5d                   	pop    %ebp
  102cc8:	c3                   	ret    

00102cc9 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102cc9:	55                   	push   %ebp
  102cca:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102ccc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102cd0:	7e 14                	jle    102ce6 <getint+0x1d>
        return va_arg(*ap, long long);
  102cd2:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd5:	8b 00                	mov    (%eax),%eax
  102cd7:	8d 48 08             	lea    0x8(%eax),%ecx
  102cda:	8b 55 08             	mov    0x8(%ebp),%edx
  102cdd:	89 0a                	mov    %ecx,(%edx)
  102cdf:	8b 50 04             	mov    0x4(%eax),%edx
  102ce2:	8b 00                	mov    (%eax),%eax
  102ce4:	eb 28                	jmp    102d0e <getint+0x45>
    }
    else if (lflag) {
  102ce6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102cea:	74 12                	je     102cfe <getint+0x35>
        return va_arg(*ap, long);
  102cec:	8b 45 08             	mov    0x8(%ebp),%eax
  102cef:	8b 00                	mov    (%eax),%eax
  102cf1:	8d 48 04             	lea    0x4(%eax),%ecx
  102cf4:	8b 55 08             	mov    0x8(%ebp),%edx
  102cf7:	89 0a                	mov    %ecx,(%edx)
  102cf9:	8b 00                	mov    (%eax),%eax
  102cfb:	99                   	cltd   
  102cfc:	eb 10                	jmp    102d0e <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  102d01:	8b 00                	mov    (%eax),%eax
  102d03:	8d 48 04             	lea    0x4(%eax),%ecx
  102d06:	8b 55 08             	mov    0x8(%ebp),%edx
  102d09:	89 0a                	mov    %ecx,(%edx)
  102d0b:	8b 00                	mov    (%eax),%eax
  102d0d:	99                   	cltd   
    }
}
  102d0e:	5d                   	pop    %ebp
  102d0f:	c3                   	ret    

00102d10 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102d10:	55                   	push   %ebp
  102d11:	89 e5                	mov    %esp,%ebp
  102d13:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  102d16:	8d 45 14             	lea    0x14(%ebp),%eax
  102d19:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102d1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102d1f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102d23:	8b 45 10             	mov    0x10(%ebp),%eax
  102d26:	89 44 24 08          	mov    %eax,0x8(%esp)
  102d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d31:	8b 45 08             	mov    0x8(%ebp),%eax
  102d34:	89 04 24             	mov    %eax,(%esp)
  102d37:	e8 05 00 00 00       	call   102d41 <vprintfmt>
    va_end(ap);
}
  102d3c:	90                   	nop
  102d3d:	89 ec                	mov    %ebp,%esp
  102d3f:	5d                   	pop    %ebp
  102d40:	c3                   	ret    

00102d41 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102d41:	55                   	push   %ebp
  102d42:	89 e5                	mov    %esp,%ebp
  102d44:	56                   	push   %esi
  102d45:	53                   	push   %ebx
  102d46:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102d49:	eb 17                	jmp    102d62 <vprintfmt+0x21>
            if (ch == '\0') {
  102d4b:	85 db                	test   %ebx,%ebx
  102d4d:	0f 84 bf 03 00 00    	je     103112 <vprintfmt+0x3d1>
                return;
            }
            putch(ch, putdat);
  102d53:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d56:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d5a:	89 1c 24             	mov    %ebx,(%esp)
  102d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d60:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102d62:	8b 45 10             	mov    0x10(%ebp),%eax
  102d65:	8d 50 01             	lea    0x1(%eax),%edx
  102d68:	89 55 10             	mov    %edx,0x10(%ebp)
  102d6b:	0f b6 00             	movzbl (%eax),%eax
  102d6e:	0f b6 d8             	movzbl %al,%ebx
  102d71:	83 fb 25             	cmp    $0x25,%ebx
  102d74:	75 d5                	jne    102d4b <vprintfmt+0xa>
        }

        // Process a %-escape sequence
        char padc = ' ';
  102d76:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102d7a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102d81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102d84:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102d87:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102d8e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102d91:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102d94:	8b 45 10             	mov    0x10(%ebp),%eax
  102d97:	8d 50 01             	lea    0x1(%eax),%edx
  102d9a:	89 55 10             	mov    %edx,0x10(%ebp)
  102d9d:	0f b6 00             	movzbl (%eax),%eax
  102da0:	0f b6 d8             	movzbl %al,%ebx
  102da3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102da6:	83 f8 55             	cmp    $0x55,%eax
  102da9:	0f 87 37 03 00 00    	ja     1030e6 <vprintfmt+0x3a5>
  102daf:	8b 04 85 d4 3e 10 00 	mov    0x103ed4(,%eax,4),%eax
  102db6:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102db8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102dbc:	eb d6                	jmp    102d94 <vprintfmt+0x53>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102dbe:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102dc2:	eb d0                	jmp    102d94 <vprintfmt+0x53>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102dc4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102dcb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102dce:	89 d0                	mov    %edx,%eax
  102dd0:	c1 e0 02             	shl    $0x2,%eax
  102dd3:	01 d0                	add    %edx,%eax
  102dd5:	01 c0                	add    %eax,%eax
  102dd7:	01 d8                	add    %ebx,%eax
  102dd9:	83 e8 30             	sub    $0x30,%eax
  102ddc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102ddf:	8b 45 10             	mov    0x10(%ebp),%eax
  102de2:	0f b6 00             	movzbl (%eax),%eax
  102de5:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102de8:	83 fb 2f             	cmp    $0x2f,%ebx
  102deb:	7e 38                	jle    102e25 <vprintfmt+0xe4>
  102ded:	83 fb 39             	cmp    $0x39,%ebx
  102df0:	7f 33                	jg     102e25 <vprintfmt+0xe4>
            for (precision = 0; ; ++ fmt) {
  102df2:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  102df5:	eb d4                	jmp    102dcb <vprintfmt+0x8a>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  102df7:	8b 45 14             	mov    0x14(%ebp),%eax
  102dfa:	8d 50 04             	lea    0x4(%eax),%edx
  102dfd:	89 55 14             	mov    %edx,0x14(%ebp)
  102e00:	8b 00                	mov    (%eax),%eax
  102e02:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102e05:	eb 1f                	jmp    102e26 <vprintfmt+0xe5>

        case '.':
            if (width < 0)
  102e07:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e0b:	79 87                	jns    102d94 <vprintfmt+0x53>
                width = 0;
  102e0d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102e14:	e9 7b ff ff ff       	jmp    102d94 <vprintfmt+0x53>

        case '#':
            altflag = 1;
  102e19:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102e20:	e9 6f ff ff ff       	jmp    102d94 <vprintfmt+0x53>
            goto process_precision;
  102e25:	90                   	nop

        process_precision:
            if (width < 0)
  102e26:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e2a:	0f 89 64 ff ff ff    	jns    102d94 <vprintfmt+0x53>
                width = precision, precision = -1;
  102e30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102e33:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102e36:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102e3d:	e9 52 ff ff ff       	jmp    102d94 <vprintfmt+0x53>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102e42:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  102e45:	e9 4a ff ff ff       	jmp    102d94 <vprintfmt+0x53>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102e4a:	8b 45 14             	mov    0x14(%ebp),%eax
  102e4d:	8d 50 04             	lea    0x4(%eax),%edx
  102e50:	89 55 14             	mov    %edx,0x14(%ebp)
  102e53:	8b 00                	mov    (%eax),%eax
  102e55:	8b 55 0c             	mov    0xc(%ebp),%edx
  102e58:	89 54 24 04          	mov    %edx,0x4(%esp)
  102e5c:	89 04 24             	mov    %eax,(%esp)
  102e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  102e62:	ff d0                	call   *%eax
            break;
  102e64:	e9 a4 02 00 00       	jmp    10310d <vprintfmt+0x3cc>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102e69:	8b 45 14             	mov    0x14(%ebp),%eax
  102e6c:	8d 50 04             	lea    0x4(%eax),%edx
  102e6f:	89 55 14             	mov    %edx,0x14(%ebp)
  102e72:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102e74:	85 db                	test   %ebx,%ebx
  102e76:	79 02                	jns    102e7a <vprintfmt+0x139>
                err = -err;
  102e78:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102e7a:	83 fb 06             	cmp    $0x6,%ebx
  102e7d:	7f 0b                	jg     102e8a <vprintfmt+0x149>
  102e7f:	8b 34 9d 94 3e 10 00 	mov    0x103e94(,%ebx,4),%esi
  102e86:	85 f6                	test   %esi,%esi
  102e88:	75 23                	jne    102ead <vprintfmt+0x16c>
                printfmt(putch, putdat, "error %d", err);
  102e8a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102e8e:	c7 44 24 08 c1 3e 10 	movl   $0x103ec1,0x8(%esp)
  102e95:	00 
  102e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e99:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e9d:	8b 45 08             	mov    0x8(%ebp),%eax
  102ea0:	89 04 24             	mov    %eax,(%esp)
  102ea3:	e8 68 fe ff ff       	call   102d10 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102ea8:	e9 60 02 00 00       	jmp    10310d <vprintfmt+0x3cc>
                printfmt(putch, putdat, "%s", p);
  102ead:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102eb1:	c7 44 24 08 ca 3e 10 	movl   $0x103eca,0x8(%esp)
  102eb8:	00 
  102eb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ebc:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  102ec3:	89 04 24             	mov    %eax,(%esp)
  102ec6:	e8 45 fe ff ff       	call   102d10 <printfmt>
            break;
  102ecb:	e9 3d 02 00 00       	jmp    10310d <vprintfmt+0x3cc>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102ed0:	8b 45 14             	mov    0x14(%ebp),%eax
  102ed3:	8d 50 04             	lea    0x4(%eax),%edx
  102ed6:	89 55 14             	mov    %edx,0x14(%ebp)
  102ed9:	8b 30                	mov    (%eax),%esi
  102edb:	85 f6                	test   %esi,%esi
  102edd:	75 05                	jne    102ee4 <vprintfmt+0x1a3>
                p = "(null)";
  102edf:	be cd 3e 10 00       	mov    $0x103ecd,%esi
            }
            if (width > 0 && padc != '-') {
  102ee4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102ee8:	7e 76                	jle    102f60 <vprintfmt+0x21f>
  102eea:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102eee:	74 70                	je     102f60 <vprintfmt+0x21f>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102ef0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102ef3:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ef7:	89 34 24             	mov    %esi,(%esp)
  102efa:	e8 16 03 00 00       	call   103215 <strnlen>
  102eff:	89 c2                	mov    %eax,%edx
  102f01:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f04:	29 d0                	sub    %edx,%eax
  102f06:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102f09:	eb 16                	jmp    102f21 <vprintfmt+0x1e0>
                    putch(padc, putdat);
  102f0b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102f0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  102f12:	89 54 24 04          	mov    %edx,0x4(%esp)
  102f16:	89 04 24             	mov    %eax,(%esp)
  102f19:	8b 45 08             	mov    0x8(%ebp),%eax
  102f1c:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  102f1e:	ff 4d e8             	decl   -0x18(%ebp)
  102f21:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102f25:	7f e4                	jg     102f0b <vprintfmt+0x1ca>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102f27:	eb 37                	jmp    102f60 <vprintfmt+0x21f>
                if (altflag && (ch < ' ' || ch > '~')) {
  102f29:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102f2d:	74 1f                	je     102f4e <vprintfmt+0x20d>
  102f2f:	83 fb 1f             	cmp    $0x1f,%ebx
  102f32:	7e 05                	jle    102f39 <vprintfmt+0x1f8>
  102f34:	83 fb 7e             	cmp    $0x7e,%ebx
  102f37:	7e 15                	jle    102f4e <vprintfmt+0x20d>
                    putch('?', putdat);
  102f39:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f3c:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f40:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102f47:	8b 45 08             	mov    0x8(%ebp),%eax
  102f4a:	ff d0                	call   *%eax
  102f4c:	eb 0f                	jmp    102f5d <vprintfmt+0x21c>
                }
                else {
                    putch(ch, putdat);
  102f4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f51:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f55:	89 1c 24             	mov    %ebx,(%esp)
  102f58:	8b 45 08             	mov    0x8(%ebp),%eax
  102f5b:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102f5d:	ff 4d e8             	decl   -0x18(%ebp)
  102f60:	89 f0                	mov    %esi,%eax
  102f62:	8d 70 01             	lea    0x1(%eax),%esi
  102f65:	0f b6 00             	movzbl (%eax),%eax
  102f68:	0f be d8             	movsbl %al,%ebx
  102f6b:	85 db                	test   %ebx,%ebx
  102f6d:	74 27                	je     102f96 <vprintfmt+0x255>
  102f6f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102f73:	78 b4                	js     102f29 <vprintfmt+0x1e8>
  102f75:	ff 4d e4             	decl   -0x1c(%ebp)
  102f78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102f7c:	79 ab                	jns    102f29 <vprintfmt+0x1e8>
                }
            }
            for (; width > 0; width --) {
  102f7e:	eb 16                	jmp    102f96 <vprintfmt+0x255>
                putch(' ', putdat);
  102f80:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f83:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f87:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  102f91:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  102f93:	ff 4d e8             	decl   -0x18(%ebp)
  102f96:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102f9a:	7f e4                	jg     102f80 <vprintfmt+0x23f>
            }
            break;
  102f9c:	e9 6c 01 00 00       	jmp    10310d <vprintfmt+0x3cc>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102fa1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102fa4:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fa8:	8d 45 14             	lea    0x14(%ebp),%eax
  102fab:	89 04 24             	mov    %eax,(%esp)
  102fae:	e8 16 fd ff ff       	call   102cc9 <getint>
  102fb3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fb6:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102fb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fbc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fbf:	85 d2                	test   %edx,%edx
  102fc1:	79 26                	jns    102fe9 <vprintfmt+0x2a8>
                putch('-', putdat);
  102fc3:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fc6:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fca:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102fd1:	8b 45 08             	mov    0x8(%ebp),%eax
  102fd4:	ff d0                	call   *%eax
                num = -(long long)num;
  102fd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fd9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fdc:	f7 d8                	neg    %eax
  102fde:	83 d2 00             	adc    $0x0,%edx
  102fe1:	f7 da                	neg    %edx
  102fe3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fe6:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102fe9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102ff0:	e9 a8 00 00 00       	jmp    10309d <vprintfmt+0x35c>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102ff5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ff8:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ffc:	8d 45 14             	lea    0x14(%ebp),%eax
  102fff:	89 04 24             	mov    %eax,(%esp)
  103002:	e8 73 fc ff ff       	call   102c7a <getuint>
  103007:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10300a:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  10300d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  103014:	e9 84 00 00 00       	jmp    10309d <vprintfmt+0x35c>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  103019:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10301c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103020:	8d 45 14             	lea    0x14(%ebp),%eax
  103023:	89 04 24             	mov    %eax,(%esp)
  103026:	e8 4f fc ff ff       	call   102c7a <getuint>
  10302b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10302e:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103031:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  103038:	eb 63                	jmp    10309d <vprintfmt+0x35c>

        // pointer
        case 'p':
            putch('0', putdat);
  10303a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10303d:	89 44 24 04          	mov    %eax,0x4(%esp)
  103041:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  103048:	8b 45 08             	mov    0x8(%ebp),%eax
  10304b:	ff d0                	call   *%eax
            putch('x', putdat);
  10304d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103050:	89 44 24 04          	mov    %eax,0x4(%esp)
  103054:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  10305b:	8b 45 08             	mov    0x8(%ebp),%eax
  10305e:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103060:	8b 45 14             	mov    0x14(%ebp),%eax
  103063:	8d 50 04             	lea    0x4(%eax),%edx
  103066:	89 55 14             	mov    %edx,0x14(%ebp)
  103069:	8b 00                	mov    (%eax),%eax
  10306b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10306e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103075:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  10307c:	eb 1f                	jmp    10309d <vprintfmt+0x35c>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10307e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103081:	89 44 24 04          	mov    %eax,0x4(%esp)
  103085:	8d 45 14             	lea    0x14(%ebp),%eax
  103088:	89 04 24             	mov    %eax,(%esp)
  10308b:	e8 ea fb ff ff       	call   102c7a <getuint>
  103090:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103093:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103096:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10309d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  1030a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1030a4:	89 54 24 18          	mov    %edx,0x18(%esp)
  1030a8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1030ab:	89 54 24 14          	mov    %edx,0x14(%esp)
  1030af:	89 44 24 10          	mov    %eax,0x10(%esp)
  1030b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1030b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1030b9:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030bd:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1030c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030c4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1030cb:	89 04 24             	mov    %eax,(%esp)
  1030ce:	e8 a5 fa ff ff       	call   102b78 <printnum>
            break;
  1030d3:	eb 38                	jmp    10310d <vprintfmt+0x3cc>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1030d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030dc:	89 1c 24             	mov    %ebx,(%esp)
  1030df:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e2:	ff d0                	call   *%eax
            break;
  1030e4:	eb 27                	jmp    10310d <vprintfmt+0x3cc>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1030e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030e9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030ed:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  1030f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f7:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  1030f9:	ff 4d 10             	decl   0x10(%ebp)
  1030fc:	eb 03                	jmp    103101 <vprintfmt+0x3c0>
  1030fe:	ff 4d 10             	decl   0x10(%ebp)
  103101:	8b 45 10             	mov    0x10(%ebp),%eax
  103104:	48                   	dec    %eax
  103105:	0f b6 00             	movzbl (%eax),%eax
  103108:	3c 25                	cmp    $0x25,%al
  10310a:	75 f2                	jne    1030fe <vprintfmt+0x3bd>
                /* do nothing */;
            break;
  10310c:	90                   	nop
    while (1) {
  10310d:	e9 37 fc ff ff       	jmp    102d49 <vprintfmt+0x8>
                return;
  103112:	90                   	nop
        }
    }
}
  103113:	83 c4 40             	add    $0x40,%esp
  103116:	5b                   	pop    %ebx
  103117:	5e                   	pop    %esi
  103118:	5d                   	pop    %ebp
  103119:	c3                   	ret    

0010311a <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  10311a:	55                   	push   %ebp
  10311b:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  10311d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103120:	8b 40 08             	mov    0x8(%eax),%eax
  103123:	8d 50 01             	lea    0x1(%eax),%edx
  103126:	8b 45 0c             	mov    0xc(%ebp),%eax
  103129:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  10312c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10312f:	8b 10                	mov    (%eax),%edx
  103131:	8b 45 0c             	mov    0xc(%ebp),%eax
  103134:	8b 40 04             	mov    0x4(%eax),%eax
  103137:	39 c2                	cmp    %eax,%edx
  103139:	73 12                	jae    10314d <sprintputch+0x33>
        *b->buf ++ = ch;
  10313b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10313e:	8b 00                	mov    (%eax),%eax
  103140:	8d 48 01             	lea    0x1(%eax),%ecx
  103143:	8b 55 0c             	mov    0xc(%ebp),%edx
  103146:	89 0a                	mov    %ecx,(%edx)
  103148:	8b 55 08             	mov    0x8(%ebp),%edx
  10314b:	88 10                	mov    %dl,(%eax)
    }
}
  10314d:	90                   	nop
  10314e:	5d                   	pop    %ebp
  10314f:	c3                   	ret    

00103150 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103150:	55                   	push   %ebp
  103151:	89 e5                	mov    %esp,%ebp
  103153:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103156:	8d 45 14             	lea    0x14(%ebp),%eax
  103159:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  10315c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10315f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103163:	8b 45 10             	mov    0x10(%ebp),%eax
  103166:	89 44 24 08          	mov    %eax,0x8(%esp)
  10316a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10316d:	89 44 24 04          	mov    %eax,0x4(%esp)
  103171:	8b 45 08             	mov    0x8(%ebp),%eax
  103174:	89 04 24             	mov    %eax,(%esp)
  103177:	e8 0a 00 00 00       	call   103186 <vsnprintf>
  10317c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10317f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103182:	89 ec                	mov    %ebp,%esp
  103184:	5d                   	pop    %ebp
  103185:	c3                   	ret    

00103186 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103186:	55                   	push   %ebp
  103187:	89 e5                	mov    %esp,%ebp
  103189:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  10318c:	8b 45 08             	mov    0x8(%ebp),%eax
  10318f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103192:	8b 45 0c             	mov    0xc(%ebp),%eax
  103195:	8d 50 ff             	lea    -0x1(%eax),%edx
  103198:	8b 45 08             	mov    0x8(%ebp),%eax
  10319b:	01 d0                	add    %edx,%eax
  10319d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1031a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  1031a7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1031ab:	74 0a                	je     1031b7 <vsnprintf+0x31>
  1031ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1031b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031b3:	39 c2                	cmp    %eax,%edx
  1031b5:	76 07                	jbe    1031be <vsnprintf+0x38>
        return -E_INVAL;
  1031b7:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  1031bc:	eb 2a                	jmp    1031e8 <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  1031be:	8b 45 14             	mov    0x14(%ebp),%eax
  1031c1:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1031c5:	8b 45 10             	mov    0x10(%ebp),%eax
  1031c8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1031cc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1031cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031d3:	c7 04 24 1a 31 10 00 	movl   $0x10311a,(%esp)
  1031da:	e8 62 fb ff ff       	call   102d41 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1031df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031e2:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1031e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1031e8:	89 ec                	mov    %ebp,%esp
  1031ea:	5d                   	pop    %ebp
  1031eb:	c3                   	ret    

001031ec <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  1031ec:	55                   	push   %ebp
  1031ed:	89 e5                	mov    %esp,%ebp
  1031ef:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1031f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  1031f9:	eb 03                	jmp    1031fe <strlen+0x12>
        cnt ++;
  1031fb:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  1031fe:	8b 45 08             	mov    0x8(%ebp),%eax
  103201:	8d 50 01             	lea    0x1(%eax),%edx
  103204:	89 55 08             	mov    %edx,0x8(%ebp)
  103207:	0f b6 00             	movzbl (%eax),%eax
  10320a:	84 c0                	test   %al,%al
  10320c:	75 ed                	jne    1031fb <strlen+0xf>
    }
    return cnt;
  10320e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103211:	89 ec                	mov    %ebp,%esp
  103213:	5d                   	pop    %ebp
  103214:	c3                   	ret    

00103215 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  103215:	55                   	push   %ebp
  103216:	89 e5                	mov    %esp,%ebp
  103218:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  10321b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  103222:	eb 03                	jmp    103227 <strnlen+0x12>
        cnt ++;
  103224:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  103227:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10322a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  10322d:	73 10                	jae    10323f <strnlen+0x2a>
  10322f:	8b 45 08             	mov    0x8(%ebp),%eax
  103232:	8d 50 01             	lea    0x1(%eax),%edx
  103235:	89 55 08             	mov    %edx,0x8(%ebp)
  103238:	0f b6 00             	movzbl (%eax),%eax
  10323b:	84 c0                	test   %al,%al
  10323d:	75 e5                	jne    103224 <strnlen+0xf>
    }
    return cnt;
  10323f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103242:	89 ec                	mov    %ebp,%esp
  103244:	5d                   	pop    %ebp
  103245:	c3                   	ret    

00103246 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  103246:	55                   	push   %ebp
  103247:	89 e5                	mov    %esp,%ebp
  103249:	57                   	push   %edi
  10324a:	56                   	push   %esi
  10324b:	83 ec 20             	sub    $0x20,%esp
  10324e:	8b 45 08             	mov    0x8(%ebp),%eax
  103251:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103254:	8b 45 0c             	mov    0xc(%ebp),%eax
  103257:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  10325a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10325d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103260:	89 d1                	mov    %edx,%ecx
  103262:	89 c2                	mov    %eax,%edx
  103264:	89 ce                	mov    %ecx,%esi
  103266:	89 d7                	mov    %edx,%edi
  103268:	ac                   	lods   %ds:(%esi),%al
  103269:	aa                   	stos   %al,%es:(%edi)
  10326a:	84 c0                	test   %al,%al
  10326c:	75 fa                	jne    103268 <strcpy+0x22>
  10326e:	89 fa                	mov    %edi,%edx
  103270:	89 f1                	mov    %esi,%ecx
  103272:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  103275:	89 55 e8             	mov    %edx,-0x18(%ebp)
  103278:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  10327b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  10327e:	83 c4 20             	add    $0x20,%esp
  103281:	5e                   	pop    %esi
  103282:	5f                   	pop    %edi
  103283:	5d                   	pop    %ebp
  103284:	c3                   	ret    

00103285 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  103285:	55                   	push   %ebp
  103286:	89 e5                	mov    %esp,%ebp
  103288:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  10328b:	8b 45 08             	mov    0x8(%ebp),%eax
  10328e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  103291:	eb 1e                	jmp    1032b1 <strncpy+0x2c>
        if ((*p = *src) != '\0') {
  103293:	8b 45 0c             	mov    0xc(%ebp),%eax
  103296:	0f b6 10             	movzbl (%eax),%edx
  103299:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10329c:	88 10                	mov    %dl,(%eax)
  10329e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1032a1:	0f b6 00             	movzbl (%eax),%eax
  1032a4:	84 c0                	test   %al,%al
  1032a6:	74 03                	je     1032ab <strncpy+0x26>
            src ++;
  1032a8:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  1032ab:	ff 45 fc             	incl   -0x4(%ebp)
  1032ae:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  1032b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1032b5:	75 dc                	jne    103293 <strncpy+0xe>
    }
    return dst;
  1032b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1032ba:	89 ec                	mov    %ebp,%esp
  1032bc:	5d                   	pop    %ebp
  1032bd:	c3                   	ret    

001032be <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  1032be:	55                   	push   %ebp
  1032bf:	89 e5                	mov    %esp,%ebp
  1032c1:	57                   	push   %edi
  1032c2:	56                   	push   %esi
  1032c3:	83 ec 20             	sub    $0x20,%esp
  1032c6:	8b 45 08             	mov    0x8(%ebp),%eax
  1032c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1032cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  1032d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1032d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1032d8:	89 d1                	mov    %edx,%ecx
  1032da:	89 c2                	mov    %eax,%edx
  1032dc:	89 ce                	mov    %ecx,%esi
  1032de:	89 d7                	mov    %edx,%edi
  1032e0:	ac                   	lods   %ds:(%esi),%al
  1032e1:	ae                   	scas   %es:(%edi),%al
  1032e2:	75 08                	jne    1032ec <strcmp+0x2e>
  1032e4:	84 c0                	test   %al,%al
  1032e6:	75 f8                	jne    1032e0 <strcmp+0x22>
  1032e8:	31 c0                	xor    %eax,%eax
  1032ea:	eb 04                	jmp    1032f0 <strcmp+0x32>
  1032ec:	19 c0                	sbb    %eax,%eax
  1032ee:	0c 01                	or     $0x1,%al
  1032f0:	89 fa                	mov    %edi,%edx
  1032f2:	89 f1                	mov    %esi,%ecx
  1032f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1032f7:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  1032fa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  1032fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  103300:	83 c4 20             	add    $0x20,%esp
  103303:	5e                   	pop    %esi
  103304:	5f                   	pop    %edi
  103305:	5d                   	pop    %ebp
  103306:	c3                   	ret    

00103307 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  103307:	55                   	push   %ebp
  103308:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  10330a:	eb 09                	jmp    103315 <strncmp+0xe>
        n --, s1 ++, s2 ++;
  10330c:	ff 4d 10             	decl   0x10(%ebp)
  10330f:	ff 45 08             	incl   0x8(%ebp)
  103312:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  103315:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103319:	74 1a                	je     103335 <strncmp+0x2e>
  10331b:	8b 45 08             	mov    0x8(%ebp),%eax
  10331e:	0f b6 00             	movzbl (%eax),%eax
  103321:	84 c0                	test   %al,%al
  103323:	74 10                	je     103335 <strncmp+0x2e>
  103325:	8b 45 08             	mov    0x8(%ebp),%eax
  103328:	0f b6 10             	movzbl (%eax),%edx
  10332b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10332e:	0f b6 00             	movzbl (%eax),%eax
  103331:	38 c2                	cmp    %al,%dl
  103333:	74 d7                	je     10330c <strncmp+0x5>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  103335:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103339:	74 18                	je     103353 <strncmp+0x4c>
  10333b:	8b 45 08             	mov    0x8(%ebp),%eax
  10333e:	0f b6 00             	movzbl (%eax),%eax
  103341:	0f b6 d0             	movzbl %al,%edx
  103344:	8b 45 0c             	mov    0xc(%ebp),%eax
  103347:	0f b6 00             	movzbl (%eax),%eax
  10334a:	0f b6 c8             	movzbl %al,%ecx
  10334d:	89 d0                	mov    %edx,%eax
  10334f:	29 c8                	sub    %ecx,%eax
  103351:	eb 05                	jmp    103358 <strncmp+0x51>
  103353:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103358:	5d                   	pop    %ebp
  103359:	c3                   	ret    

0010335a <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  10335a:	55                   	push   %ebp
  10335b:	89 e5                	mov    %esp,%ebp
  10335d:	83 ec 04             	sub    $0x4,%esp
  103360:	8b 45 0c             	mov    0xc(%ebp),%eax
  103363:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  103366:	eb 13                	jmp    10337b <strchr+0x21>
        if (*s == c) {
  103368:	8b 45 08             	mov    0x8(%ebp),%eax
  10336b:	0f b6 00             	movzbl (%eax),%eax
  10336e:	38 45 fc             	cmp    %al,-0x4(%ebp)
  103371:	75 05                	jne    103378 <strchr+0x1e>
            return (char *)s;
  103373:	8b 45 08             	mov    0x8(%ebp),%eax
  103376:	eb 12                	jmp    10338a <strchr+0x30>
        }
        s ++;
  103378:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  10337b:	8b 45 08             	mov    0x8(%ebp),%eax
  10337e:	0f b6 00             	movzbl (%eax),%eax
  103381:	84 c0                	test   %al,%al
  103383:	75 e3                	jne    103368 <strchr+0xe>
    }
    return NULL;
  103385:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10338a:	89 ec                	mov    %ebp,%esp
  10338c:	5d                   	pop    %ebp
  10338d:	c3                   	ret    

0010338e <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  10338e:	55                   	push   %ebp
  10338f:	89 e5                	mov    %esp,%ebp
  103391:	83 ec 04             	sub    $0x4,%esp
  103394:	8b 45 0c             	mov    0xc(%ebp),%eax
  103397:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10339a:	eb 0e                	jmp    1033aa <strfind+0x1c>
        if (*s == c) {
  10339c:	8b 45 08             	mov    0x8(%ebp),%eax
  10339f:	0f b6 00             	movzbl (%eax),%eax
  1033a2:	38 45 fc             	cmp    %al,-0x4(%ebp)
  1033a5:	74 0f                	je     1033b6 <strfind+0x28>
            break;
        }
        s ++;
  1033a7:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  1033aa:	8b 45 08             	mov    0x8(%ebp),%eax
  1033ad:	0f b6 00             	movzbl (%eax),%eax
  1033b0:	84 c0                	test   %al,%al
  1033b2:	75 e8                	jne    10339c <strfind+0xe>
  1033b4:	eb 01                	jmp    1033b7 <strfind+0x29>
            break;
  1033b6:	90                   	nop
    }
    return (char *)s;
  1033b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1033ba:	89 ec                	mov    %ebp,%esp
  1033bc:	5d                   	pop    %ebp
  1033bd:	c3                   	ret    

001033be <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  1033be:	55                   	push   %ebp
  1033bf:	89 e5                	mov    %esp,%ebp
  1033c1:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  1033c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  1033cb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1033d2:	eb 03                	jmp    1033d7 <strtol+0x19>
        s ++;
  1033d4:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  1033d7:	8b 45 08             	mov    0x8(%ebp),%eax
  1033da:	0f b6 00             	movzbl (%eax),%eax
  1033dd:	3c 20                	cmp    $0x20,%al
  1033df:	74 f3                	je     1033d4 <strtol+0x16>
  1033e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1033e4:	0f b6 00             	movzbl (%eax),%eax
  1033e7:	3c 09                	cmp    $0x9,%al
  1033e9:	74 e9                	je     1033d4 <strtol+0x16>
    }

    // plus/minus sign
    if (*s == '+') {
  1033eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1033ee:	0f b6 00             	movzbl (%eax),%eax
  1033f1:	3c 2b                	cmp    $0x2b,%al
  1033f3:	75 05                	jne    1033fa <strtol+0x3c>
        s ++;
  1033f5:	ff 45 08             	incl   0x8(%ebp)
  1033f8:	eb 14                	jmp    10340e <strtol+0x50>
    }
    else if (*s == '-') {
  1033fa:	8b 45 08             	mov    0x8(%ebp),%eax
  1033fd:	0f b6 00             	movzbl (%eax),%eax
  103400:	3c 2d                	cmp    $0x2d,%al
  103402:	75 0a                	jne    10340e <strtol+0x50>
        s ++, neg = 1;
  103404:	ff 45 08             	incl   0x8(%ebp)
  103407:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  10340e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103412:	74 06                	je     10341a <strtol+0x5c>
  103414:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  103418:	75 22                	jne    10343c <strtol+0x7e>
  10341a:	8b 45 08             	mov    0x8(%ebp),%eax
  10341d:	0f b6 00             	movzbl (%eax),%eax
  103420:	3c 30                	cmp    $0x30,%al
  103422:	75 18                	jne    10343c <strtol+0x7e>
  103424:	8b 45 08             	mov    0x8(%ebp),%eax
  103427:	40                   	inc    %eax
  103428:	0f b6 00             	movzbl (%eax),%eax
  10342b:	3c 78                	cmp    $0x78,%al
  10342d:	75 0d                	jne    10343c <strtol+0x7e>
        s += 2, base = 16;
  10342f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  103433:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10343a:	eb 29                	jmp    103465 <strtol+0xa7>
    }
    else if (base == 0 && s[0] == '0') {
  10343c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103440:	75 16                	jne    103458 <strtol+0x9a>
  103442:	8b 45 08             	mov    0x8(%ebp),%eax
  103445:	0f b6 00             	movzbl (%eax),%eax
  103448:	3c 30                	cmp    $0x30,%al
  10344a:	75 0c                	jne    103458 <strtol+0x9a>
        s ++, base = 8;
  10344c:	ff 45 08             	incl   0x8(%ebp)
  10344f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  103456:	eb 0d                	jmp    103465 <strtol+0xa7>
    }
    else if (base == 0) {
  103458:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10345c:	75 07                	jne    103465 <strtol+0xa7>
        base = 10;
  10345e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  103465:	8b 45 08             	mov    0x8(%ebp),%eax
  103468:	0f b6 00             	movzbl (%eax),%eax
  10346b:	3c 2f                	cmp    $0x2f,%al
  10346d:	7e 1b                	jle    10348a <strtol+0xcc>
  10346f:	8b 45 08             	mov    0x8(%ebp),%eax
  103472:	0f b6 00             	movzbl (%eax),%eax
  103475:	3c 39                	cmp    $0x39,%al
  103477:	7f 11                	jg     10348a <strtol+0xcc>
            dig = *s - '0';
  103479:	8b 45 08             	mov    0x8(%ebp),%eax
  10347c:	0f b6 00             	movzbl (%eax),%eax
  10347f:	0f be c0             	movsbl %al,%eax
  103482:	83 e8 30             	sub    $0x30,%eax
  103485:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103488:	eb 48                	jmp    1034d2 <strtol+0x114>
        }
        else if (*s >= 'a' && *s <= 'z') {
  10348a:	8b 45 08             	mov    0x8(%ebp),%eax
  10348d:	0f b6 00             	movzbl (%eax),%eax
  103490:	3c 60                	cmp    $0x60,%al
  103492:	7e 1b                	jle    1034af <strtol+0xf1>
  103494:	8b 45 08             	mov    0x8(%ebp),%eax
  103497:	0f b6 00             	movzbl (%eax),%eax
  10349a:	3c 7a                	cmp    $0x7a,%al
  10349c:	7f 11                	jg     1034af <strtol+0xf1>
            dig = *s - 'a' + 10;
  10349e:	8b 45 08             	mov    0x8(%ebp),%eax
  1034a1:	0f b6 00             	movzbl (%eax),%eax
  1034a4:	0f be c0             	movsbl %al,%eax
  1034a7:	83 e8 57             	sub    $0x57,%eax
  1034aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1034ad:	eb 23                	jmp    1034d2 <strtol+0x114>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1034af:	8b 45 08             	mov    0x8(%ebp),%eax
  1034b2:	0f b6 00             	movzbl (%eax),%eax
  1034b5:	3c 40                	cmp    $0x40,%al
  1034b7:	7e 3b                	jle    1034f4 <strtol+0x136>
  1034b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1034bc:	0f b6 00             	movzbl (%eax),%eax
  1034bf:	3c 5a                	cmp    $0x5a,%al
  1034c1:	7f 31                	jg     1034f4 <strtol+0x136>
            dig = *s - 'A' + 10;
  1034c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1034c6:	0f b6 00             	movzbl (%eax),%eax
  1034c9:	0f be c0             	movsbl %al,%eax
  1034cc:	83 e8 37             	sub    $0x37,%eax
  1034cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1034d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034d5:	3b 45 10             	cmp    0x10(%ebp),%eax
  1034d8:	7d 19                	jge    1034f3 <strtol+0x135>
            break;
        }
        s ++, val = (val * base) + dig;
  1034da:	ff 45 08             	incl   0x8(%ebp)
  1034dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1034e0:	0f af 45 10          	imul   0x10(%ebp),%eax
  1034e4:	89 c2                	mov    %eax,%edx
  1034e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034e9:	01 d0                	add    %edx,%eax
  1034eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  1034ee:	e9 72 ff ff ff       	jmp    103465 <strtol+0xa7>
            break;
  1034f3:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  1034f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1034f8:	74 08                	je     103502 <strtol+0x144>
        *endptr = (char *) s;
  1034fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034fd:	8b 55 08             	mov    0x8(%ebp),%edx
  103500:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  103502:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103506:	74 07                	je     10350f <strtol+0x151>
  103508:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10350b:	f7 d8                	neg    %eax
  10350d:	eb 03                	jmp    103512 <strtol+0x154>
  10350f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  103512:	89 ec                	mov    %ebp,%esp
  103514:	5d                   	pop    %ebp
  103515:	c3                   	ret    

00103516 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  103516:	55                   	push   %ebp
  103517:	89 e5                	mov    %esp,%ebp
  103519:	83 ec 28             	sub    $0x28,%esp
  10351c:	89 7d fc             	mov    %edi,-0x4(%ebp)
  10351f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103522:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  103525:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  103529:	8b 45 08             	mov    0x8(%ebp),%eax
  10352c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10352f:	88 55 f7             	mov    %dl,-0x9(%ebp)
  103532:	8b 45 10             	mov    0x10(%ebp),%eax
  103535:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  103538:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10353b:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  10353f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  103542:	89 d7                	mov    %edx,%edi
  103544:	f3 aa                	rep stos %al,%es:(%edi)
  103546:	89 fa                	mov    %edi,%edx
  103548:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  10354b:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  10354e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  103551:	8b 7d fc             	mov    -0x4(%ebp),%edi
  103554:	89 ec                	mov    %ebp,%esp
  103556:	5d                   	pop    %ebp
  103557:	c3                   	ret    

00103558 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  103558:	55                   	push   %ebp
  103559:	89 e5                	mov    %esp,%ebp
  10355b:	57                   	push   %edi
  10355c:	56                   	push   %esi
  10355d:	53                   	push   %ebx
  10355e:	83 ec 30             	sub    $0x30,%esp
  103561:	8b 45 08             	mov    0x8(%ebp),%eax
  103564:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103567:	8b 45 0c             	mov    0xc(%ebp),%eax
  10356a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10356d:	8b 45 10             	mov    0x10(%ebp),%eax
  103570:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  103573:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103576:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  103579:	73 42                	jae    1035bd <memmove+0x65>
  10357b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10357e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103581:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103584:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103587:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10358a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10358d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103590:	c1 e8 02             	shr    $0x2,%eax
  103593:	89 c1                	mov    %eax,%ecx
    asm volatile (
  103595:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103598:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10359b:	89 d7                	mov    %edx,%edi
  10359d:	89 c6                	mov    %eax,%esi
  10359f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1035a1:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1035a4:	83 e1 03             	and    $0x3,%ecx
  1035a7:	74 02                	je     1035ab <memmove+0x53>
  1035a9:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1035ab:	89 f0                	mov    %esi,%eax
  1035ad:	89 fa                	mov    %edi,%edx
  1035af:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  1035b2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1035b5:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  1035b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  1035bb:	eb 36                	jmp    1035f3 <memmove+0x9b>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  1035bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1035c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  1035c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1035c6:	01 c2                	add    %eax,%edx
  1035c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1035cb:	8d 48 ff             	lea    -0x1(%eax),%ecx
  1035ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1035d1:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  1035d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1035d7:	89 c1                	mov    %eax,%ecx
  1035d9:	89 d8                	mov    %ebx,%eax
  1035db:	89 d6                	mov    %edx,%esi
  1035dd:	89 c7                	mov    %eax,%edi
  1035df:	fd                   	std    
  1035e0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1035e2:	fc                   	cld    
  1035e3:	89 f8                	mov    %edi,%eax
  1035e5:	89 f2                	mov    %esi,%edx
  1035e7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  1035ea:	89 55 c8             	mov    %edx,-0x38(%ebp)
  1035ed:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  1035f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  1035f3:	83 c4 30             	add    $0x30,%esp
  1035f6:	5b                   	pop    %ebx
  1035f7:	5e                   	pop    %esi
  1035f8:	5f                   	pop    %edi
  1035f9:	5d                   	pop    %ebp
  1035fa:	c3                   	ret    

001035fb <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  1035fb:	55                   	push   %ebp
  1035fc:	89 e5                	mov    %esp,%ebp
  1035fe:	57                   	push   %edi
  1035ff:	56                   	push   %esi
  103600:	83 ec 20             	sub    $0x20,%esp
  103603:	8b 45 08             	mov    0x8(%ebp),%eax
  103606:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103609:	8b 45 0c             	mov    0xc(%ebp),%eax
  10360c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10360f:	8b 45 10             	mov    0x10(%ebp),%eax
  103612:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103615:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103618:	c1 e8 02             	shr    $0x2,%eax
  10361b:	89 c1                	mov    %eax,%ecx
    asm volatile (
  10361d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103620:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103623:	89 d7                	mov    %edx,%edi
  103625:	89 c6                	mov    %eax,%esi
  103627:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103629:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  10362c:	83 e1 03             	and    $0x3,%ecx
  10362f:	74 02                	je     103633 <memcpy+0x38>
  103631:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103633:	89 f0                	mov    %esi,%eax
  103635:	89 fa                	mov    %edi,%edx
  103637:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10363a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10363d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  103640:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  103643:	83 c4 20             	add    $0x20,%esp
  103646:	5e                   	pop    %esi
  103647:	5f                   	pop    %edi
  103648:	5d                   	pop    %ebp
  103649:	c3                   	ret    

0010364a <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  10364a:	55                   	push   %ebp
  10364b:	89 e5                	mov    %esp,%ebp
  10364d:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  103650:	8b 45 08             	mov    0x8(%ebp),%eax
  103653:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  103656:	8b 45 0c             	mov    0xc(%ebp),%eax
  103659:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  10365c:	eb 2e                	jmp    10368c <memcmp+0x42>
        if (*s1 != *s2) {
  10365e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103661:	0f b6 10             	movzbl (%eax),%edx
  103664:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103667:	0f b6 00             	movzbl (%eax),%eax
  10366a:	38 c2                	cmp    %al,%dl
  10366c:	74 18                	je     103686 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  10366e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103671:	0f b6 00             	movzbl (%eax),%eax
  103674:	0f b6 d0             	movzbl %al,%edx
  103677:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10367a:	0f b6 00             	movzbl (%eax),%eax
  10367d:	0f b6 c8             	movzbl %al,%ecx
  103680:	89 d0                	mov    %edx,%eax
  103682:	29 c8                	sub    %ecx,%eax
  103684:	eb 18                	jmp    10369e <memcmp+0x54>
        }
        s1 ++, s2 ++;
  103686:	ff 45 fc             	incl   -0x4(%ebp)
  103689:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  10368c:	8b 45 10             	mov    0x10(%ebp),%eax
  10368f:	8d 50 ff             	lea    -0x1(%eax),%edx
  103692:	89 55 10             	mov    %edx,0x10(%ebp)
  103695:	85 c0                	test   %eax,%eax
  103697:	75 c5                	jne    10365e <memcmp+0x14>
    }
    return 0;
  103699:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10369e:	89 ec                	mov    %ebp,%esp
  1036a0:	5d                   	pop    %ebp
  1036a1:	c3                   	ret    
