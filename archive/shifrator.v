`timescale 1ns/100ps

module binary2hotone;
#(
    parametr BIN_SIZE = 3,
    parametr OUT_SIZE = 1<<BIN_SIZE
)
(
    input[BIN_SIZE-1:0] binary,
    output[OUT_SIZE-1:0] hotone
);
genvar Gi;
generate for (Gi=0; Gi<OUT_SIZE; Gi=Gi+1) begin: loop1
    assign hotone[Gi] = (binary == Gi);
end
endgenerate

endmodule