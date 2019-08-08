#include <iostream>
#include <stdio.h>
#include "context.h"
#include <unistd.h>
#include <string>
using namespace std;

context_t cfun, cmain;
char stack[1024*128];

void fun(void *arg)
{
}

void test_swap()
{
	getcontext(&cfun);
	cfun.ss_sp = stack;
	cfun.ss_size = sizeof(stack);
	cfun.uc_link = &cmain;
	makecontext(&cfun, (void(*)(void*))fun, NULL);
	swapcontext(&cmain, &cfun);
}

int main()
{
	for (int i=0; i<200000000; ++i)
	{
		test_swap();
	}
	return 0;
}
