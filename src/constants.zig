const c = @import("c.zig");

pub const Error = error{
    BufferTooShort,
    GeneralError,
    InvalidForChip,
    BadRegister,
    BadLockPrefix,
    BadLegacyPrefix,
    BadRexPrefix,
    BadMap,
    BadEvexVPrime,
    BadEvexZNoMasking,
    NoOutputPointer,
    NoAgenCallBackRegistered,
    BadMemopIndex,
    CallbackProblem,
    GatherRegs,
    InstrTooLong,
    InvalidMode,
    BadEvexLl,
    BadRegMatch,
};

pub fn toError(n: c.xed_error_enum_t) ?Error {
    return switch (n) {
        c.XED_ERROR_NONE => null,
        c.XED_ERROR_BUFFER_TOO_SHORT => error.BufferTooShort,
        c.XED_ERROR_GENERAL_ERROR => error.GeneralError,
        c.XED_ERROR_INVALID_FOR_CHIP => error.InvalidForChip,
        c.XED_ERROR_BAD_REGISTER => error.BadRegister,
        c.XED_ERROR_BAD_LOCK_PREFIX => error.BadLockPrefix,
        c.XED_ERROR_BAD_LEGACY_PREFIX => error.BadLegacyPrefix,
        c.XED_ERROR_BAD_REX_PREFIX => error.BadRexPrefix,
        c.XED_ERROR_BAD_MAP => error.BadMap,
        c.XED_ERROR_BAD_EVEX_V_PRIME => error.BadEvexVPrime,
        c.XED_ERROR_BAD_EVEX_Z_NO_MASKING => error.BadEvexZNoMasking,
        c.XED_ERROR_NO_OUTPUT_POINTER => error.NoOutputPointer,
        c.XED_ERROR_NO_AGEN_CALL_BACK_REGISTERED => error.NoAgenCallBackRegistered,
        c.XED_ERROR_BAD_MEMOP_INDEX => error.BadMemopIndex,
        c.XED_ERROR_CALLBACK_PROBLEM => error.CallbackProblem,
        c.XED_ERROR_GATHER_REGS => error.GatherRegs,
        c.XED_ERROR_INSTR_TOO_LONG => error.InstrTooLong,
        c.XED_ERROR_INVALID_MODE => error.InvalidMode,
        c.XED_ERROR_BAD_EVEX_LL => error.BadEvexLl,
        c.XED_ERROR_BAD_REG_MATCH => error.BadRegMatch,
        else => unreachable(),
    };
}
