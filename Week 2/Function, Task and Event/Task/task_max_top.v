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


module task_max_top(
    input [7:0] number1, number2,
    output [7:0] result
    );
    
    wire [7:0] result_out;
    task_max tm(
        .first(number1),
        .second(number2),
        .greater(result_out)
    );
    assign result = result_out;
endmodule