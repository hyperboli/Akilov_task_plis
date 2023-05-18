// ??????? 4 - ???????????? ????????
`timescale 1ns / 100ps

//=========== PRSH ===========
module prsh (
	input [7:0] num2,
	output [2:0] res
);

assign res = {
	num2[7] | num2[6] | num2[5] | num2[4],
	num2[7] | num2[6] | (~num2[5] & ~num2[4]) & (num2[3] | num2[2]),
	num2[7] | ~num2[6] & (num2[5] | ~num2[4] & (num2[3] | ~num2[2] & num2[1]))
};

// 1xxxxxxx - 7 111 - 
// 01xxxxxx - 6 110 - 
// 001xxxxx - 5 101 - 
// 0001xxxx - 4 100 - 
// 00001xxx - 3 011 - 
// 000001xx - 2 010 - 
// 0000001x - 1 001 - 
// 00000001 - 0 000 -

endmodule

//=============== TOP ===========
module top;

reg [7:0] data;
wire [2:0] answ;

prsh prsh_in(
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

	data = 8'b00111111;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00010001;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");


end

endmodule
