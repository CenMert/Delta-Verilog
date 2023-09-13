`timescale 1ns/1ps

module swap_registers_tb #(parameter N = 8);

  // input
  reg reset;
  reg [N-1:0] reg1;
  reg [N-1:0] reg2;

  // output
  wire [N-1:0] reg1_o;
  wire [N-1:0] reg2_o;

  //uut tanımı
  swap_registers #(.N(N)) uut (
    .reset(reset),
    .reg1(reg1),
    .reg2(reg2),
    .reg1_o(reg1_o),
    .reg2_o(reg2_o)
  );

  initial begin
    //input başlatıcısı
    reset = 1;
    reg1 = 8'd1;
    reg2 = 8'd2;

    // ilk 10 ns bekleme
    #10;
    reset = 0;
    reg1 = 8'd3;
    reg2 = 8'd4;
    #10;
    
    reg1 = 8'd5;
    reg2 = 8'd6;
    #10;
    reset = 1;
    #10;
    
    $finish;
  end

endmodule