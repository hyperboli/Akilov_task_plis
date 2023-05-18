`timescale 1ns / 1ps

//============= PUSH KEY ===================

module push_key
(
    input clk,
    input key,
    output push
);

reg key_sync, key_prev;

always @(posedge clk)
begin
    key_sync <= key;
    key_prev <= key_sync;
end

assign push = key_prev & ~key_sync;

endmodule


//=============== LEDS ==================

module led2seq 
(
    input [2:0] num,
    output [7:0] seq
);

assign seq =    num == 3'h0  ? 8'b00000000 :
                num == 3'h1  ? 8'b10000000 :
                num == 3'h2  ? 8'b11000000 :
                num == 3'h3  ? 8'b11100000 :
                num == 3'h4  ? 8'b11110000 :
                num == 3'h5  ? 8'b11111000 :
					 num == 3'h6  ? 8'b11111100 : 8'b11111110;

endmodule


//============== COUNTER ==================

module task2
(
    input  clk,
    input  key1, 
    input  key2, 
    input  key3,
    output [7:0] seq
);

//=============== ADD LOGIC ================

//Key push logic
wire key_push1;
wire key_push2;
wire key_push3;

//Counter
reg [2:0] counterm;

//============ INCLUDE MODULES ================

//Buttons
push_key push_key_in1(
    .clk(clk),
    .key(key1),
    .push(key_push1)
);

push_key push_key_in2(
    .clk(clk),
    .key(key2),
    .push(key_push2)
);

push_key push_key_in3(
    .clk(clk),
    .key(key3),
    .push(key_push3)
);

//LEDs
led2seq led2seq_in(
    .num(counterm),
    .seq(seq)
);

//============== MAIN TASK =================

always @(posedge clk)
begin

if (key_push1) counterm <= 3'h0;
else if (key_push2 & key1) counterm <= counterm + 3'h2;
else if (key_push3 & key1) counterm <= counterm - 3'h2;

end

endmodule 
