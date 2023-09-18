`timescale 1ns/1ps

module tb_N_bit_adder #(parameter N = 8);
  // Inputs
  reg [N-1:0] number1;
  reg [N-1:0] number2;

  // Outputs
  wire [N-1:0] result;

  // Instantiate the DUT
  N_bit_adder #(.N(N)) dut (
    .number1(number1),
    .number2(number2),
    .result(result)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Stimulus generation
  initial begin
    number1 = 90;
    number2 = 18;
    #10;
    number1 = 21;
    number2 = 52;
    #10;
    number1 = 73;
    number2 = 86;
    #10;
    number1 = 96;
    number2 = 53;
    #10;
    number1 = 53;
    number2 = 55;
    #10;
    number1 = 55;
    number2 = 85;
    #10;
    number1 = 71;
    number2 = 71;
    #10;
    number1 = 75;
    number2 = 21;
    #10;
    $finish;
  end

  // Output checking
  always @(posedge clk) begin
    $display("Result: %b", result);
  end

endmodule
