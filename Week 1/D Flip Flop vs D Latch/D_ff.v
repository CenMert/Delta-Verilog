`timescale 1ns / 1ps

module D_ff(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
    );

    reg [15:0] reg_out;

    always @(posedge clk, negedge resetn) begin

        if (!resetn) begin
            //active low gelirse sıfırla
            reg_out <= 0;
        end
        else begin
            case (byteena)
                2'b01: begin
                    reg_out [15:8]  <= 0;
                    reg_out [7:0]   <= d[7:0];
                    end
                2'b10: begin
                    reg_out [15:8]  <= d[15:8];
                    reg_out [7:0]   <= 8'b0;
                    end
                2'b11:
                    reg_out <= d;
                default:
                    reg_out <= 0;
            endcase

        end // else sonu

    end //always sonu
    assign q = reg_out;
endmodule
