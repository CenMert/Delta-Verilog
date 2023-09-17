`timescale 1ns / 1ps

module mux #(parameter N = 16) (
    input clk,
    input [N-1:0] fir,
    input [N-1:0] sec,
    input sel,
    output reg [N-1:0] out
    );
    
    always @(*) begin
    
    case (sel)

        1'b0: begin
            out <= fir;
        end
        1'b1: begin
            out <= sec;
        end
        
    endcase
    
    end
    
endmodule
