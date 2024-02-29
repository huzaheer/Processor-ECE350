module tffe(q, T, clk, reset);
input T, clk, reset;
output q;
wire not_T;
wire w1, w2, w3, in_Q, not_Q;

assign not_Q = !(in_Q);
assign not_T = !(T);

and and1(w1, in_Q, not_T);
and and2(w2, not_Q, T);
or (w3, w1, w2);

dffe_ref hi(q, w3, clk, 1'b1, reset);

assign in_Q = q;
endmodule