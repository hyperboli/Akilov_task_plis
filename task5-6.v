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

module led2seq_simple
(
    input num,
    output seq
);

assign seq = num;

endmodule


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
                num == 4'h2  ? 7'b0100100 :
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

module task5
(
    input         CLK,
    input  [3:0]  KEY, 
    input  [17:0] SW,
    output [17:0] LEDR,
    output [8:0]  LEDG,
	output [6:0]  HEX0,
	output [6:0]  HEX1,
	output [6:0]  HEX5,
   output [6:0]  HEX4,
   output [6:0]  HEX3,
   output [6:0]  HEX2

);

//=============== ADD LOGIC ================

//Key push logic
wire key_push0;
wire key_push1;

//tasknumber
wire [41:0] HEXS;

reg [23:0] tasknumber;

assign {HEX5[6:0], HEX4[6:0], HEX3[6:0], HEX2[6:0], HEX1[6:0], HEX0[6:0]} = HEXS[41:0]; 

reg overflow;


//============ INCLUDE MODULES ================

//Buttons
push_key push_key_in0(
    .clk(CLK),
    .key(KEY[0]),
    .push(key_push0)
);

push_key push_key_in1(
    .clk(CLK),
    .key(KEY[1]),
    .push(key_push1)
);

//LEDs
led2seq led2seq_in0(
    .num(tasknumber[7:0]),
    .seq(LEDR[7:0])
);

led2seq led2seq_in1(
    .num(tasknumber[15:8]),
    .seq(LEDR[16:9])
);

led2seq led2seq_in2(
    .num(tasknumber[23:16]),
    .seq(LEDG[7:0])
);

led2seq_simple led2seq_simple_in(
    .num(overflow),
    .seq(LEDG[8])
);


//=========== num2sixseq ===============

genvar Gi;

generate for (Gi=0; Gi<6; Gi=Gi+1) 
begin: loop1

num2seq  num2seq_in(
	 .num( tasknumber[(Gi+1)*4-1 : Gi*4] ),
	 .seq( HEXS[(Gi+1)*7-1 : Gi*7] )
);
    	 
end
endgenerate




//============== MAIN TASK =================

always @(posedge CLK)
begin

tasknumber[7:0] <= SW[7:0];
tasknumber[15:8] <= SW[16:9];

if (key_push0) begin

    {overflow, tasknumber[23:16]} <= 9'b0;

end
else if (key_push1) begin 
    
    {overflow, tasknumber[23:16]} <= {1'b0, tasknumber[15:8]} + {1'b0, tasknumber[7:0]};

end

end

endmodule 
