#include "cr_guest.hpp"
#include <cassert>
#include <cr.h>

CR_EXPORT int cr_main(struct cr_plugin *ctx, enum cr_op operation) {
    assert(ctx);
    // switch (operation) {
    //     case CR_LOAD:   return on_load(...); // loading back from a reload
    //     case CR_UNLOAD: return on_unload(...); // preparing to a new reload
    //     case CR_CLOSE: ...; // the plugin will close and not reload anymore
    // }
    // CR_STEP
    return main_program::main();
}