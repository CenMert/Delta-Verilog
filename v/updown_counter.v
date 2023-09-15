`timescale 1ns / 1ps

// 3-bit up/down counter with a reset feature.

module updown_counter_3bit (
    input reset,
    input clk,
    output [2:0] counter
    );

    reg [2:0] reg_counter;
    reg count_direction;

    initial begin
        reg_counter = 3'b111;
        count_direction = 1'b0; //0 biti aşağıya doğru sayıyor
    end

    always @ (posedge clk) begin
        // reset bloğu
        if (reset == 1)begin
            reg_counter <= 3'b111;
            count_direction <= 1'b0; 
        end
        else begin
                if (reg_counter == 0)begin
                count_direction <= 1;
                reg_counter <= reg_counter + 1;
            end
            else if (reg_counter == 7) begin
                count_direction <= 0;
                reg_counter <= reg_counter - 1;
            end
            else begin
                if(count_direction == 1)begin
                    reg_counter <= reg_counter + 1;
                end
                if(count_direction == 0)begin
                    reg_counter <= reg_counter - 1;
                end
            end
        end
    end

    assign counter = reg_counter;

endmodule
