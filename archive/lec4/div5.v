`timescale 1ns / 100ps

module top;

reg    clk, reset;

initial 
    clk = 0;

initial begin

    reset = 0;
    #5;
    reset = 1;
    #25 reset = 0;

end

// ========= ALWAYS ==========

always #5 clk = ~clk;

initial begin

    #1000;
    $display("clk=%b", clk);
    $display("reset=%b", reset);
    $stop;

end
endmodule

module div5
(

    input clk,
    input reset,
    output imp

);

reg [2:0] counter;

always @(posedge clk)
begin

    if(reset)
        counter <= 3'h0;
    else
        counter <= (counter == 3'h4) ? 3'h0 : counter + 1'b1;

end
endmodule