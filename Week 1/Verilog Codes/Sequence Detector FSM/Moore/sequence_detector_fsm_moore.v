`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.09.2023 23:20:34
// Design Name: 
// Module Name: sequence_detector_fsm_moore
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

/*
input bir sonraki clocktaki durum
dout clock vurduğunda üzerinde bulunduğum statin çıktısı
current dediğimiz clock vurunca önceden gelen next statin durumu
next state ise current'a ve inputa bağlı 
*/

module sequence_detector_fsm_moore(
    input d_in, clk, rst,
    output reg d_out
    );

    localparam S0 = 5'b00001;
    localparam S1 = 5'b00010;
    localparam S2 = 5'b00100;
    localparam S3 = 5'b01000;
    localparam S4 = 5'b10000;

    reg [4:0] current_state;
    reg [4:0] next_state;

    initial begin
        d_out <= 0;
        current_state <= S0;
        next_state <= S0;
    end
    
    always @(posedge clk)begin
        // önceki inputa göre belirlenen next state i current state'e atıyor
        current_state <= next_state;
    end
    
    always @(current_state, posedge rst, d_in) begin

        if (rst == 1) begin
            d_out <= 0;
            current_state <= S0;
            next_state <= S0;
        end else begin
            
            case (current_state)

                S0:begin
                    d_out <= 0;
                    next_state <= S1;
                end

                S1:begin
                    d_out <= 0;
                    if (d_in == 0)begin
                        next_state <= S2;
                    end
                    else next_state <= S1;
                end

                S2:begin
                    d_out <= 0;
                    if (d_in == 0)begin
                        next_state <= S0;
                    end
                    else next_state <= S3;
                end

                S3:begin
                    d_out <= 0;
                    if (d_in == 0)begin
                        next_state <= S2;
                    end
                    else next_state <= S4;
                end

                S4:begin
                    d_out <= 1;
                    if (d_in == 0)begin
                        next_state <= S2;
                    end
                    else next_state <= S1;
                end
            endcase 
        end      
    end
    
//    assign cs_out = current_state;
//    assign ns_out = next_state;

endmodule
