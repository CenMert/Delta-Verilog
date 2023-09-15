`timescale 1ns / 1ps

// 4-bit up/down counter switch ve db_button ile beraber

module updown_counter_4bit (
    input switch,
    input db_button,
    input clk,
    output [3:0] counter
    );

    reg [3:0] reg_counter;
    reg count_direction;

    initial begin //s'ye göre başlatma kısmı
        if (switch == 1)begin
            reg_counter = 4'b0000;
            count_direction = 1;
        end
        else begin
            reg_counter = 4'b1111;
            count_direction = 0;
        end
    end

    always @ (posedge clk) begin
        if (db_button == 1) begin //sayma işlemine devam
                if (reg_counter == 0)begin
                count_direction <= 1;
                reg_counter <= reg_counter + 1;
            end
            else if (reg_counter == 15) begin
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
        else begin //sayma işlemi farklı bir komuta kadar dursun
            reg_counter     <= reg_counter;
            count_direction <= count_direction;
        end
    end

    always @(switch) begin
        count_direction <= switch;
    end

    assign counter = reg_counter;

endmodule
