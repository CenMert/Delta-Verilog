`timescale 1ns / 1ps


module johnson_counter #(parameter N = 4)(
    input clk,
    output reg [N-1:0] ring_out
    );

    reg [N-1:0] reg_ring;

    initial begin //bailangıç değeri
        reg_ring = 1;
    end

    always @(posedge clk) begin //işlemler ve clk senkronizasyonu
        // kaydırma işlemi
        reg_ring = {reg_ring[0], reg_ring[N-1:1]};
        ring_out = reg_ring;
    end 
    
endmodule
