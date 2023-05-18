// ??????? 3 - ????????
`timescale 1ns / 100ps

//=========== LOG2 ===========
module log2 (
	input [7:0] num2,
	output [2:0] res
);

assign res = {
	1'b0,
	1'b0,
	1'b0
};

assign res = num2[0]*3'b000 +
 num2[1]*3'b001 +
 num2[2]*3'b010 +
 num2[3]*3'b011 +
 num2[4]*3'b100 +
 num2[5]*3'b101 +
 num2[6]*3'b110 +
 num2[7]*3'b111;

//while ( ~num2[0] ) begin
//	num2 = num2 >> 1;
//	res = res + 3'b001;
//end

endmodule

//=============== TOP ===========
module top;

reg [7:0] data;
wire [2:0] answ;

log2 log2_in(
	.num2(data),
	.res(answ)
);

initial begin
	data = 8'b00000001;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00000010;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00000100;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00001000;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00010000;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00100000;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");


end

endmodule
 