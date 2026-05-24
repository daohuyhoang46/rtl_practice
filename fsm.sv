module light (
    input logic clk,
    input logic rst,
    output logic red,
    output logic yel,
    output logic green
);
typedef enum logic [1:0] { s_red, s_yel, s_green } state;
state cur,nxt;
logic [7:0] timer;
logic timer_done;
always_ff @(posedge clk or posedge rst ) begin
    if (rst) begin
        cur <= s_red;
        timer <= 0;
    end
    else 
    begin
    cur <= nxt;
    if (timer_done) timer <= 0;
    else timer <= timer + 1;
    end
end
always_comb begin 
    timer_done = 0;
    case (cur)
    s_red:  if ( timer == 4)
    begin 
        nxt = s_green ;
        timer_done = 1;
    end
        else nxt = s_red;
    s_green: if ( timer == 3) 
    begin
        nxt = s_yel;
        timer_done = 1;
    end
    else 
    begin
        nxt = s_green;
        timer_done = 0;
    end
    s_yel: if ( timer == 2) 
    begin
        nxt = s_red;
        timer_done = 1;
    end
    else nxt = s_yel;
    endcase
end
assign red = (cur == s_red);
assign yel = (cur == s_yel);
assign green = (cur == s_green);
endmodule