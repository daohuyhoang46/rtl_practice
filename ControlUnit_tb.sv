`timescale 1ns/1ps

module controlunit_tb;

logic clk;
logic rst;
logic [12:0] data_frame;
logic [3:0] opcode, A_in, B_in;
logic C_in, ALU_en, MEM_en;
logic [2:0] addr;

controlunit uut (
    .clk(clk),
    .rst(rst),
    .data_frame(data_frame),
    .opcode(opcode),
    .A_in(A_in),
    .B_in(B_in),
    .C_in(C_in),
    .ALU_en(ALU_en),
    .MEM_en(MEM_en),
    .addr(addr)
);

// clock
always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, controlunit_tb);

    clk = 0;
    rst = 1;
    data_frame = 13'b1010_1100_1_0010;  // opcode=0, A_in=10, B_in=11, C_in=0, x=01

    // Reset
    #10 rst = 0;

    // init state
    #10;

    // fetch state
    #10;

    // execute state
    #10;

    // done state
    #10;

    // Loop back to fetch
    #10;

    // Change data_frame
    data_frame = 13'b0101_0011_0110_1;  // different values
    #20;

    // Test reset again
    #10 rst = 1;
    #10 rst = 0;

    #30 $stop;
end

endmodule
