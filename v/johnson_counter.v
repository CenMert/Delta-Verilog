`timescale 1ns / 1ps

module johnson_counter#(parameter N = 4)(
    input clk,
    output reg [N-1:0] j_out
    );
    reg [N-1:0] reg_j;

    initial begin //kendi değerini verme
        reg_j = 0;
    end

    always @(posedge clk) begin //clk ile paralel çalışmasını sağlama
        
        reg_j = {~reg_j[0], reg_j[N-1:1]};
        j_out = reg_j; 
    end


endmodule
