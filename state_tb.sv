`timescale 1ns/1ps

module state_tb;

logic clk;
logic start_pc;
logic busy;

pc uut (
    .clk(clk),
    .start_pc(start_pc),
    .busy(busy)
);

// clock
always #5 clk = ~clk;

initial begin
    clk = 0;
    start_pc = 0;
    #50 start_pc = 1;
    #5  start_pc = 0;
    #50 $stop;
end
endmodule
