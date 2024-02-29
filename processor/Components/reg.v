module register(clock, ctrl_writeEnable, ctrl_reset, data_writeReg, reg_out);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [31:0] data_writeReg;
	output [31:0] reg_out;


    ///////////////////////////// Defining D flip flops /////////////////////////////
	dffe_ref dff11(reg_out[0 ], data_writeReg[0 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff12(reg_out[1 ], data_writeReg[1 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff13(reg_out[2 ], data_writeReg[2 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff14(reg_out[3 ], data_writeReg[3 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff15(reg_out[4 ], data_writeReg[4 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff16(reg_out[5 ], data_writeReg[5 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff17(reg_out[6 ], data_writeReg[6 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff18(reg_out[7 ], data_writeReg[7 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff19(reg_out[8 ], data_writeReg[8 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff20(reg_out[9 ], data_writeReg[9 ], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff21(reg_out[10], data_writeReg[10], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff22(reg_out[11], data_writeReg[11], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff23(reg_out[12], data_writeReg[12], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff24(reg_out[13], data_writeReg[13], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff25(reg_out[14], data_writeReg[14], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff26(reg_out[15], data_writeReg[15], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff27(reg_out[16], data_writeReg[16], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff28(reg_out[17], data_writeReg[17], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff29(reg_out[18], data_writeReg[18], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff30(reg_out[19], data_writeReg[19], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff31(reg_out[20], data_writeReg[20], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff32(reg_out[21], data_writeReg[21], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff33(reg_out[22], data_writeReg[22], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff34(reg_out[23], data_writeReg[23], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff35(reg_out[24], data_writeReg[24], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff36(reg_out[25], data_writeReg[25], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff37(reg_out[26], data_writeReg[26], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff38(reg_out[27], data_writeReg[27], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff39(reg_out[28], data_writeReg[28], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff40(reg_out[29], data_writeReg[29], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff41(reg_out[30], data_writeReg[30], clock, ctrl_writeEnable, ctrl_reset);
	dffe_ref dff42(reg_out[31], data_writeReg[31], clock, ctrl_writeEnable, ctrl_reset);
     

endmodule
