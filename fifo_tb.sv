`timescale 1ns/1ps

module fifo_tb;

logic clk;
logic rst;

logic wr_en;
logic [7:0] wr_data;

logic rd_en;
logic [7:0] rd_data;

logic full;
logic empty;

fifo dut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .wr_data(wr_data),
    .rd_en(rd_en),
    .rd_data(rd_data),
    .full(full),
    .empty(empty)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    wr_data = 0;

    #20;
    rst = 0;

    //----------------------------------
    // Write 10
    //----------------------------------
    @(posedge clk);
    wr_en = 1;
    wr_data = 8'd10;

    //----------------------------------
    // Write 20
    //----------------------------------
    @(posedge clk);
    wr_data = 8'd20;

    //----------------------------------
    // Write 30
    //----------------------------------
    @(posedge clk);
    wr_data = 8'd30;

    //----------------------------------
    // Stop writing
    //----------------------------------
    @(posedge clk);
    wr_en = 0;

    //----------------------------------
    // Read 10
    //----------------------------------
    @(posedge clk);
    rd_en = 1;

    //----------------------------------
    // Read 20
    //----------------------------------
    @(posedge clk);

    //----------------------------------
    // Read 30
    //----------------------------------
    @(posedge clk);

    //----------------------------------
    // Stop reading
    //----------------------------------
    @(posedge clk);
    rd_en = 0;

    #20;
    $stop;
end

endmodule