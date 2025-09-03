const std = @import("std");
const c = @import("c.zig");
const constants = @import("constants.zig");
const State = @import("state.zig").State;

pub const Decoder = extern struct {
    inner: c.xed_decoded_inst_t,

    const Self = @This();

    pub fn decode(self: *Self, itext: []const u8) constants.Error!void {
        const err = c.xed_decode(&self.inner, itext.ptr, @intCast(itext.len));

        if (constants.toError(err)) |e| {
            return e;
        }
    }

    pub fn decodeWithFeatures(self: *Self, itext: []const u8, features: *c.xed_chip_features_t) constants.Error!void {
        const err = c.xed_decode_with_features(&self.inner, itext.ptr, @intCast(itext.len), features);

        if (constants.toError(err)) |e| {
            return e;
        }
    }

    pub fn ildDecode(self: *Self, itext: []const u8) constants.Error!void {
        const err = c.xed_ild_decode(&self.inner, itext.ptr, @intCast(itext.len));

        if (constants.toError(err)) |e| {
            return e;
        }
    }

    pub fn valid(self: *const Self) bool {
        return c.xed_decoded_inst_valid(&self.inner) != 0;
    }

    pub fn inst(self: *const Self) *const c.xed_inst_t {
        return c.xed_decoded_inst_inst(&self.inner);
    }

    pub fn getCategory(self: *const Self) c.xed_category_enum_t {
        return c.xed_decoded_inst_get_category(&self.inner);
    }

    pub fn getExtension(self: *const Self) c.xed_extension_enum_t {
        return c.xed_decoded_inst_get_extension(&self.inner);
    }

    pub fn getIsaSet(self: *const Self) c.xed_isa_set_enum_t {
        return c.xed_decoded_inst_get_isa_set(&self.inner);
    }

    pub fn getIclass(self: *const Self) c.xed_iclass_enum_t {
        return c.compat_xed_decoded_inst_get_iclass(&self.inner);
    }

    pub fn getAttribute(self: *const Self, attr: c.xed_attribute_enum_t) u32 {
        return c.xed_decoded_inst_get_attribute(&self.inner, attr);
    }

    pub fn getAttributes(self: *const Self) c.xed_attributes_t {
        return c.xed_decoded_inst_get_attributes(&self.inner);
    }

    pub fn isXacquire(self: *const Self) u32 {
        return c.xed_decoded_inst_is_xacquire(&self.inner);
    }

    pub fn isXrelease(self: *const Self) u32 {
        return c.xed_decoded_inst_is_xrelease(&self.inner);
    }

    pub fn hasMpxPrefix(self: *const Self) u32 {
        return c.xed_decoded_inst_has_mpx_prefix(&self.inner);
    }

    pub fn isApxZu(self: *const Self) bool {
        return c.xed_decoded_inst_is_apx_zu(&self.inner) != 0;
    }

    pub fn getModrm(self: *const Self) u8 {
        return c.xed_decoded_inst_get_modrm(&self.inner);
    }

    pub fn maskedVectorOperation(self: *Self) bool {
        return c.xed_decoded_inst_masked_vector_operation(&self.inner) != 0;
    }

    pub fn vectorLengthBits(self: *const Self) c_uint {
        return c.xed_decoded_inst_vector_length_bits(&self.inner);
    }

    pub fn getNprefixes(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_nprefixes(&self.inner);
    }

    pub fn operandsConst(self: *const Self) *const c.xed_operand_values_t {
        return c.xed_decoded_inst_operands_const(&self.inner);
    }

    pub fn operands(self: *Self) *c.xed_operand_values_t {
        return c.xed_decoded_inst_operands(&self.inner);
    }

    pub fn operandLengthBits(self: *const Self, operand_index: c_uint) c_uint {
        return c.xed_decoded_inst_operand_length_bits(&self.inner, operand_index);
    }

    pub fn operandLength(self: *const Self, operand_index: c_uint) c_uint {
        return c.xed_decoded_inst_operand_length(&self.inner, operand_index);
    }

    pub fn noperands(self: *const Self) c_uint {
        return c.xed_decoded_inst_noperands(&self.inner);
    }

    pub fn operandElements(self: *const Self, operand_index: c_uint) c_uint {
        return c.xed_decoded_inst_operand_elements(&self.inner, operand_index);
    }

    pub fn operandElementSizeBits(self: *const Self, operand_index: c_uint) c_uint {
        return c.xed_decoded_inst_operand_element_size_bits(&self.inner, operand_index);
    }

    pub fn operandElementType(self: *const Self, operand_index: c_uint) c.xed_operand_element_type_enum_t {
        return c.xed_decoded_inst_operand_element_type(&self.inner, operand_index);
    }

    pub fn operandAction(self: *const Self, operand_index: c_uint) c.xed_operand_action_enum_t {
        return c.xed_decoded_inst_operand_action(&self.inner, operand_index);
    }

    pub fn masking(self: *const Self) bool {
        return c.xed_decoded_inst_masking(&self.inner) != 0;
    }

    pub fn merging(self: *const Self) bool {
        return c.xed_decoded_inst_merging(&self.inner) != 0;
    }

    pub fn zeroing(self: *const Self) bool {
        return c.xed_decoded_inst_zeroing(&self.inner) != 0;
    }

    pub fn avx512DestElements(self: *const Self) c_uint {
        return c.xed_decoded_inst_avx512_dest_elements(&self.inner);
    }

    pub fn zeroSetMode(self: *Self, dstate: State) void {
        c.xed_decoded_inst_zero_set_mode(&self.inner, &dstate.inner);
    }

    pub fn zeroKeepMode(self: *Self) void {
        c.xed_decoded_inst_zero_keep_mode(&self.inner);
    }

    pub fn zero(self: *Self) void {
        c.xed_decoded_inst_zero(&self.inner);
    }

    pub fn setMode(self: *Self, arg_mmode: c.xed_machine_mode_enum_t, arg_stack_addr_width: c.xed_address_width_enum_t) void {
        c.xed_decoded_inst_set_mode(&self.inner, arg_mmode, arg_stack_addr_width);
    }

    pub fn zeroKeepModeFromOperands(self: *Self, operands_: c.xed_operand_values_t) void {
        c.xed_decoded_inst_zero_keep_mode_from_operands(&self.inner, &operands_);
    }

    pub fn getLength(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_length(&self.inner);
    }

    pub fn getByte(self: *const Self, arg_byte_index: c_uint) u8 {
        return c.xed_decoded_inst_get_byte(&self.inner, arg_byte_index);
    }

    pub fn getMachineModeBits(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_machine_mode_bits(&self.inner);
    }

    pub fn getStackAddressModeBits(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_stack_address_mode_bits(&self.inner);
    }

    pub fn getOperandWidth(self: *const Self) u32 {
        return c.xed_decoded_inst_get_operand_width(&self.inner);
    }

    pub fn getInputChip(self: *const Self) c.xed_chip_enum_t {
        return c.xed_decoded_inst_get_input_chip(&self.inner);
    }

    pub fn setInputChip(self: *Self, arg_chip: c.xed_chip_enum_t) void {
        c.xed_decoded_inst_set_input_chip(&self.inner, arg_chip);
    }

    pub fn validForChip(self: *const Self, chip: c.xed_chip_enum_t) bool {
        return c.xed_decoded_inst_valid_for_chip(&self.inner, chip) != 0;
    }

    pub fn validForFeatures(self: *const Self, chip_features: c.xed_chip_features_t) bool {
        return c.xed_decoded_inst_valid_for_features(&self.inner, &chip_features) != 0;
    }

    pub fn getIformEnum(self: *const Self) c.xed_iform_enum_t {
        return c.xed_decoded_inst_get_iform_enum(&self.inner);
    }

    pub fn getIformEnumDispatch(self: *const Self) c_uint {
        return c.compat_xed_decoded_inst_get_iform_enum_dispatch(&self.inner);
    }

    pub fn getSegReg(self: *const Self, mem_idx: c_uint) c.xed_reg_enum_t {
        return c.xed_decoded_inst_get_seg_reg(&self.inner, mem_idx);
    }

    pub fn getBaseReg(self: *const Self, mem_idx: c_uint) c.xed_reg_enum_t {
        return c.xed_decoded_inst_get_base_reg(&self.inner, mem_idx);
    }

    pub fn getScale(self: *const Self, mem_idx: c_uint) c_uint {
        return c.xed_decoded_inst_get_scale(&self.inner, mem_idx);
    }

    pub fn getMemoryDisplacement(self: *const Self, mem_idx: c_uint) i64 {
        return c.xed_decoded_inst_get_memory_displacement(&self.inner, mem_idx);
    }

    pub fn getMemoryDisplacementWidth(self: *const Self, mem_idx: c_uint) c_uint {
        return c.xed_decoded_inst_get_memory_displacement_width(&self.inner, mem_idx);
    }

    pub fn getMemoryDisplacementWidthBits(self: *const Self, mem_idx: c_uint) c_uint {
        return c.xed_decoded_inst_get_memory_displacement_width_bits(&self.inner, mem_idx);
    }

    pub fn getBranchDisplacement(self: *const Self) i64 {
        return c.xed_decoded_inst_get_branch_displacement(&self.inner);
    }

    pub fn getBranchDisplacementWidth(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_branch_displacement_width(&self.inner);
    }

    pub fn getBranchDisplacementWidthBits(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_branch_displacement_width_bits(&self.inner);
    }

    pub fn getUnsignedImmediate(self: *const Self) u64 {
        return c.xed_decoded_inst_get_unsigned_immediate(&self.inner);
    }

    pub fn getImmediateIsSigned(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_immediate_is_signed(&self.inner);
    }

    pub fn getImmediateWidth(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_immediate_width(&self.inner);
    }

    pub fn getImmediateWidthBits(self: *const Self) c_uint {
        return c.xed_decoded_inst_get_immediate_width_bits(&self.inner);
    }

    pub fn getSignedImmediate(self: *const Self) i32 {
        return c.xed_decoded_inst_get_signed_immediate(&self.inner);
    }

    pub fn getSecondImmediate(self: *const Self) u8 {
        return c.xed_decoded_inst_get_second_immediate(&self.inner);
    }

    pub fn getReg(self: *const Self, reg_operand: c.xed_operand_enum_t) c.xed_reg_enum_t {
        return c.xed_decoded_inst_get_reg(&self.inner, reg_operand);
    }

    pub fn hasDefaultFlagsValues(self: *const Self) bool {
        return c.xed_decoded_inst_has_default_flags_values(&self.inner) != 0;
    }

    pub fn getDefaultFlagsValues(self: *const Self, dfv: *c.compat_xed_flag_dfv_t) bool {
        return c.compat_xed_decoded_inst_get_default_flags_values(&self.inner, dfv) != 0;
    }

    pub fn getRflagsInfo(self: *const Self) ?*const c.compat_xed_simple_flag_t {
        return c.compat_xed_decoded_inst_get_rflags_info(&self.inner);
    }

    pub fn usesRflags(self: *const Self) bool {
        return c.xed_decoded_inst_uses_rflags(&self.inner) != 0;
    }

    pub fn numberOfMemoryOperands(self: *const Self) c_uint {
        return c.xed_decoded_inst_number_of_memory_operands(&self.inner);
    }

    pub fn memRead(self: *const Self, mem_idx: c_uint) bool {
        return c.xed_decoded_inst_mem_read(&self.inner, mem_idx) != 0;
    }

    pub fn memWritten(self: *const Self, mem_idx: c_uint) bool {
        return c.xed_decoded_inst_mem_written(&self.inner, mem_idx) != 0;
    }

    pub fn memWrittenOnly(self: *const Self, mem_idx: c_uint) bool {
        return c.xed_decoded_inst_mem_written_only(&self.inner, mem_idx) != 0;
    }

    pub fn conditionallyWritesRegisters(self: *const Self) bool {
        return c.xed_decoded_inst_conditionally_writes_registers(&self.inner) != 0;
    }

    pub fn getMemoryOperandLength(self: *const Self, memop_idx: c_uint) c_uint {
        return c.xed_decoded_inst_get_memory_operand_length(&self.inner, memop_idx);
    }

    pub fn getMemopAddressWidth(self: *const Self, memop_idx: c_uint) c_uint {
        return c.xed_decoded_inst_get_memop_address_width(&self.inner, memop_idx);
    }

    pub fn isPrefetch(self: *const Self) bool {
        return c.xed_decoded_inst_is_prefetch(&self.inner) != 0;
    }

    pub fn isBroadcast(self: *const Self) bool {
        return c.xed_decoded_inst_is_broadcast(&self.inner) != 0;
    }

    pub fn isBroadcastInstruction(self: *const Self) bool {
        return c.xed_decoded_inst_is_broadcast_instruction(&self.inner) != 0;
    }

    pub fn usesEmbeddedBroadcast(self: *const Self) bool {
        return c.xed_decoded_inst_uses_embedded_broadcast(&self.inner) != 0;
    }

    pub fn getIndexReg(self: *const Self, mem_idx: c_uint) c.xed_reg_enum_t {
        return c.xed_decoded_inst_get_index_reg(&self.inner, mem_idx);
    }

    pub fn setScale(self: *Self, scale: c_uint) void {
        c.xed_decoded_inst_set_scale(&self.inner, scale);
    }

    pub fn setMemoryDisplacement(self: *Self, disp: i64, length_bytes: c_uint) void {
        c.xed_decoded_inst_set_memory_displacement(&self.inner, disp, length_bytes);
    }

    pub fn setBranchDisplacement(self: *Self, disp: i64, length_bytes: c_uint) void {
        c.xed_decoded_inst_set_branch_displacement(&self.inner, disp, length_bytes);
    }

    pub fn setImmediateSigned(self: *Self, x: i32, length_bytes: c_uint) void {
        c.xed_decoded_inst_set_immediate_signed(&self.inner, x, length_bytes);
    }

    pub fn setImmediateUnsigned(self: *Self, x: u64, length_bytes: c_uint) void {
        c.xed_decoded_inst_set_immediate_unsigned(&self.inner, x, length_bytes);
    }

    pub fn setMemoryDisplacementBits(self: *Self, disp: i64, length_bits: c_uint) void {
        c.xed_decoded_inst_set_memory_displacement_bits(&self.inner, disp, length_bits);
    }

    pub fn setBranchDisplacementBits(self: *Self, disp: i64, length_bits: c_uint) void {
        c.xed_decoded_inst_set_branch_displacement_bits(&self.inner, disp, length_bits);
    }

    pub fn setImmediateSignedBits(self: *Self, x: i32, length_bits: c_uint) void {
        c.xed_decoded_inst_set_immediate_signed_bits(&self.inner, x, length_bits);
    }

    pub fn setImmediateUnsignedBits(self: *Self, x: u64, length_bits: c_uint) void {
        c.xed_decoded_inst_set_immediate_unsigned_bits(&self.inner, x, length_bits);
    }

    pub fn getUserData(self: *Self) u64 {
        return c.xed_decoded_inst_get_user_data(&self.inner);
    }

    pub fn setUserData(self: *Self, arg_new_value: u64) void {
        c.xed_decoded_inst_set_user_data(&self.inner, arg_new_value);
    }

    pub fn classifyApx(self: *const Self) bool {
        return c.xed_classify_apx(&self.inner) != 0;
    }

    pub fn classifyAmx(self: *const Self) bool {
        return c.xed_classify_amx(&self.inner) != 0;
    }

    pub fn classifyAvx512(self: *const Self) bool {
        return c.xed_classify_avx512(&self.inner) != 0;
    }

    pub fn classifyAvx512Maskop(self: *const Self) bool {
        return c.xed_classify_avx512_maskop(&self.inner) != 0;
    }

    pub fn classifyAvx(self: *const Self) bool {
        return c.xed_classify_avx(&self.inner) != 0;
    }

    pub fn classifySse(self: *const Self) bool {
        return c.xed_classify_sse(&self.inner) != 0;
    }

    pub fn initFromDecode(self: *Self) void {
        c.xed_encoder_request_init_from_decode(&self.inner);
    }

    pub fn patchDisp(self: *Self, itext: []u8, disp: c.xed_enc_displacement_t) bool {
        return c.xed_patch_disp(&self.inner, itext.ptr, disp) != 0;
    }

    pub fn patchBrdisp(self: *Self, itext: []u8, disp: c.xed_encoder_operand_t) bool {
        return c.xed_patch_brdisp(&self.inner, itext.ptr, disp) != 0;
    }

    pub fn patchImm0(self: *Self, itext: []u8, imm0: c.xed_encoder_operand_t) bool {
        return c.xed_patch_imm0(&self.inner, itext.ptr, imm0) != 0;
    }

    pub fn dump(self: *const Self, text: []u8) []u8 {
        c.xed_decoded_inst_dump(&self.inner, text.ptr, @intCast(text.len));
        return std.mem.span(@as([*:0]u8, @ptrCast(text.ptr)));
    }
};

test "decoder" {
    std.testing.refAllDeclsRecursive(Decoder);
}
