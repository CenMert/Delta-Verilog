`timescale 1ns/1ps

module tb_count_zero_inabyte();

    reg [7:0] a_tb;
    wire [3:0] b_tb;

    count_zero_inabyte uut (
        .din(a_tb),
        .count(b_tb)
    );

    initial begin
        a_tb = 8'b0000_0000;
        #10;
        $display("For a = %b, b = %d", a_tb, b_tb);

        a_tb = 8'b1111_1111;
        #10;
        $display("For a = %b, b = %d", a_tb, b_tb);

        a_tb = 8'b1010_1010;
        #10;
        $display("For a = %b, b = %d", a_tb, b_tb);

        a_tb = 8'b0101_0101;
        #10;
        $display("For a = %b, b = %d", a_tb, b_tb);

        a_tb = 8'b1000_0001;
        #10;
        $display("For a = %b, b = %d", a_tb, b_tb);

        $finish;
    end
endmodule
