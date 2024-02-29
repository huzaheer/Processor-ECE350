module mult(
	data_operandA, data_operandB, 
	ctrl_MULT, clock, 
	data_result, data_exception, data_resultRDY);

    /////////////////////////// Initializing inputs and outputs ///////////////////////////

    input [31:0] data_operandA, data_operandB;
    input clock, ctrl_MULT;

    output [31:0] data_result;
    output data_exception, data_resultRDY, ovf;

    wire [31:0] multiplicand, neg_multiplicand, shifted_multiplicand, shifted_multiplicand_neg, to_add_shifted, S;
    wire [64:0] product, initial_val, continue, to_store, interim;
    wire [31:0] to_add;
    wire [3:0] count;
    wire check_new;
    wire sign_flag, w1, w2, w3, w4, semi_exception, all_ones, all_zeros, not_all_zeros;
    /////////////////////////// Checking for start of new op ///////////////////////////

    counter count_temp(1'b1, clock, count, ctrl_MULT);
    and temp_2(check_ready, count[1], count[2], count[3]);

    assign initial_val = {32'b0, data_operandB, 1'b0};
    assign product = ctrl_MULT ? initial_val : continue;
    assign data_resultRDY = check_ready ? 1'b1 : 1'b0;

    /////////////////////////// Creating all flags for overflow ///////////////////////////

    // Checking if signs don't match up
    xor temp_xor1(w1, data_operandA[31], data_operandB[31]); 
    xor temp_xor2(w2, data_result[31], w1); // if sign_flag == 1, then ovf, msb sign is wrong

    assign A_zero = |data_operandA[31:0];
    assign B_zero = |data_operandB[31:0];

    nand zero_check(w3, A_zero, B_zero);

    assign sign_flag = w3 ? 1'b0 : w2;

    // Checking if any significant bit in upper 32
    // assign all_ones = &to_store[64:33]; // This is 1 if all ones
    // assign all_zeros = |to_store[64:33]; // This is 0 if all zeros

    or check_zeros(all_zeros, to_store[32], to_store[33], to_store[34], to_store[35], to_store[36], to_store[37], to_store[38], to_store[39], to_store[40], to_store[41], to_store[42], to_store[43], to_store[44], to_store[45], to_store[46], to_store[47], to_store[48], to_store[49], to_store[50], to_store[51], to_store[52], to_store[53], to_store[54], to_store[55], to_store[56], to_store[57], to_store[58], to_store[59], to_store[60], to_store[61], to_store[62], to_store[63], to_store[64]);
    and check_ones(all_ones, to_store[32], to_store[33], to_store[34], to_store[35], to_store[36], to_store[37], to_store[38], to_store[39], to_store[40], to_store[41], to_store[42], to_store[43], to_store[44], to_store[45], to_store[46], to_store[47], to_store[48], to_store[49], to_store[50], to_store[51], to_store[52], to_store[53], to_store[54], to_store[55], to_store[56], to_store[57], to_store[58], to_store[59], to_store[60], to_store[61], to_store[62], to_store[63], to_store[64]);
    not (not_all_zeros, all_zeros);

    nor (w4, all_ones, not_all_zeros);
   
    or exception_calc(semi_exception, sign_flag, w4);

    assign data_exception = check_ready ? semi_exception : 1'b0;

    /////////////////////////// Creating multiplicand, shifted multiplicand and negative multiplicand ///////////////////////////
    assign multiplicand = data_operandA;
    assign neg_multiplicand = ~data_operandA + 1'b1;
    assign shifted_multiplicand = data_operandA << 1;
    assign shifted_multiplicand_neg = ~shifted_multiplicand + 1'b1;


     /////////////////////////// Choosing what to add ///////////////////////////
    mux_8 choose_add(to_add, product[2:0], 32'b0, data_operandA, data_operandA, shifted_multiplicand, shifted_multiplicand_neg, neg_multiplicand, neg_multiplicand, 32'b0);

    /////////////////////////// adding ///////////////////////////
    thirtytwo_bit_adder adding(Cout, 1'b0, to_add, product[64:33], S, ovf);
    assign interim = {S, product[32:0]};
    assign to_store = $signed(interim) >>> 2;
    assign data_result = to_store[32:1];

    register reg_64(clock, 1'b1, 1'b0, to_store, continue);

endmodule