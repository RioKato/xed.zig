#include "compat.h"

#define static_assert(name, condition) char name[(condition) ? 1 : -1]
#define type_assert(name) static_assert(name, sizeof(compat_##name##_t) == sizeof(name##_t))

type_assert(xed_flag_dfv);
type_assert(xed_flag_set);
type_assert(xed_simple_flag);

xed_iclass_enum_t compat_xed_decoded_inst_get_iclass(const xed_decoded_inst_t *p) {
    return xed_decoded_inst_get_iclass(p);
}

unsigned int compat_xed_decoded_inst_get_iform_enum_dispatch(const xed_decoded_inst_t *p) {
    return xed_decoded_inst_get_iform_enum_dispatch(p);
}

xed_bool_t compat_xed_decoded_inst_get_default_flags_values(const xed_decoded_inst_t *xedd, compat_xed_flag_dfv_t *p) {
    return xed_decoded_inst_get_default_flags_values(xedd, (xed_flag_dfv_t *)p);
}

compat_xed_simple_flag_t *compat_xed_decoded_inst_get_rflags_info(const xed_decoded_inst_t *p) {
    return (compat_xed_simple_flag_t *)xed_decoded_inst_get_rflags_info(p);
}
