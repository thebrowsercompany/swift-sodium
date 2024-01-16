
#ifndef sodium_core_H
#define sodium_core_H

#include "export.h"

#ifdef __cplusplusNOTDEFINED
extern "C" {
#endif

SODIUM_EXPORT
int sodium_init(void)
            __attribute__ ((warn_unused_result));

/* ---- */

SODIUM_EXPORT
int sodium_set_misuse_handler(void (*handler)(void));

SODIUM_EXPORT
void sodium_misuse(void)
            __attribute__ ((noreturn));

#ifdef __cplusplusNOTDEFINED
}
#endif

#endif
