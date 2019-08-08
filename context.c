#include "context.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <pthread.h>

extern int __start_context(const context_t*) asm("__start_context");

void makecontext (context_t *uc, void (*func) (void*), void *arg)
{
	reg_t* sp = (reg_t*)(uc->ss_sp + uc->ss_size);
	sp = (reg_t*)(((long long int)sp & -16LL) - 8 - sizeof(reg_t));
	sp[0] = (reg_t)(__start_context);
	uc->regs[INDEX_RSP] = (reg_t)sp;
	uc->regs[INDEX_RAX] = (reg_t)func;
	uc->regs[INDEX_RDI] = (reg_t)arg;
	// rbx为被调用者保存寄存器，利用该寄存器保存uc_link
	uc->regs[INDEX_RBX] = (reg_t)(uc->uc_link);
}
