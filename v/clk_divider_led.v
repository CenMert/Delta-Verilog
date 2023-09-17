`timescale 1ns / 1ps

module clk_divider_led(
    input [3:0]d,
    input clk,
    input rst, // aktif yüksek
    output reg [3:0] q
);

    reg clkdiv; // clock_divider_freq'den gelen bölünmüş saat
    reg din;    // gecikmeli d girişi

    reg [3:0] clk_counter;
    reg [3:0] freq;

    initial begin
        clk_counter = 0;
        clkdiv = 1; // 'clkdiv' değişkenini başlangıçta 1 olarak ayarlayın
        freq = 2;   // Örnek frekans değeri
    end

    always @(posedge clk or posedge rst) begin
        if (rst == 1) begin
            clk_counter <= 0;
            clkdiv <= 1;
        end else begin
            clk_counter <= clk_counter + 1;
            if (clk_counter <= (freq / 2)) begin
                clkdiv <= ~clkdiv;
            end else if (clk_counter >= freq) begin
                clk_counter <= 0;
                clkdiv <= ~clkdiv;
            end
        end
    end

    always @(posedge clkdiv or posedge rst) begin
        if (rst == 1) begin
            q <= 0;
        end else begin
            q <= d;
            din <= ~clkdiv; // Bölünmüş saat yükselen kenarı
        end
    end
    

endmodule


