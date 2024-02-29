module eight_bit_adder(Cout, Cin, A, B, S);
    input [7:0] A, B;
    input Cin;
    output [7:0] S;
    output Cout;
    output [8:1] c;
    wire [35:0] w;
    wire [7:0] p;
    wire [7:0] g;

    // writing expressions for all generate functions
    and g_zero(g[0], A[0], B[0]);
    and g_one(g[1], A[1], B[1]);
    and g_two(g[2], A[2], B[2]);
    and g_three(g[3], A[3], B[3]);
    and g_four(g[4], A[4], B[4]);
    and g_five(g[5], A[5], B[5]);
    and g_six(g[6], A[6], B[6]);
    and g_seven(g[7], A[7], B[7]);

    // writing expressions for all propogate functions
    or p_zero(p[0], A[0], B[0]);
    or p_one(p[1], A[1], B[1]);
    or p_two(p[2], A[2], B[2]);
    or p_three(p[3], A[3], B[3]);
    or p_four(p[4], A[4], B[4]);
    or p_five(p[5], A[5], B[5]);
    or p_six(p[6], A[6], B[6]);
    or p_seven(p[7], A[7], B[7]);
    
    //c1
    and temp_1(w[0], p[0], Cin);
    or Carry_1(c[1], g[0], w[0]);

    //c2 
    and temp_2(w[1], p[1], p[0], Cin);
    and temp_3(w[2], p[1], g[0]);
    or Carry_2(c[2], g[1], w[1], w[2]);

    //c3
    and temp_4(w[3], p[2], p[1], p[0], Cin);
    and temp_5(w[4], p[2], p[1], g[0]);
    and temp_6(w[5], p[2], g[1]);
    or Carry_3(c[3], g[2], w[3], w[4], w[5]);

    //c4
    and temp_7(w[6], p[3], p[2], p[1], p[0], Cin);
    and temp_8(w[7], p[3], p[2], p[1], g[0]);
    and temp_9(w[8], p[3], p[2], g[1]);
    and temp_10(w[9], p[3], g[2]);
    or Carry_4(c[4], g[3], w[6], w[7], w[8], w[9]);

    //c5
    and temp_11(w[10], p[4], p[3], p[2], p[1], p[0], Cin);
    and temp_12(w[11], p[4], p[3], p[2], p[1], g[0]);
    and temp_13(w[12], p[4], p[3], p[2], g[1]);
    and temp_14(w[13], p[4], p[3], g[2]);
    and temp_15(w[14], p[4], g[3]);
    or Carry_5(c[5], g[4], w[10], w[11], w[12], w[13], w[14]);

    //c6
    and temp_16(w[15], p[5], p[4], p[3], p[2], p[1], p[0], Cin);
    and temp_17(w[16], p[5], p[4], p[3], p[2], p[1], g[0]);
    and temp_18(w[17], p[5], p[4], p[3], p[2], g[1]);
    and temp_19(w[18], p[5], p[4], p[3], g[2]);
    and temp_20(w[19], p[5], p[4], g[3]);
    and temp_21(w[20], p[5], g[4]);
    or Carry_6(c[6], g[5], w[15], w[16], w[17], w[18], w[19], w[20]);

    //c7
    and temp_22(w[21], p[6], p[5], p[4], p[3], p[2], p[1], p[0], Cin);
    and temp_23(w[22], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and temp_24(w[23], p[6], p[5], p[4], p[3], p[2], g[1]);
    and temp_25(w[24], p[6], p[5], p[4], p[3], g[2]);
    and temp_26(w[25], p[6], p[5], p[4], g[3]);
    and temp_27(w[26], p[6], p[5], g[4]);
    and temp_28(w[27], p[6], g[5]);
    or Carry_7(c[7], g[6], w[21], w[22], w[23], w[24], w[25], w[26], w[27]);

    //c8
    and temp_29(w[28], p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0], Cin);
    and temp_30(w[29], p[7], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and temp_31(w[30], p[7], p[6], p[5], p[4], p[3], p[2], g[1]);
    and temp_32(w[31], p[7], p[6], p[5], p[4], p[3], g[2]);
    and temp_33(w[32], p[7], p[6], p[5], p[4], g[3]);
    and temp_34(w[33], p[7], p[6], p[5], g[4]);
    and temp_35(w[34], p[7], p[6], g[5]);
    and temp_36(w[35], p[7], g[6]);
    or Carry_8(Cout, g[7], w[28], w[29], w[30], w[31], w[32], w[33], w[34], w[35]);



    full_adder  first(S[0], A[0], B[0], Cin);
    full_adder second(S[1], A[1], B[1], c[1]);
    full_adder third(S[2], A[2], B[2], c[2]);
    full_adder fourth(S[3], A[3], B[3], c[3]);
    full_adder fifth(S[4], A[4], B[4], c[4]);
    full_adder sixth(S[5], A[5], B[5], c[5]);
    full_adder seventh(S[6], A[6], B[6], c[6]);
    full_adder eight(S[7], A[7], B[7], c[7]);
endmodule
