`timescale 1ns / 1ps

module top_module #(parameter N = 16)(
    input clk,
    input E, // selector
    input [N-1:0] w, // ilk input
    input [N-1:0] R,
    input [N-1:0] L,
    output reg [N-1:0] Q
    );

    //localparam sc = 5; //stage sayÄ±sÄ±nÄ± kullanmama gerekirse diye
    // art arda sentezde görebilecek miyim diye bakmak istedim ama en son q yu ff_out a atarken bir hata çıktı çözemdim o yüzden istenilen şeklilde bıraktım

    wire [N-1:0] mux_out1 ; //soldakiler Ã§Ä±kÄ±ÅŸlarn bit geniÅŸliÄŸi
    wire [N-1:0] mux_out2 ; //saÄŸdakiler gerekli sc kadar Ã§Ä±kÄ±ÅŸ
    wire [N-1:0] ff_out = Q ; 
    
        mux #(16) m1(
                .fir(Q),
                .sec(w),
                .sel(E),
                .out(mux_out1)
        );

        mux #(16) m2(
                .fir(mux_out1),
                .sec(R),
                .sel(L),
                .out(mux_out2)
        );

        flip_flop #(16) ff(
                .d(mux_out2),
                .clk(clk),
                .q(ff_out)
        );

endmodule
