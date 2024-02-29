module full_adder(S, A, B, Cin);   
    input A, B, Cin;
    output S;

    xor Sum_mod(S, A, B, Cin);


    // and func_generate(w1, A, B);
    // or func_propogate(w2, A, B);
    // and func_prop_carry(w3, w2, Cin);
    // or Carry(Cout, w3, w1);

    // and A_and_B(w1, A, B);
    // and A_and_Cin(w2, A, Cin);
    // and B_and_Cin(w3, B, Cin);
    // or Carry(Cout, w1, w2, w3);
endmodule