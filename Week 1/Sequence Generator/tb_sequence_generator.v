`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 16:01:01
// Design Name: 
// Module Name: tb_sequence_generator
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
module tb_sequence_generator;
    
    reg reset;
    reg clk;
    wire [15:0] seq_o;
    
    // Instantiate the sequence generator
    sequence_generator uut (
        .reset(reset),
        .clk(clk),
        .seq_o(seq_o)
    );
    
    // Clock generation
    always begin
        #5 clk = ~clk;
    end
    
    // Initialize reset
    initial begin
        reset = 0;
        clk = 0;
        #100 reset = 1;
        #20 reset = 0;
    end
    
endmodule
