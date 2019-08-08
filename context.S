
#define  OFFSET_RAX     0
#define  OFFSET_RBX     8
#define  OFFSET_RCX     16
#define  OFFSET_RDX     24
#define  OFFSET_RSI     32
#define  OFFSET_RDI     40
#define  OFFSET_RBP     48
#define  OFFSET_RSP     56
#define  OFFSET_R8      64
#define  OFFSET_R9      72
#define  OFFSET_R12     80
#define  OFFSET_R13     88
#define  OFFSET_R14     96
#define  OFFSET_R15     104


.global __getcontext
.type __getcontext, @function

#      -------
#      | ... |
#      | ... |
#      | ... |
# rsp->| ret |
# rdi -> context*

__getcontext:
	leaq 8(%rsp), 	%rax
	movq %rax, 		OFFSET_RSP(%rdi)		# 保存调用__getcontext前的rsp
	movq (%rsp), 	%rax					# 返回地址 
	movq %rax, 		OFFSET_RAX(%rdi)		
	movq %rbx, 		OFFSET_RBX(%rdi)
	movq %rcx, 		OFFSET_RCX(%rdi)
	movq %rdx, 		OFFSET_RDX(%rdi)
	movq %rsi, 		OFFSET_RSI(%rdi)
	movq %rdi, 		OFFSET_RDI(%rdi)
	movq %rbp, 		OFFSET_RBP(%rdi)
	movq %r8, 		OFFSET_R8(%rdi)
	movq %r9, 		OFFSET_R9(%rdi)
	movq %r12, 		OFFSET_R12(%rdi)
	movq %r13, 		OFFSET_R13(%rdi)
	movq %r14, 		OFFSET_R14(%rdi)
	movq %r15, 		OFFSET_R15(%rdi)
	movq $0, 		%rax
	ret


.global __setcontext
.type __setcontext, @function

__setcontext:
	movq OFFSET_RSP(%rdi),	%rsp
	movq OFFSET_RAX(%rdi),	%rax
	pushq %rax				# 恢复__getcontext时的返回地址
	movq OFFSET_RBX(%rdi),	%rbx
	movq OFFSET_RCX(%rdi),	%rcx
	movq OFFSET_RDX(%rdi),	%rdx
	movq OFFSET_RSI(%rdi),	%rsi
	movq OFFSET_R8(%rdi), 	%r8
	movq OFFSET_R9(%rdi), 	%r9
	movq OFFSET_R12(%rdi), 	%r12
	movq OFFSET_R13(%rdi), 	%r13
	movq OFFSET_R14(%rdi), 	%r14
	movq OFFSET_R15(%rdi), 	%r15
	movq OFFSET_RDI(%rdi),	%rax
	movq %rax,				%rdi
	movq $0,				%rax
	ret


.global __swapcontext
.type __swapcontext, @function

__swapcontext:
	leaq 8(%rsp), 	%rax
	movq %rax, 		OFFSET_RSP(%rdi)		# 保存调用__swapcontext前的rsp
	movq (%rsp), 	%rax					# 返回地址 
	movq %rax, 		OFFSET_RAX(%rdi)		
	movq %rbx, 		OFFSET_RBX(%rdi)
	movq %rcx, 		OFFSET_RCX(%rdi)
	movq %rdx, 		OFFSET_RDX(%rdi)
	movq %rsi, 		OFFSET_RSI(%rdi)
	movq %rdi, 		OFFSET_RDI(%rdi)
	movq %rbp, 		OFFSET_RBP(%rdi)
	movq %r8, 		OFFSET_R8(%rdi)
	movq %r9, 		OFFSET_R9(%rdi)
	movq %r12, 		OFFSET_R12(%rdi)
	movq %r13, 		OFFSET_R13(%rdi)
	movq %r14, 		OFFSET_R14(%rdi)
	movq %r15, 		OFFSET_R15(%rdi)

	movq OFFSET_RSP(%rsi),	%rsp
	movq OFFSET_RAX(%rsi),	%rax
	pushq %rax				# 恢复__getcontext时的返回地址
	movq OFFSET_RBX(%rsi),	%rbx
	movq OFFSET_RCX(%rsi),	%rcx
	movq OFFSET_RDX(%rsi),	%rdx
	movq OFFSET_RSI(%rsi),	%rsi
	movq OFFSET_R8(%rsi), 	%r8
	movq OFFSET_R9(%rsi), 	%r9
	movq OFFSET_R12(%rsi), 	%r12
	movq OFFSET_R13(%rsi), 	%r13
	movq OFFSET_R14(%rsi), 	%r14
	movq OFFSET_R15(%rsi), 	%r15
	movq OFFSET_RDI(%rsi),	%rax
	movq %rax,				%rdi
	movq $0,				%rax

	movq $0, 		%rax
	ret
	
	

.global __start_context
.type __start_context, @function

__start_context:
	movq %rbx, %rdi
	testq %rdi, %rdi
	jne _set
	movq $0, %rdi
	call pthread_exit
_set:
	call __setcontext
