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
module chain (
    input logic a,b,c,
    output logic y
);
logic w;
and_gate u1 (.a(a), .b(b), .y(w));
or_gate u2 (.a(c), .b(w), .y(y));
endmodule