`timescale 1ns/1ps

module uart_tb;

logic clk;
logic rst;
logic rx;

logic [7:0] data_out;
logic done;

uart uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .data_out(data_out),
    .done(done)
);


// clock 10ns
always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, uart_tb);

    clk = 0;
    rst = 1;
    rx  = 1; // idle UART = 1

    // reset
    #20;
    rst = 0;

    // =====================================
    // Send : 8'b10110010
    // UART sends LSB first
    // =====================================

    // start bit
    #10;
    rx = 0;

    // bit0 = 0
    #10;
    rx = 0;

    // bit1 = 1
    #10;
    rx = 1;

    // bit2 = 0
    #10;
    rx = 0;

    // bit3 = 0
    #10;
    rx = 0;

    // bit4 = 1
    #10;
    rx = 1;

    // bit5 = 1
    #10;
    rx = 1;

    // bit6 = 0
    #10;
    rx = 0;

    // bit7 = 1
    #10;
    rx = 1;

    // stop bit
    #10;
    rx = 1;

    // wait
    #50;

    $stop;
end

endmodule