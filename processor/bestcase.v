/**
 * READ THIS DESCRIPTION!
 *
 * This is your processor module that will contain the bulk of your code submission. You are to implement
 * a 5-stage pipelined processor in this module, accounting for hazards and implementing bypasses as
 * necessary.
 *
 * Ultimately, your processor will be tested by a master skeleton, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file, Wrapper.v, acts as a small wrapper around your processor for this purpose. Refer to Wrapper.v
 * for more details.
 *
 * As a result, this module will NOT contain the RegFile nor the memory modules. Study the inputs 
 * very carefully - the RegFile-related I/Os are merely signals to be sent to the RegFile instantiated
 * in your Wrapper module. This is the same for your memory elements. 
 *
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for RegFile
    ctrl_writeReg,                  // O: Register to write to in RegFile
    ctrl_readRegA,                  // O: Register to read from port A of RegFile
    ctrl_readRegB,                  // O: Register to read from port B of RegFile
    data_writeReg,                  // O: Data to write to for RegFile
    data_readRegA,                  // I: Data from port A of RegFile
    data_readRegB                   // I: Data from port B of RegFile
	 
	);

	// Control signals
	input clock, reset;
	
	// Imem
    output [31:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [31:0] address_dmem, data;
	output wren;
	input [31:0] q_dmem;

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */

    /////////////////////////  Creating wires ////////////////////////////

    wire [4:0] Opcode, rd, rs, rt, shamt, AlU_op, ctrl_readRegtemp, ctrl_writeRegtemp;
    wire [4:0] FD_Opcode, FD_rd, FD_rs, FD_rt, FD_shamt, FD_AlU_op;
    wire [4:0] DX_Opcode, DX_rd, DX_rs, DX_rt, DX_shamt, DX_AlU_op;
    wire [4:0] XM_Opcode, XM_rd, XM_rs, XM_rt, XM_shamt, XM_AlU_op;
    wire [4:0] MW_Opcode, MW_rd, MW_rs, MW_rt, MW_shamt, MW_AlU_op;
    wire [16:0] immediate, FD_immediate, DX_immediate, XM_immediate, MW_immediate;
    wire [26:0] target, FD_target, DX_target, XM_target, MW_target;
    wire not_clock, ctrl_writeEnable, isNotEqual, isLessThan, overflow, isNotEqual_2, isLessThan_2, overflow_2;
    wire [31:0] PC, PC_next, PC_plusone, FDout_1, FDout_2, FDout_3, FDout_4, DXout_1, DXout_2, DXout_3, DXout_4, XMDout_1, XMDout_2, XMDout_3, XMDout_4, MWDout_1, MWout_2, MWout_3, MWout_4;
    wire [31:0] alu_result_temp, alu_result_temp_w_imm, sign_ext_imm, DX_data_writeReg, multdiv_result, new_address, DX_data_writeReg_2, new_address_2;
    wire Cout, ovf, ctrl_MULT, ctrl_DIV, data_exception, data_resultRDY, my_counter_reset, turn_off, ctrl_DIV_initial, ctrl_MULT_initial, latch_enable, stalled_enable; //randos
    wire [4:0] counter_out;
    wire [31:0] PC_or_Reg, X_to_M, D_to_X, PC_or_Reg_or_Rs, DX_data_writeReg_3, altDXout_4;//more randos
    wire multdiv_alarm, diff_latch_enable, do_bex, checK_rstat_1, checK_rstat_2, checK_rstat_3, checK_rstat_4, checK_rstat_5, there_is_rs, not_in_use_1, not_in_use_2, not_in_use_3;
    wire [31:0] rstat_1, rstat_2, rstat_3, rstat_4, rstat_5, rs_temp_1, actualrs, altFDout_4, DXout_1_plus_one;
    wire [31:0] ALU_input_A_check1, ALU_input_A_check2, ALU_input_B_check1, ALU_input_B_check2, WM_bypass, stall, account_stall;
    // assign not_clock to trigger on falling edge
    assign not_clock = ~clock;
    assign diff_latch_enable = 1'b1;
    /////////////////////////  Handling PC /////////////////////////

    assign PC = reset ? 32'b0 : PC_next;

    thirtytwo_bit_adder PC_increment(Cout, 1'b0, PC, 32'b1, PC_plusone, ovf);

    assign address_imem = (DX_Opcode == 5'b00001 || DX_Opcode == 5'b00011 || DX_Opcode == 5'b00100 || (DX_Opcode == 5'b00010 && isNotEqual == 1'b1) || (DX_Opcode == 5'b00110 && isLessThan == 1'b1) || (DX_Opcode == 5'b10110 && do_bex == 1'b1)) ? new_address_2 : PC_plusone;

    register PC_reg(not_clock, stalled_enable, reset, address_imem, PC_next);

    /////////////////////////  Fetching Instruction /////////////////////////

    // For R type instructions
    assign Opcode = q_imem[31:27];
    assign rd = q_imem[26:22];
    assign rs = q_imem[21:17];
    assign rt = q_imem[16:12];
    assign shamt = q_imem[11:7];
    assign AlU_op = q_imem[6:2];

    // For I type instructions
    assign immediate = q_imem[16:0];

    // For JI type instructions
    assign target = q_imem[26:0];
    
    /////////////////////////  Decoding Instruction /////////////////////////
    latch F_D(not_clock, stalled_enable, reset, address_imem, 32'b0, 32'b0, q_imem, FDout_1, FDout_2, FDout_3, FDout_4);

    // For R type instructions
    assign FD_Opcode = FDout_4[31:27];
    assign FD_rd = FDout_4[26:22];
    assign FD_rs = FDout_4[21:17];
    assign FD_rt = FDout_4[16:12];
    assign FD_shamt = FDout_4[11:7];
    assign FD_AlU_op = FDout_4[6:2];

    // For I type instructions
    assign FD_immediate = FDout_4[16:0];

    // For JI type instructions
    assign FD_target = FDout_4[26:0];

    assign ctrl_readRegtemp = (FD_Opcode == 5'b00100 || FD_Opcode == 5'b00010 || FD_Opcode == 5'b00110 || FD_Opcode == 5'b00111 || FD_Opcode == 5'b01000) ? FD_rd : FD_rs; // for when u want rd to be read from
    assign ctrl_readRegA = (FD_Opcode == 5'b10110) ?  5'b11110: ctrl_readRegtemp;
    assign ctrl_readRegB = (FD_Opcode == 5'b00100 || FD_Opcode == 5'b00010 || FD_Opcode == 5'b00110 || FD_Opcode == 5'b00111 || FD_Opcode == 5'b01000) ? FD_rs : FD_rt; // then equivalently you want rs for rt

    ///////// Flushing this instruction incase the next instruction is a taken branch or jump or if stall in which case we remember but wait one cycle before continuing
    assign altFDout_4 = (DX_Opcode == 5'b00001 || DX_Opcode == 5'b00011 || stall == 1'b1 || DX_Opcode == 5'b00100 || (DX_Opcode == 5'b00010 && isNotEqual == 1'b1) || (DX_Opcode == 5'b00110 && isLessThan == 1'b1) || (DX_Opcode == 5'b10110 && do_bex == 1'b1)) ? 32'b0 : FDout_4;

    //////// Logic for when to stall
    assign stall = (DX_Opcode == 5'b01000 && ((FD_rs == DX_rd) || (DX_Opcode != 5'b00111 && FD_rt == DX_rd))) ? 1'b1 : 1'b0;

    assign stalled_enable = (stall == 1'b1 || latch_enable == 1'b0) ? 1'b0 : 1'b1;

    /////////////////////////  Executing Instruction /////////////////////////
    latch D_X(not_clock, latch_enable, reset, FDout_1, data_readRegA, data_readRegB, altFDout_4, DXout_1, DXout_2, DXout_3, DXout_4);

    // For R type instructions
    assign DX_Opcode = DXout_4[31:27];
    assign DX_rd = DXout_4[26:22];
    assign DX_rs = DXout_4[21:17];
    assign DX_rt = DXout_4[16:12];
    assign DX_shamt = DXout_4[11:7];
    assign DX_AlU_op = DXout_4[6:2];

    // For I type instructions
    assign DX_immediate = DXout_4[16:0];

    // For JI type instructions
    assign DX_target = DXout_4[26:0];

    assign sign_ext_imm = {{15{DX_immediate[16]}}, DX_immediate};

    // bypass logic for ALU input A
    assign ALU_input_A_check1 = (DXout_4[21:17] == XMDout_4[26:22]) ? X_to_M : DXout_2;

    assign ALU_input_A_check2 = (DXout_4[21:17] == MWout_4[26:22]) ? data_writeReg : ALU_input_A_check1;

    //bypass logic for ALU input B
    assign ALU_input_B_check1 = ((DXout_4[16:12] == XMDout_4[26:22] && DX_Opcode == 5'b00000) || ((DX_Opcode == 5'b00111 || DX_Opcode == 5'b01000) && DXout_4[21:17] == XMDout_4[26:22] && XMDout_4[31:27] != 5'b00111)) ? X_to_M : DXout_3;

    assign ALU_input_B_check2 = ((DXout_4[16:12] == MWout_4[26:22] && DX_Opcode == 5'b00000) || ((DX_Opcode == 5'b00111 || DX_Opcode == 5'b01000) && DXout_4[21:17] == MWout_4[26:22] && MWout_4[31:27] != 5'b00111)) ? data_writeReg : ALU_input_B_check1;

    alu my_alu(ALU_input_A_check2, ALU_input_B_check2, DX_AlU_op, DX_shamt, alu_result_temp, isNotEqual, isLessThan, overflow); // ALU for alu ops

    alu my_alu_3(DXout_1, 32'b1, 5'b0, 5'b0, DXout_1_plus_one, not_in_use_1, not_in_use_2, not_in_use_3);

    assign PC_or_Reg = (DX_Opcode == 5'b00010 || DX_Opcode == 5'b00110) ? DXout_1_plus_one : ALU_input_A_check2; // Choosing between PC and normal Rs

    assign PC_or_Reg_or_Rs = (DX_Opcode == 5'b00111 || DX_Opcode == 5'b01000) ? ALU_input_B_check2 : PC_or_Reg; // Choosing between rs or rd in case of lw or sw

    alu my_alu_2(PC_or_Reg_or_Rs, sign_ext_imm, 5'b0, DX_shamt, alu_result_temp_w_imm, isNotEqual_2, isLessThan_2, overflow_2); // ALU for immediate values

    assign DX_data_writeReg = (DX_Opcode[0] == 1'b1 || DX_Opcode == 5'b00111 || DX_Opcode == 5'b01000) ? alu_result_temp_w_imm : alu_result_temp; // for lw, sw, or addi use immediate value

    assign DX_data_writeReg_2 = (DX_Opcode == 5'b00011) ? PC : DX_data_writeReg;

    assign do_bex = (DXout_2 != 32'b0) ? 1'b1 : 1'b0;

    assign new_address = (DX_Opcode == 5'b00100) ? DXout_2 : {PC[31:27], DX_target};

    assign new_address_2 = ((DX_Opcode == 5'b00010 && isNotEqual == 1'b1) || (DX_Opcode == 5'b00110 && isLessThan == 1'b1)) ? alu_result_temp_w_imm : new_address;

    assign D_to_X = (DX_Opcode == 5'b00111) ? DXout_2 : DXout_3; // D_to_X = $rd if lw or sw

    // when multdiv, make ctrl_mult or ctrl_div high, turn off write enable and turn it back on when data ready is pulsed

    assign multdiv_alarm = (DX_AlU_op == 5'b00110 || DX_AlU_op == 5'b00111) ? 1'b1 : 1'b0; // sound the alarm when multdiv

    assign ctrl_MULT = (DX_AlU_op == 5'b00110 && counter_out == 5'b00000) ? 1'b1 : 1'b0; // turn ctrl_mult on only for one cycle --> when ALU_op and counter is 0

    assign ctrl_DIV = (DX_AlU_op == 5'b00111 && counter_out == 5'b00000) ? 1'b1 : 1'b0; // turn ctrl_div on only for one cycle --> when ALU_op and counter is 0

    multdiv my_multdiv(DXout_2, DXout_3, ctrl_MULT, ctrl_DIV, clock, multdiv_result, data_exception, data_resultRDY); // do ze operation

    assign my_counter_reset = ((DX_AlU_op == 5'b00110 && counter_out != 5'b01111) || (DX_AlU_op == 5'b00111 && counter_out != 5'b11111)) ? 1'b0 : 1'b1; // reset counter once data result is ready

    counter_32 hello_hi_bye_bye(1'b1, not_clock, counter_out, my_counter_reset); // do ze counting

    assign DX_data_writeReg_3 = (DX_Opcode == 5'b00000 && (DX_AlU_op == 5'b00110 || DX_AlU_op == 5'b00111)) ? multdiv_result : DX_data_writeReg_2; // choose multdiv output is ALU operation and current ALU code

    assign latch_enable = (((DX_AlU_op == 5'b00110 && data_resultRDY == 1'b0) || (DX_AlU_op == 5'b00111 && data_resultRDY == 1'b0)) && DX_Opcode == 5'b00000) ? 1'b0 : 1'b1; // turn latches off if multdiv operation and result not ready

    // Checking for status registers

    assign rstat_1 = (DX_AlU_op == 5'b00000) && (overflow == 1'b1) ? 32'b1 : 32'b0;
    assign rstat_2 = (DX_Opcode == 5'b00101 && overflow_2 == 1'b1) ? 32'b00000000000000000000000000000010 : 32'b0;
    assign rstat_3 = (DX_AlU_op == 5'b00001 && overflow == 1'b1) ? 32'b00000000000000000000000000000011 : 32'b0;
    assign rstat_4 = (DX_AlU_op == 5'b00110 && data_exception == 1'b1) ? 32'b00000000000000000000000000000100 : 32'b0;
    assign rstat_5 = (DX_AlU_op == 5'b00111 && data_exception == 1'b1) ? 32'b00000000000000000000000000000101 : 32'b0;

    assign checK_rstat_1 = (DX_AlU_op == 5'b00000 && overflow == 1'b1) ? 1'b1 : 1'b0;
    assign checK_rstat_2 = (DX_Opcode == 5'b00101 && overflow_2 == 1'b1) ? 1'b1 : 1'b0;
    assign checK_rstat_3 = (DX_AlU_op == 5'b00001 && overflow == 1'b1) ? 1'b1 : 1'b0;
    assign checK_rstat_4 = (DX_AlU_op == 5'b00110 && data_exception == 1'b1) ? 1'b1 : 1'b0;
    assign checK_rstat_5 = (DX_AlU_op == 5'b00111 && data_exception == 1'b1) ? 1'b1 : 1'b0;

    or finalchecl(there_is_rs, checK_rstat_1, checK_rstat_2, checK_rstat_3, checK_rstat_4, checK_rstat_5);

    mux_8 chooser(rs_temp_1, DX_AlU_op[2:0], rstat_1, rstat_3, 0, 0, 0, 0, rstat_4, rstat_5);

    assign actualrs = (DX_Opcode == 5'b00101) ? rstat_2 : rs_temp_1;

    assign altDXout_4 = (there_is_rs == 1'b1) ? {5'b10101, actualrs[26:0]} : DXout_4;

    /////////////////////////  Memorying Instruction /////////////////////////
	latch X_M(not_clock, diff_latch_enable, reset, DXout_1, DX_data_writeReg_3, D_to_X, altDXout_4, XMDout_1, XMDout_2, XMDout_3, XMDout_4);

    assign XM_Opcode = DXout_4[31:27];
    assign XM_rd = DXout_4[26:22];
    assign XM_rs = DXout_4[21:17];
    assign XM_rt = DXout_4[16:12];
    assign XM_shamt = DXout_4[11:7];
    assign XM_AlU_op = DXout_4[6:2];

    assign address_dmem = XMDout_2;
    assign wren = (XMDout_4[31:27] == 5'b00111) ? 1'b1 : 1'b0;
    assign X_to_M = (XMDout_4[31:27] == 5'b01000) ? q_dmem : XMDout_2; // choose either result or q_dmem incase of lw
    assign data = (XMDout_4[26:22] == MWout_4[26:22]) ? data_writeReg : XMDout_3; //data = $rd

    /////////////////////////  Writebacking Instruction /////////////////////////
    latch M_W(not_clock, diff_latch_enable, reset, XMDout_1, X_to_M, 32'b0, XMDout_4, MWDout_1, MWout_2, MWout_3, MWout_4);  //Replace 32'b0 with d later

    assign ctrl_writeEnable = (MWout_4[31:27] == 5'b00000 || MWout_4[31:27] == 5'b00101 || MWout_4[31:27] == 5'b00011 || MWout_4[31:27] == 5'b01000 || MWout_4[31:27] == 5'b10101) ? 1'b1 : 1'b0;
    assign data_writeReg = (MWout_4[31:27] == 5'b10101) ? {5'b00000, MWout_4[26:0]} : MWout_2;
    assign ctrl_writeRegtemp = (MWout_4[31:27] == 5'b00011) ? 5'b11111 : MWout_4[26:22]; 
    assign ctrl_writeReg = (MWout_4[31:27] == 5'b10101) ? 5'b11110 : ctrl_writeRegtemp;
	/* END CODE */

endmodule