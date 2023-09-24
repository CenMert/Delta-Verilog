`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 22:33:16
// Design Name: 
// Module Name: tb_serial_adder
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

module tb_serial_adder;

    reg clk;
    reg [7:0] A;
    reg [7:0] B;
    reg resetn;
    reg start;
    wire [8:0] sum;

    // Clock jenerasyonu
    always begin
        #5 clk = ~clk; // Her 5ns'de bir saat sinyalini de�i�tir
    end

    // Mod�l� �a��r�n
    serial_adder uut (
        .clk(clk),
        .A(A),
        .B(B),
        .resetn(resetn),
        .start(start),
        .sum(sum)
    );

    // Test senaryosu
    initial begin
        // Ba�lang�� de�erlerini ayarlay�n
        clk = 0;
        start = 1;
        A = 8'b00110011;
        B = 8'b01010101;
        resetn = 0;
        

        // Reset i�lemi
        resetn = 0;
        #100 resetn = 1;
        #10 resetn = 0;

        // ��lemi ba�lat
        start = 1;
        #10 A = 8'b10110011;
        B = 8'b11010101;
        // Sonucu bekleyin
        #150;

        // Sonucu g�r�nt�leyin
        $display("Sonu�: %b", sum);

        // Sim�lasyonu sonland�r�n
        $finish;
    end

endmodule

