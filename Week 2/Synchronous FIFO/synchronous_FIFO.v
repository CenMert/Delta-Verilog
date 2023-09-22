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

    // yazma işlemleri
    input wr_en,
    input [N-1:0] din,
    output reg full,

    // okuma işlemleri
    input rd_en,
    output reg [N-1:0] dout,
    output reg empty
    );

    // yazacağımız FIFO memory'si
    // $clog2 log ikisini alıp adresleri tutmak için ne kadarlık bir bite ihtiyacım var onu gösteriyor
    // şu anlık 8 bit genişliğinde 8 tane register var.
    reg [N-1:0] memory [D-1:0];

    // senkronizasyon kontrolü için 2 tane kontrolcü
    // bunlar adressleri belirten ve sırayla okuma yazma işlemi yapmamı kontrol edenler
    // nereye yazılacağını  ve nerenin okunacağını bu ikisi belirleyecek
    // kontrolcülerimiz 3 bitlik ve 8 adresi tutyor
    reg [$clog2(D)-1:0] writec = 0;
    reg [$clog2(D)-1:0] readc = 0;

    // wr_en aktif ise, dolu değil ise, yaz ve kontrolcüyü arttır
    // eğer kontrolcü derinlik kadar ilerlemişse durummu doluya çevir
    always @(posedge clk) begin
        if (wr_en == 1) begin
            if (!full) begin
                memory[writec] <= din;
                writec <= writec + 1;
                if (writec == (D-1) && readc >= 1) begin
                    writec <= 0;
                    full <= 1;
                end else full <= 0;
                
            end
        end

        if (rd_en == 1) begin
            if (!empty) begin
                dout <= memory[readc];
//                memory[readc]<= 0; // veriyi okuduktan sonra 0 lamak istedim ama bu sefer veri kayb� olabilir diye o k�sm� kald�rd�m
                readc <= readc + 1;
                if (readc == (D-1) & writec >= 1) begin
                    readc <= 0;
                    empty <= 1;
                end else empty <= 0;
            end
        end
    end

// monitorleme k�sm�. dosyalar k�sm�nda verdi�im ikinci ss buna ait
//    always @(posedge clk) begin
//        $monitor("[%0t] [FIFO] wr_en=%b din=%d rd_en=%b dout=%d empty=%b full=%b",
//                    $time, wr_en, din, rd_en, dout, empty, full);
//        $monitor("[memeory]| %d | %d | %d | %d | %d | %d | %d | %d |",
//         memory[0],memory[1],memory[2],memory[3],memory[4],memory[5],memory[6],memory[7]);
//    end
    
    initial begin
        full = 0;
        empty = 0;
        dout = 0;
    end

endmodule
