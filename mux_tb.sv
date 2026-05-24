module mux_tb;
  logic a, b, c, d, y;
  logic [1:0] s;
  mux dut (.a(a), .b(b), .s(s), .y(y), .c(c), .d(d));
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, mux_tb);
    a = 0; b = 1; c = 1; d = 0;
    $display("s | y");
    for ( int i = 0; i < 4; i++) begin 
        s = i; #10;
        $display("%b | %b", s,y);
    end
    $finish;
  end
endmodule