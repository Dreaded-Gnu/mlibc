# The functions below are taken from musl.
.global fegetround
.type fegetround,%function
fegetround:
	vmrs r0, fpscr
	and r0, r0, #0xc00000
	bx lr

.global __fesetround
.hidden __fesetround
.type __fesetround,%function
__fesetround:
	vmrs r1, fpscr
	bic r1, r1, #0xc00000
	orr r1, r1, r0
	vmsr fpscr, r1
	mov r0, #0
	bx lr

.global fetestexcept
.type fetestexcept,%function
fetestexcept:
	and r0, r0, #0x1f
	vmrs r1, fpscr
	and r0, r0, r1
	bx lr

.global feclearexcept
.type feclearexcept,%function
feclearexcept:
	and r0, r0, #0x1f
	vmrs r1, fpscr
	bic r1, r1, r0
	vmsr fpscr, r1
	mov r0, #0
	bx lr

.global feraiseexcept
.type feraiseexcept,%function
feraiseexcept:
	and r0, r0, #0x1f
	vmrs r1, fpscr
	orr r1, r1, r0
	vmsr fpscr, r1
	mov r0, #0
	bx lr

.global fegetenv
.type fegetenv,%function
fegetenv:
	vmrs r1, fpscr
	str r1, [r0]
	mov r0, #0
	bx lr

// TODO preserve some bits
.global fesetenv
.type fesetenv,%function
fesetenv:
	mov r1, #0
	cmn r0, #1
	beq 1f
	ldr r1, [r0]
1:	vmsr fpscr, r1
	mov r0, #0
	bx lr
