`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2023 21:03:07
// Design Name: 
// Module Name: bram_singleport
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


/* 
 * 1 read port and 1 write port in a time
 */
module bram_singleport #(
    parameter RAM_WIDTH = 16,
    parameter RAM_DEPTH = 1024
) (
    input clk,
    input wr_en,
    input rd_en,
    input [9:0] addr,
    input [RAM_WIDTH - 1:0] din,
    output reg [RAM_WIDTH - 1:0] dout
    );

    reg [RAM_WIDTH - 1:0] mem [RAM_DEPTH - 1:0];
    
    integer i = 0;
    initial begin

        for (i = 0; i < (RAM_DEPTH-1); i = i + 1)begin
            mem[i] = 16'b0;
        end
    end

    always @(posedge clk) begin
        if (wr_en) begin
            mem[addr] <= din;
        end

        if (rd_en) begin
            dout <= mem[addr];
        end
    end

endmodule
