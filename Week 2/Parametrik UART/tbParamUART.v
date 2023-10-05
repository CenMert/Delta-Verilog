`timescale 1ns / 1ps

module tb_parametrik_UART;
    
    reg clk;
    reg rst;
    reg start_rx;
    reg start_tx;
    reg in_data_rx;
    wire out_data_tx;
    
    parametrik_UART #(.WIDTH(16), .DEPTH(16)) uut(
        .clk(clk),
        .rst(rst),
        .start_rx(start_rx),
        .start_tx(start_tx),
        .in_data_rx(in_data_rx),
        .out_data(out_data_tx)
    );
    
  always begin
      #5 clk = ~clk; // 5 zaman birimi boyunca sinyali de?i?tir
  end
  
  initial begin
    clk = 0;
    rst = 1;
    start_rx = 1;
    start_tx= 1;
    in_data_rx = 0;
    #5 rst = 0;
    
    start_rx = 0;
    
    //1. veri
    #15 in_data_rx = 1;
    #10 in_data_rx = 0;
    #10 in_data_rx = 1;
    #10 in_data_rx = 0;
    #10 in_data_rx = 1;
    #10 in_data_rx = 0;
    #10 in_data_rx = 1;
    #10 in_data_rx = 0;
    #10 in_data_rx = 1;
    #10 in_data_rx = 0;
    #10 in_data_rx = 1;
    #10 in_data_rx = 0;
    #10 in_data_rx = 1;
    #10 in_data_rx = 0;
    #10 in_data_rx = 1;
    #10 in_data_rx = 0;
    #10 start_rx = 1;
    #50 start_tx = 0;
    #200 start_tx = 1;
    #40;
    
    $finish;
  end 
  
  
endmodule