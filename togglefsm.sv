module toggle (
    input logic clk,
    input logic rst,
    input logic pulse,
    output logic busy
);
typedef enum logic [1:0] {
    IDLE,
    TOGGLE
} state_t;
state_t cur, nxt;
always_ff @(posedge clk or posedge rst) begin
    if (rst)
        cur <= IDLE;
    else
        cur <= nxt;
end
always_comb begin
    case (cur)
        IDLE: begin
            if (pulse)
                nxt = TOGGLE;
            else
                nxt = IDLE;
        end
        TOGGLE: begin
            if (pulse)
                nxt = IDLE;
            else
                nxt = TOGGLE;
        end
    endcase
end
assign busy = (cur == TOGGLE);
endmodule