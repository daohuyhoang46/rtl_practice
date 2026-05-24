module xor3 (
  input  logic a, b, c,
  output logic y
);
  assign y = a ^ b ^ c;
endmodule
module and_gate (
    input logic a,b,
    output logic y
);
assign y = a&b;
endmodule
module or_gate (
    input logic a,b,
    output logic y
);
assign y = a|b;
endmodule
module or_3 (
    input logic a,b,c,
    output logic y
);
assign y = a|b|c;
endmodule
module mux_2 (
    input logic sel,
    input logic a,
    input logic b,
    output logic y
);
always_comb begin
    case (sel)
    0:y=a;
    1:y=b;
    default: y = 0;
    endcase
end
endmodule
module ainv (
    input logic a,inv,
    output logic y
);
mux_2 u0 (.sel(inv), .a(a), .b(~a), .y(y));
endmodule
module binv (
    input logic a,inv,
    output logic y
);
mux_2 u0 (.sel(inv), .a(a), .b(~a), .y(y));
endmodule
module bocong (
    input logic a,b,cin,
    output logic s,cout
);
logic w0,w1,w2;
xor3 u4 (.a(cin), .b(a), .c(b), .y(s));
and_gate u0 (.a(a), .b(b), .y(w0));
and_gate u1 (.a(a), .b(cin), .y(w1));
and_gate u2 (.a(cin), .b(b), .y(w2));
or_3 u3 (.a(w0), .b(w1), .c(w2), .y(cout));
endmodule
module mux (
    input logic [1:0] s,
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic y
);
always_comb begin
    case (s)
    0:y=a;
    1:y=b;
    2:y=c;
    3:y=d;
    default: y = 0;
    endcase
end
endmodule
module alu_1_bit (
    input logic a,b,cin,inva,invb,
    input logic [1:0] s,
    output logic r,cout
);
logic w0,w1,w2;
logic inveda,invedb;
ainv u0 (.a(a),.inv(inva), .y(inveda));
binv u5 (.a(b),.inv(invb), .y(invedb));
and_gate u1 (.a(inveda),.b(invedb),.y(w0));
or_gate u2 (.a(inveda),.b(invedb),.y(w1));
bocong u3 (.a(inveda),.b(invedb),.cin(cin),.s(w2),.cout(cout));
mux u4 (.s(s), .a(w0), .b(w1), .c(w2), .d(0), .y(r));
endmodule
module alu4bit (
    input logic a0,b0,a1,b1,a2,b2,a3,b3,cin,inva,invb,
    input logic [1:0] s,
    output logic r0,r1,r2,r3,cout
);
logic c1,c2,c3;
alu_1_bit u0 (.a(a0), .b(b0), .inva(inva), .invb(invb), .cin(cin), .s(s), .r(r0), .cout(c1));
alu_1_bit u1 (.a(a1), .b(b1), .inva(inva), .invb(invb), .cin(c1), .s(s), .r(r1), .cout(c2));
alu_1_bit u2 (.a(a2), .b(b2), .inva(inva), .invb(invb), .cin(c2), .s(s), .r(r2), .cout(c3));
alu_1_bit u3 (.a(a3), .b(b3), .inva(inva), .invb(invb), .cin(c3), .s(s), .r(r3), .cout(cout));
endmodule