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

assign push = ~key_prev & key_sync;

endmodule


//=============== LEDS ==================

module led2seq 
(
    input [7:0] num,
    output [7:0] seq
);

assign seq = num;

endmodule


// ================== 7SEGM ================
module num2seq 
(
    input [3:0] num,
    output [6:0] seq
);

assign seq =    num == 4'h0  ? 7'b1000000 :
                num == 4'h1  ? 7'b1111001 :
                num == 4'h2  ? 7'b0010010 :
                num == 4'h3  ? 7'b0110000 :
                num == 4'h4  ? 7'b0011001 :
                num == 4'h5  ? 7'b0010010 :
                num == 4'h6  ? 7'b0000010 :
                num == 4'h7  ? 7'b1111000 :
                num == 4'h8  ? 7'b0000000 :
                num == 4'h9  ? 7'b0010000 :
                num == 4'ha ? 7'b0001000 :
                num == 4'hb ? 7'b0000011 :
                num == 4'hc ? 7'b1000110 :
                num == 4'hd ? 7'b0100001 :
                num == 4'he ? 7'b0000110 : 7'b0001110;


endmodule



//============== BIT MOVIE ==================

module task4
(
    input  clk,
    input  key1, 
    input  key2, 
    input  key3,
    input  [7:0] switch,
    input  switch8,
    output [7:0] seq,
    output [7:0] seq_green,
	 output [6:0] seq71,
	 output [6:0] seq72
);

//=============== ADD LOGIC ================

//Key push logic
wire key_push1;
wire key_push2;
wire key_push3;

//tasknumber
reg [7:0] tasknumber;
reg [7:0] tasknumber_green;

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
led2seq led2seq_in1(
    .num(tasknumber),
    .seq(seq)
);

led2seq led2seq_in2(
    .num(tasknumber_green),
    .seq(seq_green)
);

//SWITCH
num2seq  num2seq_in1(
    .num(tasknumber[7:4]),
    .seq(seq71)
);

num2seq  num2seq_in2(
    .num(tasknumber[3:0]),
    .seq(seq72)
);


//============== MAIN TASK =================

always @(posedge clk)
begin

if (key_push1) begin

    tasknumber <= 0;
	 tasknumber_green <= 0;

end
else if (key_push2 ) begin 
    
    tasknumber <= switch;

end
else if (key_push3) begin 

    tasknumber_green <= {tasknumber[0], (tasknumber_green[7:1])};
    tasknumber <= {switch8, (tasknumber[7:1])};

end

end

endmodule 
