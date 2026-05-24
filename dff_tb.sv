`timescale 1ns/1ps

module dff_tb;

logic clk;
logic rst;
logic d;
logic q;

dff uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

// clock
always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, dff_tb);

    clk = 0;
    rst = 1;
    d = 0;

    #10 rst = 0;

    #10 d = 1;
    #10 d = 0;
    #10 d = 1;

    #10 rst = 1;
    #10 rst = 0;

    #20 $stop;
end

endmodule