module fifo (
    input  logic       clk,
    input  logic       rst,

    input  logic       wr_en,
    input  logic [7:0] wr_data,

    input  logic       rd_en,
    output logic [7:0] rd_data,

    output logic       full,
    output logic       empty
);
logic [7:0] mem [0:7];
logic [2:0] wr_addr = 0;
logic [2:0] rd_addr = 0;
logic [2:0] cnt = 0;
assign empty = (cnt == 0);
assign full = (cnt == 8);
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_addr <= 0;
        rd_addr <= 0;
        cnt <= 0;
    end
    else begin 
        case ({wr_en && ~full, rd_en && ~empty})
        2'b 10 : cnt <= cnt + 1;
        2'b 01 : cnt <= cnt - 1;
        2'b 11 : cnt <= cnt;
        endcase
        if (wr_en && ~full) begin
            mem[wr_addr] <= wr_data;
            wr_addr <= wr_addr + 1;
        end
        if (rd_en && ~empty) begin
            rd_data <= mem[rd_addr];
            rd_addr <= rd_addr + 1;
        end
    end
end
endmodule