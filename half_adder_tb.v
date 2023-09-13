`timescale 1ns / 1ps

module tb_half_adder;
    reg A, B;
    wire sum, carry;

    // Instantiate the half_adder module
    half_adder UUT (
        .A(A),
        .B(B),
        .sum(sum),
        .carry(carry)
    );

    // Clock generation
    reg clock = 0;
    always begin
        #5 clock = ~clock;
    end

    // Test vector generation
    initial begin
        $display("A\tB\tSum\tCarry");
        A = 0; B = 0;
        repeat (4) begin
            #10 A = ~A;  // Toggle A
            repeat (4) begin
                #5 B = ~B;  // Toggle B
                // Display inputs, outputs
                $display("%b\t%b\t%b\t%b", A, B, sum, carry);
            end
        end
        $finish;
    end
endmodule

