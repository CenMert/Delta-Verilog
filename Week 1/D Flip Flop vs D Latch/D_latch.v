`timescale 1ns / 1ps

module D_latch #(parameter N = 4) (
    input enable,
    input [N-1:0] d, 
    output [N-1:0] q
    );

    reg [N-1:0] reg_out;

    always @* begin
        if (enable) begin
            reg_out <= d;
        end
    end

    assign q = reg_out;

endmodule
