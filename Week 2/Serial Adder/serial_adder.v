`timescale 1ns / 1ps

// Bu her şeyi içeren top module
module serial_adder(
    input clk,
    input [7:0] A,
    input [7:0] B,
    input resetn,
    input start,
    output wire [8:0] sum
    );

    wire sum_out; // full adder'dan çıkan sum'ı taşıyan wire
    wire fa_ff; // full adder'dan ff e carryout u taşıyan wire
    wire ff_out; // ff den çıkan carryin'i taşıyan wire
    wire A_sr_out; // shift registerdan çıkan bit
    wire B_sr_out; // shift registerdan çıkan bit

    // control fsm den çıkan outputların sisteme dağılımı
    wire reset; 
    wire load;
    wire enable;

    shift_register Ashift_register(
        .clk(clk),
        .din(A),
        .load(load),
        .enable(enable),
        .dout(A_sr_out)
    );

    shift_register Bshift_register(
        .clk(clk),
        .din(B),
        .load(load),
        .enable(enable),
        .dout(B_sr_out)
    );
    control_fsm control_fsm(
        .clk(clk),
        .resetn(resetn),
        .start(start),
        .reset(reset),
        .load(load),
        .enable(enable)
    );

    full_adder full_adder(
        A_sr_out, B_sr_out, ff_out, sum_out, fa_ff
    );

    flip_flop flipflop(
        fa_ff, clk, reset, ff_out
    );

    shift_register_sum srs(
        sum_out, reset, enable, clk, sum
    );

endmodule

module control_fsm(
    input clk, // clk sinyali
    input resetn, // reset sinyalinin aktarımı 
    input start,
    output reg reset, // ff ve sondaki shift-register için reset sinyali, ff için ters çalışıyor
    output reg load, // sayıların yüklenmesi için load sinyali (1)
    output reg enable // açık olduğu sürece işlemler devam etsin (1)
    );

    always @(posedge clk) begin
        if (start == 1)begin
            load <= 1;
            enable <= 1;
        end else begin
            load <= 0;
            enable <= 0;
        end
        if (resetn == 1) begin
            reset <= 1;
        end else begin
            reset <= 0;
        end
    end

endmodule

// shift register sondaki toplamları veren sum
module shift_register_sum (
    input in,
    input reset,
    input enable,
    input clk,
    output [8:0] sum
    );

    reg [8:0] loading_sum = 9'b0;

    reg [3:0] counter = 0;
    reg [3:0] counter_next = 0;

    always @(posedge clk, posedge reset) begin
        if (reset)begin
            counter <= 0;
            counter_next <= 0;
        end else begin
            counter_next <= counter_next + 1;
            counter <= counter_next;
        end
    end

    always @(posedge clk) begin
        if (reset == 1)begin
            loading_sum <= 9'b0_0000_0000;
        end else if (enable == 1) begin
            loading_sum[counter%9] <= in;
        end
    end

    assign sum = loading_sum;

    always @(posedge clk) begin
        $monitor("--------------------");
    end
endmodule

// shift regster tan�mlamas�
module shift_register (
    input clk,
    input [7:0] din,
    input load,
    input enable,
    output dout
    );

    reg [7:0] data = 8'b0;
    reg [3:0] counter = 0;
    reg [3:0] counter_next = 0;

    always @(din) begin
        counter <= 0;
        counter_next <= 0;
    end
    
    always @(posedge clk) begin
        data <= din;
    end

    always @(posedge clk) begin
        counter_next <= counter_next + 1;
        counter <= counter_next;
        if (counter == 8) counter_next <= 0;
    end

    assign dout = data[counter%8];

    always @(posedge clk) begin
        $monitor("time = %d", $time);
        $monitor("counter = %d", counter);
        $monitor("counter_next = %d", counter_next);
        $monitor("shift registerdan cikan bit = %b", dout);
        $monitor("DATA = %b", data);
        $monitor("din = %b", din);
    end

endmodule

// full adder i�in bir module tan�m�
module full_adder(
    input A, B, Cin,
    output reg Sum, Carry
    );
    
    always @* begin
    Sum = A ^ B ^ Cin;
    Carry = ( A & B ) | ( Cin & ( A ^ B ) );
    end

    always @(A, B, Cin) begin
        $monitor("full_adder dan cikan sum = %b || carry = %b", Sum, Carry);
    end

endmodule

module flip_flop(
    input d,         // Veri giriÅŸi
    input clk,       // Saat sinyali
    input reset, 
    output reg q     // Ã§Ä±kÄ±ÅŸ
);

    always @(posedge clk) begin
//        if (reset == 1)begin // gelen reset sinyaline ters çalışıyor
            q <= d; // Saat yÃ¼kselen kenarÄ±nda giriÅŸi Ã§Ä±kÄ±ÅŸa aktar
//        end
    end

endmodule
