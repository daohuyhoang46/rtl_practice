module alu4bit_tb;
  logic a0,b0,a1,b1,a2,b2,a3,b3,cin,inva,invb;
  logic [1:0] s;
  logic r0,r1,r2,r3,cout;

  alu4bit dut (
    .a0(a0),.b0(b0),.a1(a1),.b1(b1),
    .a2(a2),.b2(b2),.a3(a3),.b3(b3),
    .cin(cin),.inva(inva),.invb(invb),
    .s(s),
    .r0(r0),.r1(r1),.r2(r2),.r3(r3),.cout(cout)
  );

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, alu4bit_tb);

    $display("op        | r3r2r1r0 cout");

    // 3 + 1 = 4 (0011 + 0001 = 0100)
    s=2; inva=0; invb=0; cin=0;
    a3=0;a2=0;a1=1;a0=1;
    b3=0;b2=0;b1=0;b0=1; #10;
    $display("3+1       | %b%b%b%b    %b", r3,r2,r1,r0,cout);

    // 3 - 1 = 2 (0011 - 0001 = 0010)
    s=2; inva=0; invb=1; cin=1;
    a3=0;a2=0;a1=1;a0=1;
    b3=0;b2=0;b1=0;b0=1; #10;
    $display("3-1       | %b%b%b%b    %b", r3,r2,r1,r0,cout);

    // AND: 1010 & 1100 = 1000
    s=0; inva=0; invb=0; cin=0;
    a3=1;a2=0;a1=1;a0=0;
    b3=1;b2=1;b1=0;b0=0; #10;
    $display("1010&1100 | %b%b%b%b    %b", r3,r2,r1,r0,cout);

    // OR: 1010 | 0101 = 1111
    s=1; inva=0; invb=0; cin=0;
    a3=1;a2=0;a1=1;a0=0;
    b3=0;b2=1;b1=0;b0=1; #10;
    $display("1010|0101 | %b%b%b%b    %b", r3,r2,r1,r0,cout);

    $finish;
  end
endmodule