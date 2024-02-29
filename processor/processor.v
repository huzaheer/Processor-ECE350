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

    wire [4:0] Opcode, rd, rs, rt, shamt, AlU_op;
    wire [4:0] FD_Opcode, FD_rd, FD_rs, FD_rt, FD_shamt, FD_AlU_op;
    wire [4:0] DX_Opcode, DX_rd, DX_rs, DX_rt, DX_shamt, DX_AlU_op;
    wire [4:0] XM_Opcode, XM_rd, XM_rs, XM_rt, XM_shamt, XM_AlU_op;
    wire [4:0] MW_Opcode, MW_rd, MW_rs, MW_rt, MW_shamt, MW_AlU_op;
    wire [16:0] immediate, FD_immediate, DX_immediate, XM_immediate, MW_immediate;
    wire [26:0] target, FD_target, DX_target, XM_target, MW_target;
    wire not_clock, ctrl_writeEnable, isNotEqual, isLessThan, overflow, isNotEqual_2, isLessThan_2, overflow_2;
    wire [31:0] PC, PC_next, PC_plusone, FDout_1, FDout_2, FDout_3, FDout_4, DXout_1, DXout_2, DXout_3, DXout_4, XMDout_1, XMDout_2, XMDout_3, XMDout_4, MWDout_1, MWout_2, MWout_3, MWout_4;
    wire [31:0] alu_result_temp, alu_result_temp_w_imm, sign_ext_imm, DX_data_writeReg;
    wire Cout, ovf; //randos

    // assign not_clock to trigger on falling edge
    assign not_clock = ~clock;

    // assigning 1 for ctrl_write enable for now
    assign ctrl_writeEnable = 1'b1;

    /////////////////////////  Handling PC /////////////////////////

    assign PC = reset ? 32'b0 : PC_next;

    thirtytwo_bit_adder PC_increment(Cout, 1'b0, PC, 32'b1, PC_plusone, ovf);

    assign address_imem = PC_plusone;

    register PC_reg(not_clock, ctrl_writeEnable, reset, PC_plusone, PC_next);

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
    latch F_D(not_clock, ctrl_writeEnable, reset, PC_plusone, 32'b0, 32'b0, q_imem, FDout_1, FDout_2, FDout_3, FDout_4);

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

    assign ctrl_readRegA = FD_rs;
    assign ctrl_readRegB = FD_rt;
    /////////////////////////  Executing Instruction /////////////////////////
    latch D_X(not_clock, ctrl_writeEnable, reset, FDout_1, data_readRegA, data_readRegB, FDout_4, DXout_1, DXout_2, DXout_3, DXout_4);

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

    alu my_alu(DXout_2, DXout_3, DX_Opcode, DX_shamt, alu_result_temp, isNotEqual, isLessThan, overflow); // ALU for alu ops

    alu my_alu_2(DXout_2, sign_ext_imm, 5'b0, DX_shamt, alu_result_temp_w_imm, isNotEqual_2, isLessThan_2, overflow_2); // ALU for immediate values

    assign DX_data_writeReg = DX_Opcode[0] ? alu_result_temp_w_imm : alu_result_temp;

    /////////////////////////  Memorying Instruction /////////////////////////
	latch X_M(not_clock, ctrl_writeEnable, reset, DXout_1, DX_data_writeReg, DXout_3, DXout_4, XMDout_1, XMDout_2, XMDout_3, XMDout_4);

    // Code for writing to data memory

    /////////////////////////  Writebacking Instruction /////////////////////////
    latch M_W(not_clock, ctrl_writeEnable, reset, XMDout_1, XMDout_2, 32'b0, XMDout_4, MWDout_1, MWout_2, MWout_3, MWout_4);  //Replace 32'b0 with d later

    assign data_writeReg = MWout_2;
    assign ctrl_writeReg = MWout_4[26:22];

	/* END CODE */

endmodule
