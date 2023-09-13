`timescale 1ns / 1ps

module N_bit_adder #(parameter N = 8)(
    input [N-1:0] number1, 
    input [N-1:0] number2,
    output [N-1:0] result
    );
    
    wire full_carry;
    wire [N-1:0] general_carry;
    
    //toplama iþlemi
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1)begin
        
            if (i == 0)begin
                half_adder ha(
                    .A(number1[0]),
                    .B(number2[0]),
                    .sum(result[0]),
                    .carry(general_carry[0])
                );
                end //if == 0 end
                
            else begin
                full_adder fa(
                    .A(number1[i]),
                    .B(number2[i]),
                    .Cin(general_carry[i-1]),
                    .Sum(result[i]),
                    .Carry(general_carry[i])
                ); 
            end // else end
        
        end //loop sonu
        
    endgenerate // generate sonu
    
endmodule
