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
 * 2 read port and 2 write port in the same time
 */
module bram_truedualport #(
    parameter RAM_WIDTH = 16,
    parameter RAM_DEPTH = 1024,
    parameter WR_MODE = 2'b11
) (
    input clk,
    input wr_ena, rd_ena,
    input wr_enb, rd_enb,
    input [9:0] addra, addrb,
    input [RAM_WIDTH - 1:0] dina, dinb,
    output reg [RAM_WIDTH - 1:0] douta, doutb
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
    // 0 a atama işlemleri
    integer i;
    initial begin  
        for (i = 0; i < (RAM_DEPTH-1); i = i + 1)begin
            mem[i] = 16'b0;
        end
    end

    always @(posedge clk)begin
        // ikiside aynı adresi gösterip yamaya kalkarlarsa hiç birinin datası mem'e girmez (NO_CHANGE)
        if (addra == addrb && wr_ena == 1 && wr_enb == 1)begin
            mem[addra] <= mem[addra];
        end 
        else if (addra == addrb && ( (wr_ena == 1 && rd_enb == 1) || (wr_enb == 1 && rd_ena == 1) ) ) begin
            case(state)
                READ_FIRST: begin
                    if (wr_ena == 1) begin
                        doutb       = mem[addrb]; 
                        mem[addra]  = dina;
                    end
                    if (wr_enb == 1) begin
                        douta       = mem[addra]; 
                        mem[addrb]  = dinb;
                    end
                end

                WRITE_FIRST: begin
                    if (wr_ena == 1) begin
                        mem[addra]  = dina;
                        doutb       = mem[addrb]; 
                    end
                    if (wr_enb == 1) begin
                        mem[addrb]  = dinb;
                        douta       = mem[addra];
                    end
                end

                NO_CHANGE: begin
                    doutb       = mem[addrb];
                    douta       = mem[addra];
                end
            endcase
        end else begin
            if (wr_ena) mem[addra]  <= dina;
            if (wr_enb) mem[addrb]  <= dinb;
            if (rd_enb) doutb       <= mem[addrb];
            if (rd_enb) douta       <= mem[addra];
        end
    end
endmodule