#ifndef CR_GUEST_HPP
#define CR_GUEST_HPP

#include <cr.h>

namespace main_program {
    #include "main.h"
}

CR_EXPORT int cr_main(struct cr_plugin *ctx, enum cr_op operation);

#endif