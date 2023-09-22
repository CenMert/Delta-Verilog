 `timescale 1ns / 1ps

module tb_sequence_detector_fsm_moore;
    
    reg d_in;
    reg clk;
    reg rst;
    wire d_out;
    
    // Instantiate the sequence detector FSM (Moore)
    sequence_detector_fsm_moore uut (
        .d_in(d_in),
        .clk(clk),
        .rst(rst),
        .d_out(d_out)
    );
    
    // Clock generation
    always begin
        #5 clk = ~clk;
    end
    
    // Reset generation
    initial begin
        rst = 1;
        clk = 0;
        #10 rst = 0;
        #5  d_in = 1;
        #10 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 1;
        #10 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 1;
        #10 d_in = 0;
        #10 d_in = 0;
        #10 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 1;
        #10 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 1;
        #10 d_in = 0;
        #10 d_in = 1;
        #10 d_in = 0;
        #10 d_in = 0;
        rst = 1 ;
        #20;
        
        
    end
    
endmodule
