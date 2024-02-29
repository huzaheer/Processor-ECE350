module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);
        
    input [31:0] data_operandA, data_operandB;
    input [4:0] ctrl_ALUopcode, ctrl_shiftamt;
    wire [1:0] w; 
    wire [31:0] result_sra_1, result_sra_2, result_sra_3, result_sra_4;
    wire [31:0] result_sll_1, result_sll_2, result_sll_3, result_sll_4;

    output [31:0] data_result, data_result_add, data_result_sub, data_result_and, data_result_or, data_result_sll, data_result_sra;
    output isNotEqual, isLessThan, overflow, overflow_add, overflow_sub;
    output Cout;
    
    thirtytwo_bit_adder adder_1(Cout, 1'b0, data_operandA, data_operandB, data_result_add, overflow_add);

    thirtytwo_bit_adder adder_2(Cout, 1'b1, data_operandA, data_operandB, data_result_sub, overflow_sub);

    shift_16 tshift_1(result_sra_1, ctrl_shiftamt[4], data_operandA);
    shift_8 tshift_2(result_sra_2, ctrl_shiftamt[3], result_sra_1);
    shift_4 tshift_4(result_sra_3, ctrl_shiftamt[2], result_sra_2);
    shift_2 tshift_8(result_sra_4, ctrl_shiftamt[1], result_sra_3);
    shift_1 tshift_16(data_result_sra, ctrl_shiftamt[0], result_sra_4);

    left_shift_16 Lshift_1(result_sll_1, ctrl_shiftamt[4], data_operandA);
    left_shift_8 Lshift_2(result_sll_2, ctrl_shiftamt[3], result_sll_1);
    left_shift_4 Lshift_4(result_sll_3, ctrl_shiftamt[2], result_sll_2);
    left_shift_2 Lshift_8(result_sll_4, ctrl_shiftamt[1], result_sll_3);
    left_shift_1 Lshift_16(data_result_sll, ctrl_shiftamt[0], result_sll_4);

    and_32 and_op(data_result_and, data_operandA, data_operandB);

    or_32 or_op(data_result_or, data_operandA, data_operandB);

    or not_equal(isNotEqual, data_result_sub[0], data_result_sub[1], data_result_sub[2], data_result_sub[3], data_result_sub[4], data_result_sub[5], data_result_sub[6], data_result_sub[7], data_result_sub[8], data_result_sub[9], data_result_sub[10], data_result_sub[11], data_result_sub[12], data_result_sub[13], data_result_sub[14], data_result_sub[15], data_result_sub[16], data_result_sub[17], data_result_sub[18], data_result_sub[19], data_result_sub[20], data_result_sub[21], data_result_sub[22], data_result_sub[23], data_result_sub[24], data_result_sub[25], data_result_sub[26], data_result_sub[27], data_result_sub[28], data_result_sub[29], data_result_sub[30], data_result_sub[31]);

    or (w[0], data_result_sub[31], 1'b0);
    xor (isLessThan, w[0], overflow_sub);

    mux_8  choose(data_result, ctrl_ALUopcode[2:0], data_result_add, data_result_sub, data_result_and, data_result_or, data_result_sll, data_result_sra, 0, 0);

    mux_2_1  choose_ovf(overflow, ctrl_ALUopcode[0], overflow_add, overflow_sub);
endmodule