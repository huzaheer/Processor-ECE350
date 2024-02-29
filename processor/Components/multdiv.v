module multdiv(
	data_operandA, data_operandB, 
	ctrl_MULT, ctrl_DIV, 
	clock, 
	data_result, data_exception, data_resultRDY);

    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result;
    output data_exception, data_resultRDY;

    wire [31:0] data_result_mult, data_result_div;
    wire data_exception_mult, data_exception_div, data_resultRDY_mult, data_resultRDY_div, d, q, en, clr;

    assign en = ctrl_MULT ? 1'b1 : 1'b0;

    mult multipy_babe(data_operandA, data_operandB, ctrl_MULT, clock, data_result_mult, data_exception_mult, data_resultRDY_mult);
    div div_babe(data_operandA, data_operandB, ctrl_DIV, clock, data_result_div, data_exception_div, data_resultRDY_div);

    assign data_result = q ? data_result_mult : data_result_div;
    assign data_exception = q ? data_exception_mult : data_exception_div;
    assign data_resultRDY = q ? data_resultRDY_mult : data_resultRDY_div;

    // assign clr = data_resultRDY_mult ? 1'b1 : 1'b0;

    assign clr = ctrl_DIV ? 1'b1 : 1'b0;

    dffe_ref mul(q, ctrl_MULT, clock, en, clr);
endmodule