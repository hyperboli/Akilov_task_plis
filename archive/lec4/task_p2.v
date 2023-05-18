//Lect 4 Task 1
module clk_div_f
(

    input wire clk,
    input wire reset,
    output reg [2:0] clk_div, //counter
    output reg clk_div6, //div 6
    output reg clk_div12 //div 12

);

always @(posedge clk)

if (reset)
    {clk_div[0], clk_div[1], clk_div[2], clk_div6} <= 4'h0;

else begin

    //break counter if counter = 101
    if ( clk_div[0] & ~clk_div[1] & clk_div[2] ) begin
        {clk_div[0], clk_div[1], clk_div[2]} <= 3'b000;
        clk_div6 <= ~clk_div6;
    end 
    else begin
        //counter
        clk_div[0] <= ~clk_div[0];
        clk_div[1] <= clk_div[0] ? (~clk_div[1]) : clk_div[1];
        clk_div[2] <= (clk_div[0]&clk_div[1]) ? ~clk_div[2] : clk_div[2];
    end

end
endmodule

//========================== TOP =========================
module top;

reg clk = 0;
always #1 clk=~clk;
reg reset = 0;
wire [2:0] clk_div_main; //counter
wire clk_div6; //div 6
wire clk_div12; //div 12

clk_div_f clk_div_f_in(
	.clk(clk),
	.reset(reset),
    .clk_div(clk_div_main),
    .clk_div6(clk_div6),
    .clk_div12(clk_div12)
);

initial begin
	@(posedge clk)
	reset <= 1;
	repeat(3)@(negedge clk);
	reset <= 0;
end

endmodule