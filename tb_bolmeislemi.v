`timescale 1ns / 1ps

module tb_bolmeislemi(

    );
    reg [9:0] bolunen;
    reg [5:0] bolen;
    
    wire [3:0] rakam1;
    wire [3:0] rakam2;
    wire [3:0] rakam3;
    
    kesirlibolme uut(
    
    .bolunen (bolunen), 
    .bolen (bolen),
    .rakam1 (rakam1),
    .rakam2 (rakam2),
    .rakam3 (rakam3) 
    //çaðýrma iþlemini burada tamamladýk  
    );
    initial begin
    
    bolunen = 10'b0111110100;
    bolen=4;
    #5;
    bolunen = 10'b0000011001;
    bolen=3;
    #5;
    
    end
    
endmodule
