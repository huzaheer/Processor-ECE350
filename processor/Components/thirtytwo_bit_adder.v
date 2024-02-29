module thirtytwo_bit_adder(Cout, Cin, A, b, S, ovf);
    input [31:0] A, B, b;
    input Cin;
    output [31:0] S;
    output Cout, ovf;
    output [32:1] c;
    wire [50:0] w;
    wire [31:0] p, g;
    wire [10:0] s;
    input [3:0] Big_P, Big_G;
    wire [3:0] dummy;

    // Checking if we want to add instead of subtract

    xor x_0 (B[0], Cin, b[0]);
    xor x_1 (B[1], Cin, b[1]);
    xor x_2 (B[2], Cin, b[2]);
    xor x_3 (B[3], Cin, b[3]);
    xor x_4 (B[4], Cin, b[4]);
    xor x_5 (B[5], Cin, b[5]);
    xor x_6 (B[6], Cin, b[6]);
    xor x_7 (B[7], Cin, b[7]);
    xor x_8 (B[8], Cin, b[8]);
    xor x_9 (B[9], Cin, b[9]);
    xor x_10(B[10], Cin, b[10]);
    xor x_11(B[11], Cin, b[11]);
    xor x_12(B[12], Cin, b[12]);
    xor x_13(B[13], Cin, b[13]);
    xor x_14(B[14], Cin, b[14]);
    xor x_15(B[15], Cin, b[15]);
    xor x_16(B[16], Cin, b[16]);
    xor x_17(B[17], Cin, b[17]);
    xor x_18(B[18], Cin, b[18]);
    xor x_19(B[19], Cin, b[19]);
    xor x_20(B[20], Cin, b[20]);
    xor x_21(B[21], Cin, b[21]);
    xor x_22(B[22], Cin, b[22]);
    xor x_23(B[23], Cin, b[23]);
    xor x_24(B[24], Cin, b[24]);
    xor x_25(B[25], Cin, b[25]);
    xor x_26(B[26], Cin, b[26]);
    xor x_27(B[27], Cin, b[27]);
    xor x_28(B[28], Cin, b[28]);
    xor x_29(B[29], Cin, b[29]);
    xor x_30(B[30], Cin, b[30]);
    xor x_31(B[31], Cin, b[31]);

    // writing expressions for all generate functions
    and g_0(g[0], A[0], B[0]);
    and g_1(g[1], A[1], B[1]);
    and g_2(g[2], A[2], B[2]);
    and g_3(g[3], A[3], B[3]);
    and g_4(g[4], A[4], B[4]);
    and g_5(g[5], A[5], B[5]);
    and g_6(g[6], A[6], B[6]);
    and g_7(g[7], A[7], B[7]);
    and g_8(g[8], A[8], B[8]);
    and g_9(g[9], A[9], B[9]);
    and g_10(g[10], A[10], B[10]);
    and g_11(g[11], A[11], B[11]);
    and g_12(g[12], A[12], B[12]);
    and g_13(g[13], A[13], B[13]);
    and g_14(g[14], A[14], B[14]);
    and g_15(g[15], A[15], B[15]);
    and g_16(g[16], A[16], B[16]);
    and g_17(g[17], A[17], B[17]);
    and g_18(g[18], A[18], B[18]);
    and g_19(g[19], A[19], B[19]);
    and g_20(g[20], A[20], B[20]);
    and g_21(g[21], A[21], B[21]);
    and g_22(g[22], A[22], B[22]);
    and g_23(g[23], A[23], B[23]);
    and g_24(g[24], A[24], B[24]);
    and g_25(g[25], A[25], B[25]);
    and g_26(g[26], A[26], B[26]);
    and g_27(g[27], A[27], B[27]);
    and g_28(g[28], A[28], B[28]);
    and g_29(g[29], A[29], B[29]);
    and g_30(g[30], A[30], B[30]);
    and g_31(g[31], A[31], B[31]);


    // writing expressions for all propogate functions
    or p_0(p[0], A[0], B[0]);
    or p_1(p[1], A[1], B[1]);
    or p_2(p[2], A[2], B[2]);
    or p_3(p[3], A[3], B[3]);
    or p_4(p[4], A[4], B[4]);
    or p_5(p[5], A[5], B[5]);
    or p_6(p[6], A[6], B[6]);
    or p_7(p[7], A[7], B[7]);
    or p_8(p[8], A[8], B[8]);
    or p_9(p[9], A[9], B[9]);
    or p_10(p[10], A[10], B[10]);
    or p_11(p[11], A[11], B[11]);
    or p_12(p[12], A[12], B[12]);
    or p_13(p[13], A[13], B[13]);
    or p_14(p[14], A[14], B[14]);
    or p_15(p[15], A[15], B[15]);
    or p_16(p[16], A[16], B[16]);
    or p_17(p[17], A[17], B[17]);
    or p_18(p[18], A[18], B[18]);
    or p_19(p[19], A[19], B[19]);
    or p_20(p[20], A[20], B[20]);
    or p_21(p[21], A[21], B[21]);
    or p_22(p[22], A[22], B[22]);
    or p_23(p[23], A[23], B[23]);
    or p_24(p[24], A[24], B[24]);
    or p_25(p[25], A[25], B[25]);
    or p_26(p[26], A[26], B[26]);
    or p_27(p[27], A[27], B[27]);
    or p_28(p[28], A[28], B[28]);
    or p_29(p[29], A[29], B[29]);
    or p_30(p[30], A[30], B[30]);
    or p_31(p[31], A[31], B[31]);

    //Writing expressions for big P
    and pbig_1(Big_P[0], p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0]);
    and pbig_2(Big_P[1], p[15], p[14], p[13], p[12], p[11], p[10], p[9], p[8]);
    and pbig_3(Big_P[2], p[23], p[22], p[21], p[20], p[19], p[18], p[17], p[16]);
    and pbig_4(Big_P[3], p[31], p[30], p[29], p[28], p[27], p[26], p[25], p[24]);

    //Writing expressions for big G

    //G0
    and temp_30(w[1], p[7], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
    and temp_31(w[2], p[7], p[6], p[5], p[4], p[3], p[2], g[1]);
    and temp_32(w[3], p[7], p[6], p[5], p[4], p[3], g[2]);
    and temp_33(w[4], p[7], p[6], p[5], p[4], g[3]);
    and temp_34(w[5], p[7], p[6], p[5], g[4]);
    and temp_35(w[6], p[7], p[6], g[5]);
    and temp_36(w[7], p[7], g[6]);
    or gbig_1(Big_G[0], g[7], w[1], w[2], w[3], w[4], w[5], w[6], w[7]);

    //G1
    and temp_40(w[8], p[15], p[14], p[13], p[12], p[11], p[10], p[9], g[8]);
    and temp_41(w[9], p[15], p[14], p[13], p[12], p[11], p[10], g[9]);
    and temp_42(w[10], p[15], p[14], p[13], p[12], p[11], g[10]);
    and temp_43(w[11], p[15], p[14], p[13], p[12], g[11]);
    and temp_44(w[12], p[15], p[14], p[13], g[12]);
    and temp_45(w[13], p[15], p[14], g[13]);
    and temp_46(w[14], p[15], g[14]);
    or gbig_2(Big_G[1], g[15], w[8], w[9], w[10], w[11], w[12], w[13], w[14]);

    //G2
    and temp_50(w[15] , p[23], p[22], p[21], p[20], p[19], p[18], p[17], g[16]);
    and temp_51(w[16] , p[23], p[22], p[21], p[20], p[19], p[18], g[17]);
    and temp_52(w[17], p[23], p[22], p[21], p[20], p[19], g[18]);
    and temp_53(w[18], p[23], p[22], p[21], p[20], g[19]);
    and temp_54(w[19], p[23], p[22], p[21], g[20]);
    and temp_55(w[20], p[23], p[22], g[21]);
    and temp_56(w[21], p[23], g[22]);
    or gbig_3(Big_G[2], g[23], w[15], w[16], w[17], w[18], w[19], w[20], w[21]);

    //G2
    and temp_60(w[22] , p[31], p[30], p[29], p[28], p[27], p[26], p[25], g[24]);
    and temp_61(w[23] , p[31], p[30], p[29], p[28], p[27], p[26], g[25]);
    and temp_62(w[24], p[31], p[30], p[29], p[28], p[27], g[26]);
    and temp_63(w[25], p[31], p[30], p[29], p[28], g[27]);
    and temp_64(w[26], p[31], p[30], p[29], g[28]);
    and temp_65(w[27], p[31], p[30], g[29]);
    and temp_66(w[28], p[31], g[30]);
    or gbig_4(Big_G[3], g[31], w[22], w[23], w[24], w[25], w[26], w[27], w[28]);


    ///////////////////////         Calculating the carries         ////////////////////
    
    //c8
    and conjunct_one(s[0], Big_P[0], Cin);
    or answer_one(c[8], Big_G[0], s[0]);

    //c16
    and conjunct_two(s[1], Big_P[1], Big_P[0], Cin);
    and conjunct_three(s[2], Big_P[1], Big_G[0]);
    or answer_two(c[16], Big_G[1], s[1], s[2]);

    //c24
    and conjunct_four(s[3], Big_P[2], Big_P[1], Big_P[0], Cin);
    and conjunct_fix(s[4], Big_P[2], Big_P[1], Big_G[0]);
    and conjunct_six(s[5], Big_P[2], Big_G[1]);
    or answer_three(c[24], Big_G[2], s[3], s[4], s[5]);
    
    //c32
    and conjunct_7(s[6], Big_P[3], Big_P[2], Big_P[1], Big_P[0], Cin);
    and conjunct_8(s[7], Big_P[3], Big_P[2], Big_P[1], Big_G[0]);
    and conjunct_9(s[8], Big_P[3], Big_P[2], Big_G[1]);
    and conjunct_10(s[9], Big_P[3], Big_G[2]);
    or answer_four(c[32], Big_G[3], s[6], s[7], s[8], s[9]);

    ///////////////////////         Finding the Sum         ////////////////////


    eight_bit_adder  first(dummy[0], Cin, A[7:0], B[7:0], S[7:0]);
    eight_bit_adder  second(dummy[1], c[8], A[15:8], B[15:8], S[15:8]);
    eight_bit_adder  third(dummy[2], c[16], A[23:16], B[23:16], S[23:16]);
    eight_bit_adder  fourth(dummy[3], c[24], A[31:24], B[31:24], S[31:24]);

    assign Cout = c[32];
    // assign help = c[31];

    ///////////////////////         Finding c[31] for ovf       ////////////////////

    and yellow_22(w[41], p[30], p[29], p[28], p[27], p[26], p[25], p[24], c[24]);
    and yellow_23(w[42], p[30], p[29], p[28], p[27], p[26], p[25], g[24]);
    and yellow_24(w[43], p[30], p[29], p[28], p[27], p[26], g[25]);
    and yellow_25(w[44], p[30], p[29], p[28], p[27], g[26]);
    and yellow_26(w[45], p[30], p[29], p[28], g[27]);
    and yellow_27(w[46], p[30], p[29], g[28]);
    and yellow_28(w[47], p[30], g[29]);
    or Carry_7(c[31], g[30], w[41], w[42], w[43], w[44], w[45], w[46], w[47]);

    xor overflow(ovf, c[32], c[31]);
endmodule
