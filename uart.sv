module uart (
    input logic clk,
    input logic rst,
    input logic rx,
    output logic [7:0] data_out,
    output logic done
);
typedef enum logic [3:0] { idle, start, data, stop, done_s } state;
state cur, nxt;
logic [2:0] bit_cnt = 0;
logic data_d =0;
always_ff @(posedge clk or posedge rst) begin
    if (rst)
        cur <= idle;
    else
        cur <= nxt;
end
always_ff @(posedge clk) begin
    if (cur == data)
    begin
        if (~data_d)
        begin
        bit_cnt <= bit_cnt + 1;
        data_out <= {rx,data_out[7:1]};
        end
        else       
        bit_cnt <= 0;
    end
end
always_ff @(posedge clk) begin
    if ( bit_cnt == 7)
        data_d <= 1;
    else
        data_d <= 0;
end
always_comb begin
    case(cur)
    idle: begin 
        if (~rx)
        nxt = start;
        else
        nxt = idle;
    end
    start: begin
        nxt = data;
    end
    data: begin
        if (bit_cnt == 7)
        nxt = stop;
    end
    stop : begin
        if (rx == 1)
        nxt = done_s;
        else
        nxt = idle;
    end
    done_s: nxt = idle;
    endcase
end
assign done = (cur == done_s);
endmodule