module vending (
    input logic clk,
    input logic rst,
    input logic coin5,
    input logic coin10,
    output logic dispense
);
typedef enum logic [1:0] { idle, coin_5, coin_10, dispense_s } state_t;
state_t cur,nxt;
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
            if (coin5)
                nxt = coin_5;
            else if (coin10)
                nxt = coin_10;
        end
        coin_5: begin
            if (coin5)
                nxt = coin_10;
            else if (coin10) begin
                nxt = dispense_s;
            end
        end
        coin_10: begin
            if (coin5 || coin10) begin
                nxt = dispense_s;
            end
        end
        dispense_s: nxt = idle;
    endcase 
end
assign dispense = (cur == dispense_s);
endmodule