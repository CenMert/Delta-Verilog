`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 19:00:15
// Design Name: 
// Module Name: task_max
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


module task_max(
    input [7:0] first, second,
    output [7:0] greater
    );
    
    reg [7:0] greater_out;
    
    always @(first, second) begin
        Greater(first, second, greater_out);
    end

    task Greater (
        input [7:0] first, 
        input [7:0] second,
        output [7:0] greater_out
        );
        begin
            if (first >= second) greater_out = first;
            else greater_out = second;
        end
    endtask
    
    assign greater = greater_out;
endmodule
