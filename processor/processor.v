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
    wire [16:0] immediate;
    wire [26:0] target;
    wire not_clock, ctrl_writeEnable;
    wire [31:0] PC, PC_next, PC_plusone;

    wire Cout, 
    // assign not_clock toovf trigger on falling edge
    assign not_clock = ~clock;

    /////////////////////////  Handling PC /////////////////////////

    assign PC = reset ? 32'b0 : PC_next;

    thirtytwo_bit_adder PC_increment(Cout, 1'b0, PC, 32'b1, PC_plusone, ovf);

    register PC_reg(not_clock, ctrl_writeEnable, reset, data_writeReg, PC_next);




    /////////////////////////  Fetching Instruction /////////////////////////


    // For R type instructions
    assign Opcode = q_imem[1:27];
    assign rd = q_imem[26:22];
    assign rs = q_imem[21:17];
    assign rt = q_imem[6:12];
    assign shamt = q_imem[11:7];
    assign AlU_op = q_imem[6:2];

    // For I type instructions
    assign immediate = q_imem[16:0];

    // For JI type instructions
    assign target = q_imem[26:0];

    /////////////////////////  Decoding Instruction /////////////////////////
    latch F_D(not_clock, ctrl_writeEnable, reset, PC, A, B, IR, reg_1, reg_2, reg_3, reg_4);  //What is PC?

	
	/* END CODE */

endmodule
