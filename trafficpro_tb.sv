`timescale 1ns/1ps

module traffic_tb;

logic clk;
logic rst;
logic pedestrian_btn;

logic red;
logic yellow;
logic green;

traffic uut (
    .clk(clk),
    .rst(rst),
    .pedestrian_btn(pedestrian_btn),
    .red(red),
    .yellow(yellow),
    .green(green)
);


// clock 10ns
always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, traffic_tb);

    clk = 0;
    rst = 1;
    pedestrian_btn = 0;

    // reset
    #20;
    rst = 0;

    // =========================
    // CASE 1:
    // không bấm nút
    // đèn phải giữ GREEN mãi
    // =========================
    #100;

    // =========================
    // CASE 2:
    // bấm nút ngắn
    // FSM phải nhớ yêu cầu
    // =========================
    pedestrian_btn = 1;
    #10;
    pedestrian_btn = 0;

    // chờ FSM chạy
    #200;

    // =========================
    // CASE 3:
    // giữ nút lâu
    // =========================
    pedestrian_btn = 1;
    #80;
    pedestrian_btn = 0;

    #200;

    $stop;
end

endmodule