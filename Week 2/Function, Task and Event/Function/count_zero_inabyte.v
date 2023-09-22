`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 16:20:50
// Design Name: 
// Module Name: count_zero_inabyte
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module count_zero_inabyte(
    input [7:0] din,
    output reg [3:0] count
    );
    
    always @(din) begin
        count = count_zero_1byte(din);
    end
    
    function [3:0] count_zero_1byte (input [7:0] in);
        reg [3:0] counter;
        integer i;
        begin 
            counter = 0;          
            for (i = 0; i < 8; i = i + 1) begin
                if (in[i] == 0) begin
                   counter = counter + 1;
                end
            end
            count_zero_1byte = counter;
        end     
    endfunction
    
endmodule

