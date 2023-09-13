`timescale 1ns/1ps

module reverse_100bit_input_tb;

  // Inputs
  reg [99:0] in;

  // Outputs
  wire [99:0] o;

  // Instantiate the Unit Under Test (UUT)
  reverse_100bit_input uut (
    .in(in),
    .o(o)
  );

  initial begin
    // Initialize Inputs
    in = 100'b0;

    // Wait 100 ns for global reset to finish
    #100;

    // Add stimulus here
    in = 100'b1110101010;
    #10;
    in = 100'b0101010111;
    #10;
    // ...

    // End simulation
    $finish;
  end

endmodule