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
 * 1 read port and 1 write port in the same time
 */
module bram_dualport #(
    parameter RAM_WIDTH = 16,
    parameter RAM_DEPTH = 1024,
    parameter WR_MODE = 2'b11
) (
    input clk,
    input wr_ena,
    input rd_enb,
    input [9:0] addra,
    input [9:0] addrb,
    input [RAM_WIDTH - 1:0] dina,
    output reg [RAM_WIDTH - 1:0] doutb
    );

    // mem'in tanımlanmsı
    reg [RAM_WIDTH - 1:0] mem [RAM_DEPTH - 1:0];

    //çakışma durumları için parametre tanımlaması
    localparam READ_FIRST   = 2'b01;
    localparam WRITE_FIRST  = 2'b10;
    localparam NO_CHANGE    = 2'b11;

    // çakışma durumunda kimin önce davranacağını belirleyen state
    reg [1:0] state = WR_MODE;

    // ilk atamaların yapılması
    integer i;
    // 0 a atama işlemleri
    initial begin

        for (i = 0; i < (RAM_DEPTH-1); i = i + 1)begin
            mem[i] = 16'b0;
        end
    end

    // eğer adresler eşitse case'lere gir değilse her zamanki
    // memory işlemlerini gerçekleştir

    //port A ve B için aynı clock içerisinde işlem yaptım
    always @(posedge clk) begin
        if (addra == addrb) begin
            case(state)
                READ_FIRST: begin
                    doutb       = mem[addrb]; 
                    mem[addra]  = dina;
                end

                WRITE_FIRST: begin
                    mem[addra]  = dina;
                    doutb       = mem[addrb]; 
                end

                NO_CHANGE: begin
                    doutb       = mem[addrb];
                end
                    
            endcase
        end
        else begin
            if (wr_ena) mem[addra]  <= dina;
            if (rd_enb) doutb       <= mem[addrb];
        end

    end

endmodule