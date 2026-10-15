#pragma once

#include <stdint.h>
#include <mlibc/tcb.hpp>

namespace mlibc {

inline Tcb *get_current_tcb() {
	// On arm, coprocessor content points to 0x8 bytes before the first TLS block.
	uintptr_t ptr;
	asm volatile ("mrc p15, 0, %0, c13, c0, 2" : "=r"(ptr));
	return reinterpret_cast<Tcb *>(ptr + 0x8 - sizeof(Tcb));
}

inline uintptr_t get_sp() {
	uintptr_t sp;
	asm volatile ("mov %0, sp" : "=r"(sp));
	return sp;
}

} // namespace mlibc
