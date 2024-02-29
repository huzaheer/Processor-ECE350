module latch(clock, ctrl_writeEnable, ctrl_reset, PC, A, B, IR, reg_1, reg_2, reg_3, reg_4);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [31:0] PC, A, B, IR;
	output [31:0] reg_1, reg_2, reg_3, reg_4;


    ///////////////////////////// 4 registers /////////////////////////////
    register one(clock, ctrl_writeEnable, ctrl_reset, PC, reg_1);
    register two(clock, ctrl_writeEnable, ctrl_reset, A, reg_2);
    register three(clock, ctrl_writeEnable, ctrl_reset, B, reg_3);
    register four(clock, ctrl_writeEnable, ctrl_reset, IR, reg_4);

endmodule
