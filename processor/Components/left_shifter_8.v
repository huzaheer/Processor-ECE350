module left_shift_8(out, select, in1);
    input select;
    input [31:0] in1;
    output [31:0] out;
    assign out[31] = select ? in1[23]: in1[31];
    assign out[30] = select ? in1[22]: in1[30];
    assign out[29] = select ? in1[21]: in1[29];
    assign out[28] = select ? in1[20]: in1[28];
    assign out[27] = select ? in1[19]: in1[27];
    assign out[26] = select ? in1[18]: in1[26];
    assign out[25] = select ? in1[17]: in1[25];
    assign out[24] = select ? in1[16]: in1[24];
    assign out[23] = select ? in1[15]: in1[23];
    assign out[22] = select ? in1[14]: in1[22];
    assign out[21] = select ? in1[13]: in1[21];
    assign out[20] = select ? in1[12]: in1[20];
    assign out[19] = select ? in1[11]: in1[19];
    assign out[18] = select ? in1[10]: in1[18];
    assign out[17] = select ? in1[9 ]: in1[17];
    assign out[16] = select ? in1[8 ]: in1[16];
    assign out[15] = select ? in1[7]: in1[15];
    assign out[14] = select ? in1[6]: in1[14];
    assign out[13] = select ? in1[5]: in1[13];
    assign out[12] = select ? in1[4]: in1[12];
    assign out[11] = select ? in1[3]: in1[11];
    assign out[10] = select ? in1[2]: in1[10];
    assign out[9] = select ?  in1[1]: in1[9 ];
    assign out[8] = select ?  in1[0]: in1[8 ];
    assign out[7] = select ?  1'b0: in1[7 ];
    assign out[6] = select ?  1'b0: in1[6 ];
    assign out[5] = select ?  1'b0: in1[5 ];
    assign out[4] = select ?  1'b0: in1[4 ];
    assign out[3] = select ?  1'b0: in1[3 ];
    assign out[2] = select ?  1'b0: in1[2 ];
    assign out[1] = select ?  1'b0: in1[1 ];
    assign out[0] = select ?  1'b0: in1[0 ];
endmodule