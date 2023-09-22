`timescale 1ns / 1ps

module testbench_sFIFO;

  reg clk;
  reg wr_en;
  reg [7:0] din;
  reg rd_en;

  wire [7:0] dout;
  wire empty;
  wire full;

  // Synchronous FIFO modülünü çaðýrýn
  synchronous_FIFO #(8, 8) uut (
    .clk(clk),
    .wr_en(wr_en),
    .din(din),
    .rd_en(rd_en),
    .dout(dout),
    .empty(empty),
    .full(full)
  );

  // Clock sinyali oluþturun
  always begin
    #5 clk = ~clk;
  end

  // Test senaryosunu oluþturun
  initial begin
    clk = 0;
    wr_en = 0;
    din = 8'h00;
    rd_en = 0;
    #5;

    // Veri yazma iþlemi
    wr_en = 1;
    din = 8'hAA;
    #10;
    
    wr_en = 1;
    rd_en = 1;
    din = 8'b0100_1011;
    #10;
      
    din = 8'b0011_1011;
    #10;
    din = 8'b1100_1001;
    #10;  
    din = 8'd35;
    #10;  
    din = 8'd254;
    #10;   
    din = 8'd123;
    #10;    
    din = 8'd94;
    #10;    
    din = 8'd100;
    #10;
    din = 8'd197;
    #10;
    din = 8'd43;
    #10;
    din = 8'd34;
    #10;
    din = 8'd53;
    #10;
    

    // FIFO'nun iç durumunu gözlemlemek için $display kullanabilirsiniz

    // Simülasyonu sonlandýrýn
    $finish;
  end

endmodule
