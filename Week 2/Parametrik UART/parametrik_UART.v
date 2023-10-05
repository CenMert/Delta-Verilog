`timescale 1ns / 1ps

// genel parametrik
//  Baud Rate            (9600, 19200, 115200, others)
//  Number of Data Bits  (7, 8)
//  Parity Bit           (On, Off) 0 1
//  Stop Bits            (0, 1, 2)
//  Flow Control         (None, On, Hardware)
module parametrik_UART #(
    parameter WIDTH = 16,
    parameter DEPTH = 16
) (
    input clk,
    input rst,

    // uart rx
    input start_rx, //start stop 
    input in_data_rx, //1 bit
    

    // uart tx
    input start_tx,
    output out_data // modÃ¼l Ã§Ä±kÄ±ÅŸÄ± yanÄ± zamanda

    // senkon FIFO
    // *yazma*
    

    // *yazma*
    
    );
    wire [WIDTH-1:0] out_data_rx; //FIFOya giren kýsým
    wire valid_rx_to_FIFO_wren;
    wire [WIDTH-1:0] in_data_tx; //FIFO dan çýkan kýsým
    wire out_data_tx;
    
    wire valid_tx_to_FIFO_rden;
    wire full;
    wire [WIDTH-1:0] out_data_read;
    wire empty;

    UART_rx #(WIDTH) uart_rx(
        .clk(clk),
        .in_data(in_data_rx),
        .start(start_rx),
        .rst(rst),
        .out_data(out_data_rx),
        .valid(valid_rx_to_FIFO_wren)
    );

    synchronous_FIFO #(WIDTH, DEPTH) sFIFO(
        .clk(clk),
        .wr_en(valid_rx_to_FIFO_wren),
        .din(out_data_rx),
        .full(full),
        .rd_en(valid_tx_to_FIFO_rden),
        .dout(in_data_tx),
        .empty(empty)
    );

    UART_tx #(WIDTH) uart_tx(
        .clk(clk),
        .in_data(in_data_tx),
        .start(start_tx),
        .rst(rst),
        .out_data(out_data_tx),
        .valid(valid_tx_to_FIFO_rden)
    );
     
    assign out_data = out_data_tx;


endmodule