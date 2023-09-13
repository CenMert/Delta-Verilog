module swap_registers #(parameter N = 8)(
  input reset,
  input [N-1:0] reg1,
  input [N-1:0] reg2,
  //reg tanımladım ki kolay işlem olsun
  output reg [N-1:0] reg1_o,
  output reg [N-1:0] reg2_o
);

  always @(*) begin
    if (reset) begin //reset 1 ise hepsini 0 yap
      reg1_o = 0;
      reg2_o = 0;
    end
    
    else begin // ekstra reg kullnamadan atama
      reg1_o = reg2;
      reg2_o = reg1;
    end
  end

endmodule

module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    assign p2y = (p2a & p2b) | (p2c & p2d);
    assign p1y = (p1a & p1c & p1b) | (p1f & p1e & p1d);

endmodule


