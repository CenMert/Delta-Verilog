// recevier k�sm�
module UART_rx #(
    parameter WIDTH = 16
) (
    input clk,
    input in_data, // tek bitlik input
    input start, //start 1 stop 0 inputu
    input rst, //asenkron high-active reset
    output reg [WIDTH-1:0] out_data,
    output reg valid // datan�n tamamland���n� s�yler
);
    
    reg [WIDTH-1:0] load_data = 0; // datay� tutacak olan reg (paralel-out)
    reg [$clog2(WIDTH)-1:0] clk_counter; // clk saayc�, bitleir tutacak
    reg [$clog2(WIDTH)-1:0] next_clk_counter; // sonraki biti gösteriyor
    // reg [$clog2(WIDTH)-1:0] bit_counter; // bunu kullanmadım
    
    // akışı kontrol etmek için
    reg [2:0] bit_STATE         = 3'b111;
    reg [2:0] bit_next_STATE    = 3'b111;
    localparam bit_IDLE         = 3'b111; // start ve stopun çalışması için gerkeli
    localparam bit_START        = 3'b001; // 1 clk start
    localparam bit_STOP         = 3'b010; // 2 clk stop
    localparam bit_LOAD         = 3'b100; // WIDTH kadar load

    // start komutunu çalıştırma atamaları yapma
    always @(posedge clk, negedge start, posedge rst) begin
        if (rst == 1) begin
            bit_STATE <= bit_IDLE;
            bit_next_STATE <= bit_IDLE;
            clk_counter <= 0;
            next_clk_counter <= 1;
            valid <= 0;
            load_data <= 0;
            out_data <= 0;
        end 
        else if (start == 0 && bit_STATE == bit_IDLE) begin
            bit_STATE <= bit_START;
            bit_next_STATE <= bit_LOAD;
            valid <= 0;
        end
    end

    // stop komutunu çalıştırma ve atamalrı yapma
    always @(posedge clk, posedge start, posedge rst) begin
        if ( rst == 1) begin
            bit_STATE <= bit_IDLE;
            bit_next_STATE <= bit_IDLE;
            clk_counter <= 0;
            next_clk_counter <= 1;
            valid <= 0;
            out_data <= 0;
        end 
        else if (start == 1 && bit_STATE == bit_STOP) begin
            bit_STATE <= bit_STOP;
            bit_next_STATE <= bit_STOP;
        end
    end
    
    always @(posedge clk, posedge rst) begin

        

        if (rst == 1) begin
            bit_STATE <= bit_IDLE;
            bit_next_STATE <= bit_IDLE;
            clk_counter <= 0;
            next_clk_counter <= 1;
            valid <= 0;
            out_data <= 0;
        end else if (rst == 0) begin 
            if (bit_STATE != bit_START || bit_STATE != bit_STOP)begin
                bit_STATE <= bit_next_STATE;
            end

            case (bit_STATE)

                bit_START: begin
                    clk_counter <= 0;
                    next_clk_counter <= 1;
                    bit_next_STATE <= bit_LOAD;
                    load_data <= 0;

                end

                bit_LOAD: begin
                    if (clk_counter == (WIDTH-1)) begin
                        clk_counter <= 0;
                        next_clk_counter <= 0;

                        load_data[clk_counter] <= in_data;
                        bit_STATE <= bit_STOP;
                        bit_next_STATE <= bit_STOP;
                        valid <= 0;

                    end 
                    else if (clk_counter < (WIDTH-1)) begin
                        clk_counter <= next_clk_counter;
                        next_clk_counter <= next_clk_counter + 1;

                        load_data[clk_counter] <= in_data;
                        bit_next_STATE <= bit_LOAD;
                        valid <= 0;
                    end
                    
                end

                bit_STOP: begin
                    if (bit_next_STATE == bit_STOP) begin
                        clk_counter <= 0;
                        next_clk_counter <= 1;
                        valid <= 1;
                        out_data <= load_data;
                        bit_next_STATE <= bit_IDLE;
                    end 
                    else if (bit_next_STATE == bit_IDLE) begin
                        clk_counter <= 0;
                        next_clk_counter <= 1;
                        valid <= 1;
                        out_data <= load_data;
                        bit_next_STATE <= bit_IDLE;
                    end 
                end

                bit_IDLE: begin
                    valid <= 0;
                    clk_counter <= 0;
                    next_clk_counter <= 1;
                    out_data <= load_data;
                    
                end
            endcase
        end // if rst 0 end
    end // always end

    // monitor
    always @(posedge clk) begin
        $monitor("time = %d", $time);
        $monitor("counter = %d", clk_counter);
        $monitor("counter_next = %d", next_clk_counter);
        $monitor("load_data = %b", load_data);
        $monitor("din = %b | index = %d", in_data, clk_counter);
        $monitor("bit_STATE = %d", bit_STATE);
        $monitor("bit_next_STATE = %d", bit_next_STATE);
    end

endmodule