module counter(T, clk, out, reset);
input T, clk, reset;
output [3:0] out;
wire w1, w2;

tffe temp1(out[0], T, clk, reset);
tffe temp2(out[1], out[0], clk, reset);

and temp3(w1, out[0], out[1]);
tffe temp4(out[2], w1, clk, reset);

and temp5(w2, w1, out[2]);
tffe temp6(out[3], w2, clk, reset);
endmodule