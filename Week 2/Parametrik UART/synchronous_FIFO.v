`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.09.2023 17:57:44
// Design Name: 
// Module Name: synchronous_FIFO
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


module synchronous_FIFO
#(
    parameter N = 8,
    parameter D = 8
)
(
    input clk,

    // Yazma işlemleri
    input wr_en,
    input [N-1:0] din,
    output reg full,

    // Okuma işlemleri
    input rd_en,
    output reg [N-1:0] dout,
    output reg empty
);

    // FIFO belleği
    reg [N-1:0] memory [0:D-1]; // Adresler 0'dan başlıyor

    // Yazma ve okuma işaretçileri
    reg [$clog2(D)-1:0] write_ptr = 0;
    reg [$clog2(D)-1:0] read_ptr = 0;

    // FIFO'nun başlangıç durumu
    initial begin
        full <= 0;
        empty <= 1;
    end

    // Veriyi yazma ve okuma işlemleri
    always @(posedge clk) begin
        if (wr_en && !full) begin
            memory[write_ptr] <= din;
            write_ptr <= (write_ptr == D-1) ? 0 : write_ptr + 1;
            if (write_ptr == read_ptr) full <= 1;
            empty <= 0;
        end

        if (rd_en && !empty) begin
            dout <= memory[read_ptr];
            read_ptr <= (read_ptr == D-1) ? 0 : read_ptr + 1;
            if (read_ptr == write_ptr) empty <= 1;
            full <= 0;
        end
    end

endmodule

