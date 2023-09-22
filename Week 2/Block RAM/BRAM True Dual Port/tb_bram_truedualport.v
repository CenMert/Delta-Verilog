`timescale 1ns / 1ps

module tb_bram_truedualport;

    // Parameters
    parameter RAM_WIDTH = 16;
    parameter RAM_DEPTH = 1024;
    parameter WR_MODE = 2'b11;

    // Signals
    reg clk;
    reg wr_ena, rd_ena;
    reg wr_enb, rd_enb;
    reg [9:0] addra, addrb;
    reg [RAM_WIDTH - 1:0] dina, dinb;
    wire [RAM_WIDTH - 1:0] douta, doutb;

    // Instantiate the DUT (Device Under Test)
    bram_truedualport #(
        .RAM_WIDTH(RAM_WIDTH),
        .RAM_DEPTH(RAM_DEPTH),
        .WR_MODE(WR_MODE)
    ) uut (
        .clk(clk),
        .wr_ena(wr_ena),
        .rd_ena(rd_ena),
        .wr_enb(wr_enb),
        .rd_enb(rd_enb),
        .addra(addra),
        .addrb(addrb),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        wr_ena = 0;
        rd_ena = 0;
        wr_enb = 0;
        rd_enb = 0;
        addra = 0;
        addrb = 0;
        dina = 0;
        dinb = 0;
        
        //yazma denemesi
        #5;
        wr_ena = 1;
        wr_enb = 1;
        dina = 150;
        dinb = 200;
        addra = 1;
        addrb = 2;
        
        //okuma denemesi
        #10;
        wr_ena = 0;
        wr_enb = 0;
        rd_ena = 1;
        rd_enb = 1;
        addra = 1;
        addrb = 2;
        
        #10;
        wr_ena = 1;
        wr_enb = 1;
        rd_ena = 0;
        rd_enb = 0;
        dina = 300;
        dinb = 500;
        addra = 3;
        addrb = 4;
        
        //birinde yazma birinde okuma
        #10;
        wr_ena = 1;
        wr_enb = 0;
        rd_ena = 0;
        rd_enb = 1;
        dina = 957;
        addra = 1;
        addrb = 2;
        
        //ayný adrese yazdýrmaya çalýþma
        #10;
        wr_ena = 1;
        wr_enb = 1;
        rd_ena = 0;
        rd_enb = 0;
        dina = 6;
        dinb = 3;
        addra = 5;
        addrb = 5;
        
        #10;
        wr_ena = 0;
        wr_enb = 0;
        rd_ena = 1;
        rd_enb = 1;
//        dina = 6;
//        dinb = 3;
        addra = 5;
        addrb = 5;
    
        
        #10;
        $finish; // End simulation
    end
endmodule
