module top_module #(parameter N = 16) (
    input clk,
    input [N-1:0] r0, r1, r2, // mux girişleri
    input L, // mux seçici girişi
    output [N-1:0] q2 // ana çıkış
    );

    wire [N-1:0] q0, q1; // iç mux çıkışları
    reg [N-1:0] xor_out; // xor çıkışı

    wire [N-1:0] ff1_in, ff2_in, ff3_in; //fflerin girişleri
    wire [N-1:0] q2_in_wire;

    assign q2_in_wire = q2;

        mux #(16) m1(
            .fir(q2_in_wire),
            .sec(r0),
            .sel(L),
            .out(ff1_in)
        );

        flip_flop #(16) ff1(
            .d(ff1_in),
            .clk(clk),
            .q(q0)
        );

// mux2 ff2
        
        mux #(16) m2(
            .fir(q0),
            .sec(r1),
            .sel(L),
            .out(ff2_in)
        );

        flip_flop #(16) ff2(
            .d(ff2_in),
            .clk(clk),
            .q(q1)
        );

    always @(posedge clk) begin // mux3 ff3
        xor_out = q2_in_wire ^ q1;
    end
    
        mux #(16) m3(
            .fir(xor_out),
            .sec(r2),
            .sel(L),
            .out(ff3_in)
        );

        flip_flop #(16) ff3(
            .d(ff3_in),
            .clk(clk),
            .q(q2)
        );

    
endmodule
