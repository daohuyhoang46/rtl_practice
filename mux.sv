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