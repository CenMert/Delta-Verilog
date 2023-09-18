`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 16:00:31
// Design Name: 
// Module Name: sequence_generator
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


module sequence_generator(
    input reset, clk,
    output [15:0] seq_o // sequence output on every cycle
    );

    reg [15:0] seq_output; // for assignment statement
    reg [15:0] num1, num2, num3;

    initial begin
        seq_output <= 16'b0;
        num1 <= 16'b0;
        num2 <= 16'b1;
        num3 <= 16'b1;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            seq_output <= 16'b0;
            num1 <= 16'b0;
            num2 <= 16'b1;
            num3 <= 16'b1;
        end else begin
            seq_output <= num1 + num2;
            num1 <= num2;
            num2 <= num3;
            num3 <= num1 + num2;
        end
    end

    assign seq_o = seq_output;

endmodule
