#include "mlibc-asm/helpers.h"

PROC_START(_start)
	bl relocateSelf

	mov r0, sp
	bl interpreterMain

	bx r0
PROC_END(_start)

GNU_STACK_NOTE()
