`timescale 1ns/1ps

module register_tb;

logic clk;
logic rst;
logic d;
logic [7:0] q;

dff uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

// clock
always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 0;
    d = 0;

    #10 d = 1;
    #10 d = 0;
    #10 d = 1;
    #10 d = 0;
    #10 d = 1;
    #10 d = 0;
    #10 d = 1;
    #10 d = 0;
    #10 $stop;
end

endmodule