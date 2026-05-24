module chain_tb;
  logic a, b, c, y;

  chain dut (.a(a), .b(b), .c(c), .y(y));

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, chain_tb);
    $display("a b c | y=(a&b)|c");
    a=0; b=0; c=0; #10; $display("%b %b %b |  %b", a, b, c, y);
    a=1; b=1; c=0; #10; $display("%b %b %b |  %b", a, b, c, y);
    a=0; b=0; c=1; #10; $display("%b %b %b |  %b", a, b, c, y);
    a=1; b=1; c=1; #10; $display("%b %b %b |  %b", a, b, c, y);
    $finish;
  end
endmodule