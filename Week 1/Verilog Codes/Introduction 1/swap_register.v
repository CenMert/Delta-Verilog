`timescale 1ns / 1ps 

module swap_registers #(parameter N = 8)(
  input reset,
  input [N-1:0] reg1,
  input [N-1:0] reg2,
  output reg [N-1:0] reg1_o,
  output reg [N-1:0] reg2_o
);

  always @(posedge reset or posedge reg1 or posedge reg2) begin
    if (reset) begin
      reg1_o <= 0;
      reg2_o <= 0;
    end
    else begin
      reg1_o <= reg2;
      reg2_o <= reg1;
    end
  end

endmodule
