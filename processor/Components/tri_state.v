module my_tri(in, eo, out);
    input [31:0] in;
    input eo;
    output [31:0] out;

    assign out = eo ? in : 32'bz;
endmodule