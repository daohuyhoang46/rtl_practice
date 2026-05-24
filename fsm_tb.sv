`timescale 1ns/1ps

module fsm_tb;

logic clk;
logic rst;
logic red;
logic yel;
logic green;


light uut (
    .clk(clk),
    .rst(rst),
    .red(red),
    .yel(yel),
    .green(green)
);

// clock
always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    #10 rst = 0;
  #200 $stop;
end

endmodule