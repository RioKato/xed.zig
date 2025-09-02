#include <xed-interface.h>

typedef xed_uint32_t compat_xed_flag_dfv_t;
typedef xed_uint32_t compat_xed_flag_set_t;

typedef struct compat_xed_simple_flag_s {
    xed_uint8_t nflags;
    xed_uint8_t may_write;
    xed_uint8_t must_write;
    compat_xed_flag_set_t read;
    compat_xed_flag_set_t written;
    compat_xed_flag_set_t undefined;
    xed_uint16_t fa_index;
} compat_xed_simple_flag_t;

xed_iclass_enum_t compat_xed_decoded_inst_get_iclass(const xed_decoded_inst_t *p);
unsigned int compat_xed_decoded_inst_get_iform_enum_dispatch(const xed_decoded_inst_t *p);
xed_bool_t compat_xed_decoded_inst_get_default_flags_values(const xed_decoded_inst_t *xedd, compat_xed_flag_dfv_t *p);
compat_xed_simple_flag_t *compat_xed_decoded_inst_get_rflags_info(const xed_decoded_inst_t *p);
