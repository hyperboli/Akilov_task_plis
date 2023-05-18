//???????? ????????? ???????
module clk_div
(
input wire clk,
input wire reset,
output reg clk_div2,
output reg clk_div4,
output reg clk_div8
);
always @(posedge clk)
if (reset)
{clk_div2, clk_div4, clk_div8} <= 3'h0;
else begin
clk_div2 <= ~clk_div2;
clk_div4 <= clk_div2 ? (~clk_div4) : clk_div4;
clk_div8 <= (clk_div2&clk_div4) ? ~clk_div8 : clk_div8;
end
endmodule

//=============== TOP ===========
module top;

reg clk = 0;
always #1 clk=~clk;
reg reset = 0;
wire [2:0] clk_div_main;

clk_div clk_div(
	.clk(clk),
	.reset(reset),
	.clk_div2(clk_div_main[0]),
	.clk_div4(clk_div_main[1]),
	.clk_div8(clk_div_main[2])

);

initial begin
	@(posedge clk)
	reset <= 1;
	repeat(3)@(negedge clk);
	reset <= 0;
end

endmodule

//контрольная 1 - ое задание написать простенький модуль
// 2 - ое задание нарисовать времянку по коду

//приоритетный шифратор, параллельный шифратор
//мультиплексер