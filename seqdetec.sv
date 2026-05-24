module seq_detec (
    input logic clk,
    input logic rst,
    input logic in,
    output logic out
);
typedef enum logic [3:0] {idle,b1,b10,b101} state_1;
state_1 cur, nxt;
always_ff @(posedge clk or posedge rst) begin
    if (rst)
        cur <= idle;
    else
        cur <= nxt;
end
always_comb begin
    nxt = cur;
    case (cur)
        idle: begin
            if (in)
                nxt = b1;
            else
                nxt = idle;
        end
        b1: begin
            if (~in)
                nxt = b10;
            else
                nxt = b1;
        end
        b10: begin
            if (in)
                nxt = b101;
            else
                nxt = idle;
        end
        b101: begin
            if (in)
                nxt = b1;
            else
                nxt = idle;
        end
    endcase
end
assign out = (cur == b101) && in;
endmodule