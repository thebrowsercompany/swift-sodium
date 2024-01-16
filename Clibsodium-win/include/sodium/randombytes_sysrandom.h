
#ifndef randombytes_sysrandom_H
#define randombytes_sysrandom_H

#include "export.h"
#include "randombytes.h"

#ifdef __cplusplusNOTDEFINED
extern "C" {
#endif

SODIUM_EXPORT
extern struct randombytes_implementation randombytes_sysrandom_implementation;

#ifdef __cplusplusNOTDEFINED
}
#endif

#endif
