`timescale 1ns / 1ps

module full_adder(
    input A, B, Cin,
    output reg Sum, Carry
    );
    
    always @* begin
    Sum = (!A & !B & Cin) | (!A & B & !Cin) | (A & !B & !Cin) | (A & B & Cin);
    Carry = (B & Cin) | (A & Cin) | (A & B);
    end
endmodule
