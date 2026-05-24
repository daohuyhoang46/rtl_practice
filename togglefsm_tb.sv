// Testbench for toggle FSM
module togglefsm_tb;
    logic clk;
    logic rst;
    logic pulse;
    logic busy;

    // Instantiate the DUT
    toggle dut (
        .clk(clk),
        .rst(rst),
        .pulse(pulse),
        .busy(busy)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        $display("Starting toggle FSM testbench");
        rst = 1;
        pulse = 0;
        #12;
        rst = 0;
        #10;
        pulse = 0;
        #10;
        pulse = 0;
        #10;
        pulse = 1;
        #10;
        pulse = 0;
        #20;
        $stop;
    end
endmodule
