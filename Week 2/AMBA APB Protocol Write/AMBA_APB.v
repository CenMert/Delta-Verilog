`timescale 1ns / 1ps

module Interface_APB
#(  DATA_WIDTH = 32,
    ADDRESS_WIDTH = 32 //APB transection generated address
)
(   
    input clk,
    input [ADDRESS_WIDTH-1:0] address,
    input [DATA_WIDTH-1:0] data,

   // output [DATA_WIDTH-1:0] data_done // test için datanın stenilen adreste istenilen data olduğunun kontrolü için
    output wire [ADDRESS_WIDTH-1:0] MASTER_ADDRESS,
    output wire [DATA_WIDTH-1:0] MASTER_DATA,

    output wire [ADDRESS_WIDTH-1:0] SLAVE_ADDRESS,
    output wire [DATA_WIDTH-1:0] SLAVE_DATA
    );

    reg apb_pclk;
    always @(posedge clk, negedge clk) begin // master ve slave de kullanılacak apb_pclk
        apb_pclk = clk;
    end
    // protocol'den çıkan sonuçların atanması
    // The output APB transaction uses the following signals:
    wire apb_psel_o;                        // selection
    wire apb_penable_o;                     // enable signal
    wire [ADDRESS_WIDTH - 1:0] apb_paddr_o; // address
    wire apb_pwrite_o;
    wire [DATA_WIDTH - 1:0] apb_pwdata_o;   // data signal

    master_APB master_inst (
        .apb_pclk(apb_pclk),
        .address(address),
        .data(data),
        .apb_psel_o(apb_psel_o),
        .apb_penable_o(apb_penable_o),
        .apb_paddr_o(apb_paddr_o),
        .apb_pwrite_o(apb_pwrite_o),
        .apb_pwdata_o(apb_pwdata_o),

        .MASTER_ADDRESS(MASTER_ADDRESS),
        .MASTER_DATA(MASTER_DATA)
    );

    slave_APB slave_inst (
        .apb_pclk(apb_pclk),
        .apb_psel_o(apb_psel_o),
        .apb_penable_o(apb_penable_o),
        .apb_paddr_o(apb_paddr_o),
        .apb_pwrite_o(apb_pwrite_o),
        .apb_pwdata_o(apb_pwdata_o),

        .SLAVE_ADDRESS(SLAVE_ADDRESS),
        .SLAVE_DATA(SLAVE_DATA)
    );

endmodule

// adressin belirleneceği, slave'in seçileceği, datanın gönderileceği kısım
module master_APB #(
    DATA_WIDTH = 32,
    ADDRESS_WIDTH = 32
) (
    input apb_pclk,
    input [ADDRESS_WIDTH-1:0] address,
    input [DATA_WIDTH-1:0] data,
    output reg apb_psel_o,
    output reg apb_penable_o,
    output reg [ADDRESS_WIDTH - 1:0] apb_paddr_o,
    output reg apb_pwrite_o,
    output reg [DATA_WIDTH - 1:0] apb_pwdata_o,

    //test bench outputları
    output reg [DATA_WIDTH - 1:0] MASTER_DATA,
    output reg [ADDRESS_WIDTH - 1:0] MASTER_ADDRESS
);

    // slave e  geidecek olan verilerin masterdan aktarılması
    always @(posedge apb_pclk) begin
        apb_psel_o <= 1;
        apb_penable_o <= 1;
        apb_pwrite_o <= 1;
        apb_paddr_o <= address;
        apb_pwdata_o <= data;

        // TB
        MASTER_DATA <= data;
        MASTER_ADDRESS <= address;
    end
    


endmodule

module slave_APB #(
    ADDRESS_WIDTH = 32,
    DATA_WIDTH = 32
) (
    input apb_pclk,
    input apb_psel_o,
    input apb_penable_o,
    input [ADDRESS_WIDTH - 1:0] apb_paddr_o,
    input apb_pwrite_o,
    input [DATA_WIDTH - 1:0] apb_pwdata_o,
    output reg apb_pready,

    // TB outputları
    output reg [DATA_WIDTH - 1:0] SLAVE_DATA,
    output reg [ADDRESS_WIDTH - 1:0] SLAVE_ADDRESS
);

    reg [DATA_WIDTH-1:0] mem [ADDRESS_WIDTH-1:0];

    // koşulları sağlıyorsa data'yı yaz ve ready i 11 yap, değilse 0 yap ve bir şey kaydetme
    always @(posedge apb_pclk) begin
        if (apb_penable_o == 1 && apb_pwrite_o == 1 && apb_psel_o == 1) begin
            mem[apb_paddr_o] <= apb_pwdata_o;
            apb_pready <= 1;

            // TB
            SLAVE_DATA <= apb_pwdata_o;
            SLAVE_ADDRESS <= apb_paddr_o;
        end else apb_pready <= 0;
    end

endmodule