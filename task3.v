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
    input [7:0] num,
    output [7:0] seq
);

assign seq = {num[0], num[1], num[2], num[3], num[4], num[5], num[6], num[7]};   //num == 4'h0  ? 8'b0000000 :
                //num == 4'h1  ? 8'b1000000 :
                //num == 4'h2  ? 8'b1100000 :
                //num == 4'h3  ? 8'b1110000 :
                //num == 4'h4  ? 8'b1111000 :
                //num == 4'h5  ? 8'b1111100 :
                //num == 4'h6  ? 8'b1111110 : 8'b1111111;


endmodule


//============== BIT MOVIE ==================

module task3
(
    input  clk,
    input  key1, 
    input  key2, 
    input  key3,
    input  switch0,
    input  switch1,
    output [7:0] seq
);

//=============== ADD LOGIC ================

//Key push logic
wire key_push1;
wire key_push2;
wire key_push3;

//tasknumber
reg [7:0] tasknumber = 8'h0;

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
    .num(tasknumber),
    .seq(seq)
);

//noji

//============== MAIN TASK =================

always @(posedge clk)
begin

if (key_push1) tasknumber <= 8'b00000000;
else if (key_push2 & key1) begin 
    tasknumber <= { (tasknumber[6:0] ), switch0 };
end
else if (key_push3 & key1) begin 
    tasknumber <= {switch1, (tasknumber[7:1])};
end

end

endmodule 
