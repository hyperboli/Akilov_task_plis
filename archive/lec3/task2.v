// ??????? 2 
`timescale 1ns / 100ps

//============ nbit =============
module nbit (
	input [2:0] num,
	output [7:0] res	
);

//???????? ? ?????? ?????
assign res = 1 << num;

endmodule

//============ TOP ============
module top;

reg [2:0] data;
wire [7:0] answ;

nbit nbit_in(
	.num(data),
	.res(answ)
);

initial begin
	data = 3'b000;
	#10
	$display("data = %b", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 3'b001;
	#10
	$display("data = %b", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 3'b010;
	#10
	$display("data = %b", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 3'b011;
	#10
	$display("data = %b", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 3'b100;
	#10
	$display("data = %b", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 3'b111;
	#10
	$display("data = %b", data);
	$display("answ = %b", answ);
	$display("---------------");


end

endmodule