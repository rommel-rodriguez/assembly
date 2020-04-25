	.text
	.file	"fib.c"
	.globl	fib
	.align	16, 0x90
	.type	fib,@function
fib:                                    # @fib
	.cfi_startproc
# BB#0:
	pushq	%r14
.Ltmp0:
	.cfi_def_cfa_offset 16
	pushq	%rbx
.Ltmp1:
	.cfi_def_cfa_offset 24
	pushq	%rax
.Ltmp2:
	.cfi_def_cfa_offset 32
.Ltmp3:
	.cfi_offset %rbx, -24
.Ltmp4:
	.cfi_offset %r14, -16
	movq	%rdi, %rbx
	cmpq	$2, %rbx
	jge	.LBB0_1
# BB#2:
	movq	%rbx, %rax
	jmp	.LBB0_3
.LBB0_1:
	leaq	-1(%rbx), %rdi
	callq	fib
	movq	%rax, %r14
	addq	$-2, %rbx
	movq	%rbx, %rdi
	callq	fib
	addq	%r14, %rax
.LBB0_3:
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end0:
	.size	fib, .Lfunc_end0-fib
	.cfi_endproc


	.ident	"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"
	.section	".note.GNU-stack","",@progbits
