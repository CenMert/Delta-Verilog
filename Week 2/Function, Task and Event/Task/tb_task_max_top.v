`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 19:13:20
// Design Name: 
// Module Name: tb_task_max_top
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


module tb_task_max_top();
    reg [7:0] number1; 
    reg [7:0] number2;
    wire [7:0] result;
    
    task_max_top uut(
        .number1(number1),
        .number2(number2),
        .result(result)
    );
    
    initial begin
        number1 = 10;
        number2 = 20;
        #10;
        
        number1 = 20;
        number2 = 20;
        #10;
        
        number1 = 30;
        number2 = 20;
        #10; 
    end
    
endmodule
