`timescale 1ns/1ps

module clock_divider_freq #(parameter N = 3) (
    input clk,
    input [N-1:0] freq,
    output reg divided_clock
);

    reg [N-1:0] clk_counter;
    
    initial begin
        clk_counter = 0;
        divided_clock = 0;
    end

        always @(posedge clk) begin
            clk_counter = clk_counter + 1;
            if (clk_counter <= (freq / 2))begin
                divided_clock <= 1;
            end
            else if (clk_counter > (freq/2))begin
                divided_clock = 0;
                if(clk_counter == freq)begin
                    clk_counter = 0;
                end
            end
        end      
    
endmodule