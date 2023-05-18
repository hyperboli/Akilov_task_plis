`timescale 1ns/1ps

module encoder
#(
    parameter VECT_W = 8,
    parameter BIN_W  = 3
)
(
    input  wire [VECT_W-1:0] vcr,
    output wire [BIN_W-1:0]  ans
);

wire [BIN_W-1:0] binlist [VECT_W-1:0];

genvar Gi;
generate for (Gi=0; Gi<VECT_W; Gi=Gi+1)
begin: loop

    if(Gi==0)
        assign binlist[Gi] = { BIN_W{1'h0} };
    else
        assign binlist[Gi] = binlist[Gi-1] | {BIN_W{ vcr[Gi]} } & Gi;

end
endgenerate

assign ans = binlist[VECT_W-1];

endmodule

//=============== TOP ===========
module top;

reg [7:0] data;
wire [2:0] answ;

encoder encoder_in(
	.vcr(data),
	.ans(answ)
);

initial begin
	data = 8'b00000001;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00000010;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00000100;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00001000;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00010000;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b00100000;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b01000000;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");

	data = 8'b10000000;
	#10
	$display("data = %b", data);
	$display("data[int] = %d", data);
	$display("answ = %b", answ);
	$display("---------------");


end

endmodule
