`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 17:03:01
// Design Name: 
// Module Name: sequence_detector_fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sequence_detector_fsm_mealy(
    input d_in, clk, rst,
    output reg d_out
    );

    localparam S0 = 4'b00;
    localparam S1 = 4'b01;
    localparam S2 = 4'b11;
    localparam S3 = 4'b10;

    reg [1:0] state;

    always @(posedge clk ,posedge rst) begin
        if (rst == 1) begin
            d_out <= 0;
            state <= 4'b00;
        end else begin
            case (state)
                S0:begin
                    if (d_in == 0) begin
                        state <= 4'b00;
                        d_out <= 0;
                    end
                    if (d_in == 1) begin
                        state <= 4'b01;
                        d_out <= 0;
                    end 
                end

                S1:begin
                    if (d_in == 0) begin
                        state <= 4'b11;
                        d_out <= 0;
                    end
                    if (d_in == 1) begin
                        state <= 4'b01;
                        d_out <= 0;
                    end 
                end

                S2:begin
                    if (d_in == 0) begin
                        state <= 4'b00;
                        d_out <= 0;
                    end
                    if (d_in == 1) begin
                        state <= 4'b10;
                        d_out <= 0;
                    end 
                end

                S3:begin
                    if (d_in == 0) begin
                        state <= 4'b01;
                        d_out <= 0;
                    end
                    if (d_in == 1) begin
                        state <= 4'b01;
                        d_out <= 1;
                    end 
                end

            endcase 
        end

        if (d_out == 1) begin
            $display("Detected");
        end
    end

endmodule
