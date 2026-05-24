`timescale 1ns/1ps

module seqdetec_tb;

logic clk;
logic rst;
logic in;
logic out;

seq_detec uut (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
);

// 10ns clock
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    in  = 0;

    // reset
    repeat(2) @(posedge clk);
    rst = 0;

    // =========================
    // test: 101
    // should detect once
    // =========================

    @(posedge clk) in = 1;
    @(posedge clk) in = 0;
    @(posedge clk) in = 1;
    @(posedge clk) in = 1;

    // =========================
    // test: 101101
    // should detect twice
    // =========================

    @(posedge clk) in = 0;
    @(posedge clk) in = 1;
    @(posedge clk) in = 1;

    // =========================
    // random
    // =========================

    @(posedge clk) in = 0;
    @(posedge clk) in = 0;
    @(posedge clk) in = 1;

    #20;
    $stop;
end

endmodule