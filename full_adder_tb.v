

`timescale 1ns / 1ps

module tb_full_adder;
    reg A, B, Cin;
    wire Sum, Carry;

    // Instantiate the full_adder module
    full_adder UUT (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Carry(Carry)
    );

    // Clock generation
    reg clock = 0;
    always begin
        #5 clock = ~clock;
    end

    // Test vector generation
    initial begin
        $display("A\tB\tCin\tSum\tCarry");
        A = 0; B = 0; Cin = 0;
        repeat (8) begin
            #10 A = ~A;  // Toggle A
            repeat (8) begin
                #10 B = ~B;  // Toggle B
                repeat (4) begin
                    #5 Cin = ~Cin;  // Toggle Cin
                    // Display inputs and outputs
                    $display("%b\t%b\t%b\t%b\t%b", A, B, Cin, Sum, Carry);
                end
            end
        end
        $finish;
    end
endmodule
