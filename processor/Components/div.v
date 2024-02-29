// A = DIVIDEND
// B = DIVISOR

module div(data_operandA, data_operandB, 
	ctrl_DIV, clock, 
	data_result, data_exception, data_resultRDY);

    /////////////////////////// Initializing inputs and outputs ///////////////////////////
    input [31:0] data_operandA, data_operandB;
    input clock, ctrl_DIV;

    output [31:0] data_result;
    wire [4:0] count;
    output data_exception, data_resultRDY;
    wire [63:0] initial_val, LS_AQ, to_save, continue, AQ;  //64 bit wires
    wire [31:0] opp_data_operandA, opp_data_operandB, A_to_use, B_to_use, top_32_after_correction, neg_B_to_use; //32 bit wires
    wire [31:0] R_minus_V, R_plus_V, temp, neg_temp; //more 32 bit wires
    wire check_ready, Cout1, Cout2, ovf, correct_Q, all_zeros, invert_check;   //1 bit wires

    /////////////////////////// Checking for start of new op ///////////////////////////
    counter_32 count_temp(1'b1, clock, count, ctrl_DIV);
    and temp_2(check_ready, count[1], count[2], count[3], count[4]);
    assign data_resultRDY = check_ready;

    assign opp_data_operandA = ~data_operandA + 1'b1;
    assign opp_data_operandB = ~data_operandB + 1'b1;

    assign A_to_use = data_operandA[31] ? opp_data_operandA : data_operandA;
    assign B_to_use =  data_operandB[31] ? opp_data_operandB : data_operandB;

    // assign neg_B_to_use = ~B_to_use + 1'b1;

    assign initial_val = {32'b0, A_to_use};
    assign AQ = ctrl_DIV ? initial_val : continue;

    /////////////////////////// Doing Division ///////////////////////////
    assign LS_AQ = AQ << 1;

    thirtytwo_bit_adder subing(Cout1, 1'b1, LS_AQ[63:32], B_to_use, R_minus_V, ovf);
    thirtytwo_bit_adder adding(Cout2, 1'b0, B_to_use, LS_AQ[63:32], R_plus_V, ovf);

    assign top_32_after_correction = LS_AQ[63] ? R_plus_V : R_minus_V;

    assign correct_Q = top_32_after_correction[31] ? 1'b0 : 1'b1;

    assign to_save = {top_32_after_correction, LS_AQ[31:1], correct_Q};

    assign all_zeros = |data_operandB[31:0]; // This is 0 if all zeros

    assign temp = all_zeros ? to_save[31:0] : 32'b0;

    assign neg_temp = ~temp + 1'b1;

    assign data_exception = ~all_zeros;

    xor invert(invert_check, data_operandA[31], data_operandB[31]);

    assign data_result = invert_check ? neg_temp : temp;

    /////////////////////////// Saving to Reg ///////////////////////////
    register_64 hellokitty(clock, 1'b1, 1'b0, to_save, continue);

endmodule