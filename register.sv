module dff (
    input  logic clk,
    input  logic rst,
    input  logic  d,
    output logic [7:0] q
);
always_ff @(posedge clk or posedge rst) begin   
    if (rst)
        q <= 0;
    else
        q <= {q[6:0],d};
end

endmodule