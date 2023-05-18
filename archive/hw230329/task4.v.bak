`timescale 1ns/100ps

module task4;

	reg	clk, rst;	
	reg [7: 0] a, b, c;

initial begin

	clk = 1'b0;
	rst = 1'b1;
	#0.5
	@(posedge clk)
	#3;
	rst = 1'b0;
end

always
	#1 clk = ~clk;

always @( posedge clk )
begin
	
	a = b+c+1;
	b <= rst ? 8'd3 : a+c-8;
	c <= rst ? 8'd4 : a - b;
	

end

endmodule
