`timescale 1ns/1ps

module basecpu_tb;

logic clk;
logic rst;
logic end_s;
logic [3:0] Y, A_in, B_in, opcode;
logic C_in;

cpu uut (
    .clk(clk),
    .rst(rst),
    .end_s(end_s),
    .Y(Y),
    .A_in(A_in),
    .B_in(B_in),
    .opcode(opcode),
    .C_in(C_in)
);

// clock
always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;
    end_s = 0;

    // Reset
    #10 rst = 0;

    // init state
    #10;

    // fetch state - addr 0
    #10;

    // execute state
    #10;

    // done state
    #10;

    // fetch state - addr 1
    #10;

    // execute state
    #10;

    // done state
    #10;

    // fetch state - addr 2
    #10;

    // execute state
    #10;

    // done state
    #10;

    // fetch state - addr 3
    #10;

    // execute state
    #10;

    // done state
    #10;

    // fetch state - addr 4
    #10;

    // execute state
    #10;

    // done state
    #10;

    // fetch state - addr 5
    #10;

    // execute state
    #10;

    // done state
    #10;
    // fetch state - addr 6
    #10;

    // execute state
    #10;

    // done state
    #10;


    // Set end_s to shutdown
    end_s = 1;
    #20;

    $stop;
end

endmodule
