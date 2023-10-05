module tb_UART_rx;

  // Giri� ve ��k�� sinyalleri tan�mlama
  reg clk;
  reg in_data;
  reg start;
  reg rst;
  wire [15:0] out_data;
  wire valid;

  // UART_rx mod�l�n�n �a�r�lmas�
  UART_rx #(
    .WIDTH(16)
  ) uut (
    .clk(clk),
    .in_data(in_data),
    .start(start),
    .rst(rst),
    .out_data(out_data),
    .valid(valid)
  );
  
  always begin
    #5 clk = ~clk; // 5 zaman birimi boyunca sinyali de�i�tir
  end

  // Test senaryosu
  initial begin

    // Saat sinyali ba�latma
    clk = 0;

    // Reset sinyali uygulama
    rst = 1;
    start = 1;
    in_data = 0;
    #5 rst = 0;

    // Veri iletimi senaryosu
    // �rnek: 8 bitlik bir veri iletimi
    start = 0;
    
    
    //1. veri
    #15 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 start = 1;
    // 2. veri
    #60 start = 0;
    #15 in_data = 1;
    #10 in_data = 1;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 1;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 1;
    #10 in_data = 0;
    #10 in_data = 0;
    #10 in_data = 0;
    #10 start = 1;
    #30;

    $finish; // Sim�lasyonu sonland�r
  end

endmodule


