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


//============== DECIMAL ====================

module dec2hex1
(
    input [7:0] num,
    input clk,
	input res,
    output reg [11: 0] seq
);

reg [7:0] counter = 0;
reg [11:0] pseq = 0;

always @(posedge clk)
begin
	 
	 if(res && counter!=0) begin
		counter <= 0;
		pseq <= 0;
		seq <= 0;
	 end

    if(counter >= num)begin
		seq <= pseq;
    end
    else begin

        if(pseq[3:0] >= 9) begin
            
            if(pseq[7:4] >= 9) begin
                pseq[3:0] <= 0;
                pseq[7:4] <= 0;
                pseq[11:8] = pseq[11:8] + 1;
            end
            else begin
                pseq[3:0] <= 0;
                pseq[7:4] <= pseq[7:4] + 1;
            end
        end
        else begin
            pseq[3:0] <= pseq[3:0]+1;
        end

        counter <= counter + 1;
    end

end

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

module task7
(
    input         CLOCK_50,
    input  [3:0]  KEY, 
    input  [17:0] SW,
    output [17:0] LEDR,
	output [6:0]  HEX1,
	output [6:0]  HEX0,
    output [6:0]  HEX4,
    output [6:0]  HEX3,
    output [6:0]  HEX2
);

//=============== ADD LOGIC ================

//Key push logic
wire key_push1;
wire key_push0;

//tasknumber
reg [7:0] tasknumber;
wire [11:0] tasknumber10;

//сброс данных 10-чного представления
wire break_fl = key_push1 | key_push0;

//============ INCLUDE MODULES ================

//Buttons
push_key push_key_in0(
    .clk(CLOCK_50),
    .key(KEY[0]),
    .push(key_push0)
);

push_key push_key_in1(
    .clk(CLOCK_50),
    .key(KEY[1]),
    .push(key_push1)
);

//LEDs
led2seq led2seq_in0(
    .num(tasknumber),
    .seq(LEDR[7:0])
);

//7sg
num2seq  num2seq_in1(
    .num(tasknumber[7:4]),
    .seq(HEX1)
);

num2seq  num2seq_in0(
    .num(tasknumber[3:0]),
    .seq(HEX0)
);

num2seq  num2seq_in4(
    .num(tasknumber10[11:8]),
    .seq(HEX4)
);

num2seq  num2seq_in3(
    .num(tasknumber10[7:4]),
    .seq(HEX3)
);

num2seq  num2seq_in2(
    .num(tasknumber10[3:0]),
    .seq(HEX2)
);

//dec to hex 
dec2hex1 dec2hex1_in(
    .num(tasknumber),
    .clk(CLOCK_50),
	.res(break_fl),
    .seq(tasknumber10)
);

//============== MAIN TASK =================

always @(posedge CLOCK_50)
begin

if (key_push0) begin

    tasknumber <= 0;

end
else if (key_push1 ) begin 
    
    tasknumber <= SW[7:0];

end

end

endmodule 
