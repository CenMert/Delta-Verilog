`timescale 1ns / 1ps

module reverse_100bit_input(
    input [99:0] in,
    output reg [99:0] o
    );
    integer i = 0;
    always @* begin
    
        for (i = 0; i < 100; i = i + 1)begin
            o [99 - i] <= in [i];
            
        end
    
    end
    
endmodule
