module button (
    input logic clk,
    input logic rst,
    input logic in,
    output logic pulse,
    output logic out
);
logic prev;
always_ff @(posedge clk or posedge rst) begin
    if (rst)
        prev <= 0;
    else
        prev <= in;
end
assign pulse = ~prev & in;
typedef enum logic [1:0] {
    IDLE,
    TOGGLE
} state_t;
state_t cur_1, nxt_1;
always_ff @(posedge clk or posedge rst) begin
    if (rst)
        cur_1 <= IDLE;
    else
        cur_1 <= nxt_1;
end
always_comb begin
    case (cur_1)
        IDLE: begin
            if (pulse)
                nxt_1 = TOGGLE;
            else
                nxt_1 = IDLE;
        end
        TOGGLE: begin
            if (pulse)
                nxt_1 = IDLE;
            else
                nxt_1 = TOGGLE;
        end
    endcase
end
assign out = (cur_1 == TOGGLE);
endmodule