`timescale 1ns / 1ps

module testbench_AMBA_APB;

    // Parametreler
    parameter DATA_WIDTH = 32;
    parameter ADDRESS_WIDTH = 32;

    // Clock sinyali olu�turuluyor
    reg clk;
    always begin
        #5 clk = ~clk; // 5 zaman birimi boyunca periyodu de�i�tir (�rne�in, 5ns'de bir)
    end

    // DUT (Design Under Test) mod�lleri �rneklemeleri
    reg [ADDRESS_WIDTH-1:0] address;
    reg [DATA_WIDTH-1:0] data;
    wire [ADDRESS_WIDTH-1:0] MASTER_ADDRESS;
    wire [ADDRESS_WIDTH-1:0] SLAVE_ADDRESS;
    wire [DATA_WIDTH-1:0] MASTER_DATA;
    wire [DATA_WIDTH-1:0] SLAVE_DATA;

    Interface_APB dut (
        .clk(clk),
        .address(address),
        .data(data),

        .MASTER_ADDRESS(MASTER_ADDRESS),
        .MASTER_DATA(MASTER_DATA),
        .SLAVE_ADDRESS(SLAVE_ADDRESS),
        .SLAVE_DATA(SLAVE_DATA)
    );

    // Test senaryosu
    initial begin
        // Clock sinyali ba�lat�l�yor
        clk = 0;

        // Adres ve veri de�erleri atan�yor
        address = 32'hABBA0000; // �rnek bir adres
        data = 32'hABCDEF01;   // �rnek bir veri
        #30;

        address = 32'hBAFF0000;
        data = 32'hACFED000;
        #30;

        address = 32'hCAFE0000;
        data = 32'hAFFED0F0;
        #30;
        // Veriyi kontrol etmek i�in data_done sinyalini kullanabilirsiniz
        // �rne�in, belirli bir adreste bekledi�iniz veriyi kontrol edebilirsiniz

        // Sim�lasyonu sonland�r
        $finish;
    end

endmodule

