`timescale 1ns / 1ps

module flip_flop #(parameter N = 16)(
    input [N-1:0] d,     // Veri girişi
    input clk,   // Saat sinyali
    output reg [N-1:0] q     // çıkış
);

    always @(posedge clk) begin
        q <= d; // Saat yükselen kenarında girişi çıkışa aktar
    end

endmodule

