`timescale 1ns/1ps

module edgedetector_tb;

logic clk;
logic rst;
logic in;
logic out;

edgedetector uut (
	.clk(clk),
	.rst(rst),
	.in(in),
	.out(out)
);

// clock
always #5 clk = ~clk;

initial begin

	clk = 0;
	rst = 0;
	in = 0;

	// Reset pulse
	#3 rst = 1;
	#7 rst = 0;

	// Test input sequence
	#10 in = 0;
	#10 in = 0;
	#10 in = 1;
	#10 in = 1;
	#10 in = 0;
	#10 in = 1;
	#10 in = 0;
	#10 $stop;
end

endmodule
