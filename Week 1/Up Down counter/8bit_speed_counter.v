`timescale 1ns / 1ps

module bit8_speed_counter_1bit1sec(
    input [3:0] speed,
    input clk,
    output [7:0] counter
    
    );

    reg [7:0] reg_counter;
    reg [7:0] clk_counter;
    reg count_direction;

    initial begin
        reg_counter = 0;
        count_direction = 1'b1; //0 biti aşağıya doğru sayıyor
        clk_counter = 0;
    end

    always @ (posedge clk) begin
        //sayacı artır
        clk_counter <= clk_counter + 1;

        if (speed == 1) begin
            if (clk_counter == 100000000) begin
                clk_counter <= 0;
                if(count_direction == 1)begin
                        reg_counter <= reg_counter + 1;
                    end
                    if(count_direction == 0)begin
                        reg_counter <= reg_counter - 1;
                    end
            end
            else begin
                if (reg_counter == 0)begin
                    count_direction <= 1;
                end
                else if (reg_counter == 8'b11111111) begin
                    count_direction <= 0;
                end  
            end
        end

        if (speed == 4) begin
            if (clk_counter == 100000000) begin
                clk_counter <= 0;
                if(count_direction == 1)begin
                        reg_counter <= reg_counter + 4;
                    end
                    if(count_direction == 0)begin
                        reg_counter <= reg_counter - 4;
                    end
            end
            else begin
                if (reg_counter == 0)begin
                    count_direction <= 1;
                end
                else if (reg_counter == 8'b11111111) begin
                    count_direction <= 0;
                end                
            end
        end


        end //always end

        

    assign counter = reg_counter;

endmodule
