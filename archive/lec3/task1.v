`timescale 1ns / 100ps

// ??????? 1 - ??????????? ??????? ?????

module task1 (
	input [31:0] num,
	output res
);

	assign res = ~(num[0]);

endmodule

//================= TOP ====================
module top;
	
reg [31:0] data;
wire result;

task1 task1_in(
	.num(data),
	.res(result)
);

initial begin
	data = 32'b00000000000000000000000000000000;
	#10
	$display("Number = %d", data);
	data = 32'b00000000000000000000000000000001;
	#10
	$display("Number = %d", data);
	data = 32'b00000000000000000000000000000010;
	#10
	$display("Number = %d", data);

	//$display("chet = %d", task1);
	//#10
	//data = data + 32'b0000000001;
	//$display("Number = %d", data);
	//$display("chet = %d", task1);
	//#10
	//data = data +  32'b0000000001;
	//$display("Number = %d", data);
	//$display("chet = %d", task1);
end
endmodule
