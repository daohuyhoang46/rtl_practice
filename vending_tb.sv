`timescale 1ns/1ps

module vending_tb;

logic clk;
logic rst;

logic coin5;
logic coin10;

logic dispense;

vending uut (
    .clk(clk),
    .rst(rst),
    .coin5(coin5),
    .coin10(coin10),
    .dispense(dispense)
);


// clock 10ns
always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, vending_tb);

    clk = 0;
    rst = 1;

    coin5  = 0;
    coin10 = 0;

    // reset
    #20;
    rst = 0;

    // =========================
    // CASE 1 : 5 + 10
    // =========================

    #10;
    coin5 = 1;

    #10;
    coin5 = 0;

    #20;
    coin10 = 1;

    #10;
    coin10 = 0;

    // chờ xem dispense
    #30;

    // =========================
    // CASE 2 : 10 + 5
    // =========================

    coin10 = 1;

    #10;
    coin10 = 0;

    #20;
    coin5 = 1;

    #10;
    coin5 = 0;

    #30;

    // =========================
    // CASE 3 : 10 + 10
    // =========================

    coin10 = 1;

    #10;
    coin10 = 0;

    #20;
    coin10 = 1;

    #10;
    coin10 = 0;

    #30;

    $stop;
end

endmodule