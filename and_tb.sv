module and_tb;
logic a,b,y;
and_gate dut (.a(a), .b(b), .y(y));
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, and_tb);
    $display("a b | y");
    a=0; b=0; #10; $display("%b %b | %b", a, b, y);
    a=0; b=1; #10; $display("%b %b | %b", a, b, y);
    a=1; b=0; #10; $display("%b %b | %b", a, b, y);
    a=1; b=1; #10; $display("%b %b | %b", a, b, y);
    $finish;
  end
endmodule