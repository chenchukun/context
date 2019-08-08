#ifndef UCONTEXT_H
#define UCONTEXT_H
#include <stddef.h>

#define  INDEX_RAX     0
#define  INDEX_RBX     1
#define  INDEX_RCX     2
#define  INDEX_RDX     3
#define  INDEX_RSI     4
#define  INDEX_RDI     5
#define  INDEX_RBP     6
#define  INDEX_RSP     7
#define  INDEX_R8      8
#define  INDEX_R9      9
#define  INDEX_R12     10
#define  INDEX_R13     11
#define  INDEX_R14     12
#define  INDEX_R15     13


typedef long long int reg_t;

typedef void(*context_func)(void*);

#define REGS 	14

typedef struct context
{
	reg_t regs[REGS];
	
	char *ss_sp;

	size_t ss_size;

	struct context *uc_link;
} context_t;

extern int getcontext(context_t*) asm("__getcontext");

extern int setcontext(const context_t*) asm("__setcontext");

extern void makecontext(context_t *, void (*func) (void*), void *);

int swapcontext(context_t *oucp, const context_t *ucp) asm("__swapcontext");

#endif
