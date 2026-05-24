module counter_tb;
  logic clk = 0, rst_n = 0;
  logic [3:0] count;

  counter dut (.clk(clk), .rst_n(rst_n), .count(count));

  // Clock 10ns period
  always #5 clk = ~clk;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, counter_tb);

    $display("Time\t rst_n\t count");
    $monitor("%0t\t %b\t %0d", $time, rst_n, count);

    #12 rst_n = 1;   // release reset sau 12ns
    #100 $finish;
  end
endmodule