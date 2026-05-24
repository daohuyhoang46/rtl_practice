module edgedetector ( 
    input logic clk,
    input logic rst,
    input logic in,
    output logic out
);
logic cur, prv;
always_ff @(posedge clk or posedge rst) begin
    if (rst)
    prv <= 0;
    else
    prv <= in;
end
assign out = ~prv & in;
endmodule