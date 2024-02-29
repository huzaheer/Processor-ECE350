module regfile (
	clock,
	ctrl_writeEnable, ctrl_reset, ctrl_writeReg,
	ctrl_readRegA, ctrl_readRegB, data_writeReg,
	data_readRegA, data_readRegB
);

	input clock, ctrl_writeEnable, ctrl_reset;
	input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	input [31:0] data_writeReg;

	output [31:0] data_readRegA, data_readRegB;
	wire [31:0] dataread0, dataread1, dataread2, dataread3, dataread4, dataread5, dataread6, dataread7, dataread8, dataread9, dataread10, dataread11, dataread12, dataread13, dataread14, dataread15, dataread16, dataread17, dataread18, dataread19, dataread20, dataread21, dataread22, dataread23, dataread24, dataread25, dataread26, dataread27, dataread28, dataread29, dataread30, dataread31;
	wire write_enable0, write_enable1, write_enable2, write_enable3, write_enable4, write_enable5, write_enable6, write_enable7, write_enable8, write_enable9, write_enable10, write_enable11, write_enable12, write_enable13, write_enable14, write_enable15, write_enable16, write_enable17, write_enable18, write_enable19, write_enable20, write_enable21, write_enable22, write_enable23, write_enable24, write_enable25, write_enable26, write_enable27, write_enable28, write_enable29, write_enable30, write_enable31;
	wire [31:0] decode_1, decode_2, decode_3, enable;
	assign enable = 32'b1;
	
	//////////////////////////////// Decoding Signals ////////////////////////////////
	assign decode_1 = enable << ctrl_readRegA;
	assign decode_2 = enable << ctrl_readRegB;
	assign decode_3 = enable << ctrl_writeReg;

	//////////////////////////////// Generating WriteEnable Signals ////////////////////////////////

	and we11(write_enable0 , decode_3[0 ], ctrl_writeEnable);
	and we12(write_enable1 , decode_3[1 ], ctrl_writeEnable);
	and we13(write_enable2 , decode_3[2 ], ctrl_writeEnable);
	and we14(write_enable3 , decode_3[3 ], ctrl_writeEnable);
	and we15(write_enable4 , decode_3[4 ], ctrl_writeEnable);
	and we16(write_enable5 , decode_3[5 ], ctrl_writeEnable);
	and we17(write_enable6 , decode_3[6 ], ctrl_writeEnable);
	and we18(write_enable7 , decode_3[7 ], ctrl_writeEnable);
	and we19(write_enable8 , decode_3[8 ], ctrl_writeEnable);
	and we20(write_enable9 , decode_3[9 ], ctrl_writeEnable);
	and we21(write_enable10, decode_3[10], ctrl_writeEnable);
	and we22(write_enable11, decode_3[11], ctrl_writeEnable);
	and we23(write_enable12, decode_3[12], ctrl_writeEnable);
	and we24(write_enable13, decode_3[13], ctrl_writeEnable);
	and we25(write_enable14, decode_3[14], ctrl_writeEnable);
	and we26(write_enable15, decode_3[15], ctrl_writeEnable);
	and we27(write_enable16, decode_3[16], ctrl_writeEnable);
	and we28(write_enable17, decode_3[17], ctrl_writeEnable);
	and we29(write_enable18, decode_3[18], ctrl_writeEnable);
	and we30(write_enable19, decode_3[19], ctrl_writeEnable);
	and we31(write_enable20, decode_3[20], ctrl_writeEnable);
	and we32(write_enable21, decode_3[21], ctrl_writeEnable);
	and we33(write_enable22, decode_3[22], ctrl_writeEnable);
	and we34(write_enable23, decode_3[23], ctrl_writeEnable);
	and we35(write_enable24, decode_3[24], ctrl_writeEnable);
	and we36(write_enable25, decode_3[25], ctrl_writeEnable);
	and we37(write_enable26, decode_3[26], ctrl_writeEnable);
	and we38(write_enable27, decode_3[27], ctrl_writeEnable);
	and we39(write_enable28, decode_3[28], ctrl_writeEnable);
	and we40(write_enable29, decode_3[29], ctrl_writeEnable);
	and we41(write_enable30, decode_3[30], ctrl_writeEnable);
	and we42(write_enable31, decode_3[31], ctrl_writeEnable);


	//////////////////////////////// Making 32 Registers ////////////////////////////////

	register reg11(clock, 1'b0 , ctrl_reset, data_writeReg, dataread0);
	register reg12(clock, write_enable1 , ctrl_reset, data_writeReg, dataread1);
	register reg13(clock, write_enable2 , ctrl_reset, data_writeReg, dataread2);
	register reg14(clock, write_enable3 , ctrl_reset, data_writeReg, dataread3);
	register reg15(clock, write_enable4 , ctrl_reset, data_writeReg, dataread4);
	register reg16(clock, write_enable5 , ctrl_reset, data_writeReg, dataread5);
	register reg17(clock, write_enable6 , ctrl_reset, data_writeReg, dataread6);
	register reg18(clock, write_enable7 , ctrl_reset, data_writeReg, dataread7);
	register reg19(clock, write_enable8 , ctrl_reset, data_writeReg, dataread8);
	register reg20(clock, write_enable9 , ctrl_reset, data_writeReg, dataread9);
	register reg21(clock, write_enable10, ctrl_reset, data_writeReg, dataread10);
	register reg22(clock, write_enable11, ctrl_reset, data_writeReg, dataread11);
	register reg23(clock, write_enable12, ctrl_reset, data_writeReg, dataread12);
	register reg24(clock, write_enable13, ctrl_reset, data_writeReg, dataread13);
	register reg25(clock, write_enable14, ctrl_reset, data_writeReg, dataread14);
	register reg26(clock, write_enable15, ctrl_reset, data_writeReg, dataread15);
	register reg27(clock, write_enable16, ctrl_reset, data_writeReg, dataread16);
	register reg28(clock, write_enable17, ctrl_reset, data_writeReg, dataread17);
	register reg29(clock, write_enable18, ctrl_reset, data_writeReg, dataread18);
	register reg30(clock, write_enable19, ctrl_reset, data_writeReg, dataread19);
	register reg31(clock, write_enable20, ctrl_reset, data_writeReg, dataread20);
	register reg32(clock, write_enable21, ctrl_reset, data_writeReg, dataread21);
	register reg33(clock, write_enable22, ctrl_reset, data_writeReg, dataread22);
	register reg34(clock, write_enable23, ctrl_reset, data_writeReg, dataread23);
	register reg35(clock, write_enable24, ctrl_reset, data_writeReg, dataread24);
	register reg36(clock, write_enable25, ctrl_reset, data_writeReg, dataread25);
	register reg37(clock, write_enable26, ctrl_reset, data_writeReg, dataread26);
	register reg38(clock, write_enable27, ctrl_reset, data_writeReg, dataread27);
	register reg39(clock, write_enable28, ctrl_reset, data_writeReg, dataread28);
	register reg40(clock, write_enable29, ctrl_reset, data_writeReg, dataread29);
	register reg41(clock, write_enable30, ctrl_reset, data_writeReg, dataread30);
	register reg42(clock, write_enable31, ctrl_reset, data_writeReg, dataread31);

	//////////////////////////////// Passing through 64 tri-state buffers ////////////////////////////////

	my_tri tri11(32'b0 , decode_1[0 ], data_readRegA);
	my_tri tri12(dataread1 , decode_1[1 ], data_readRegA);
	my_tri tri13(dataread2 , decode_1[2 ], data_readRegA);
	my_tri tri14(dataread3 , decode_1[3 ], data_readRegA);
	my_tri tri15(dataread4 , decode_1[4 ], data_readRegA);
	my_tri tri16(dataread5 , decode_1[5 ], data_readRegA);
	my_tri tri17(dataread6 , decode_1[6 ], data_readRegA);
	my_tri tri18(dataread7 , decode_1[7 ], data_readRegA);
	my_tri tri19(dataread8 , decode_1[8 ], data_readRegA);
	my_tri tri20(dataread9 , decode_1[9 ], data_readRegA);
	my_tri tri21(dataread10, decode_1[10], data_readRegA);
	my_tri tri22(dataread11, decode_1[11], data_readRegA);
	my_tri tri23(dataread12, decode_1[12], data_readRegA);
	my_tri tri24(dataread13, decode_1[13], data_readRegA);
	my_tri tri25(dataread14, decode_1[14], data_readRegA);
	my_tri tri26(dataread15, decode_1[15], data_readRegA);
	my_tri tri27(dataread16, decode_1[16], data_readRegA);
	my_tri tri28(dataread17, decode_1[17], data_readRegA);
	my_tri tri29(dataread18, decode_1[18], data_readRegA);
	my_tri tri30(dataread19, decode_1[19], data_readRegA);
	my_tri tri31(dataread20, decode_1[20], data_readRegA);
	my_tri tri32(dataread21, decode_1[21], data_readRegA);
	my_tri tri33(dataread22, decode_1[22], data_readRegA);
	my_tri tri34(dataread23, decode_1[23], data_readRegA);
	my_tri tri35(dataread24, decode_1[24], data_readRegA);
	my_tri tri36(dataread25, decode_1[25], data_readRegA);
	my_tri tri37(dataread26, decode_1[26], data_readRegA);
	my_tri tri38(dataread27, decode_1[27], data_readRegA);
	my_tri tri39(dataread28, decode_1[28], data_readRegA);
	my_tri tri40(dataread29, decode_1[29], data_readRegA);
	my_tri tri41(dataread30, decode_1[30], data_readRegA);
	my_tri tri42(dataread31, decode_1[31], data_readRegA);

	my_tri tri51(32'b0 , decode_2[0 ], data_readRegB);
	my_tri tri52(dataread1 , decode_2[1 ], data_readRegB);
	my_tri tri53(dataread2 , decode_2[2 ], data_readRegB);
	my_tri tri54(dataread3 , decode_2[3 ], data_readRegB);
	my_tri tri55(dataread4 , decode_2[4 ], data_readRegB);
	my_tri tri56(dataread5 , decode_2[5 ], data_readRegB);
	my_tri tri57(dataread6 , decode_2[6 ], data_readRegB);
	my_tri tri58(dataread7 , decode_2[7 ], data_readRegB);
	my_tri tri59(dataread8 , decode_2[8 ], data_readRegB);
	my_tri tri60(dataread9 , decode_2[9 ], data_readRegB);
	my_tri tri61(dataread10, decode_2[10], data_readRegB);
	my_tri tri62(dataread11, decode_2[11], data_readRegB);
	my_tri tri63(dataread12, decode_2[12], data_readRegB);
	my_tri tri64(dataread13, decode_2[13], data_readRegB);
	my_tri tri65(dataread14, decode_2[14], data_readRegB);
	my_tri tri66(dataread15, decode_2[15], data_readRegB);
	my_tri tri67(dataread16, decode_2[16], data_readRegB);
	my_tri tri68(dataread17, decode_2[17], data_readRegB);
	my_tri tri69(dataread18, decode_2[18], data_readRegB);
	my_tri tri70(dataread19, decode_2[19], data_readRegB);
	my_tri tri71(dataread20, decode_2[20], data_readRegB);
	my_tri tri72(dataread21, decode_2[21], data_readRegB);
	my_tri tri73(dataread22, decode_2[22], data_readRegB);
	my_tri tri74(dataread23, decode_2[23], data_readRegB);
	my_tri tri75(dataread24, decode_2[24], data_readRegB);
	my_tri tri76(dataread25, decode_2[25], data_readRegB);
	my_tri tri77(dataread26, decode_2[26], data_readRegB);
	my_tri tri78(dataread27, decode_2[27], data_readRegB);
	my_tri tri79(dataread28, decode_2[28], data_readRegB);
	my_tri tri80(dataread29, decode_2[29], data_readRegB);
	my_tri tri81(dataread30, decode_2[30], data_readRegB);
	my_tri tri82(dataread31, decode_2[31], data_readRegB);

endmodule
