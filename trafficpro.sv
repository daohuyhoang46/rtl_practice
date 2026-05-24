module traffic (
    input  logic clk,
    input  logic rst,
    input  logic pedestrian_btn,
    output logic red,
    output logic yellow,
    output logic green
);
    logic ped_red;
    logic [3:0] timer = 0;
    logic trans;
    typedef enum logic [1:0] {
        RED,
        GREEN,
        YELLOW
    } state_t;
    state_t cur,nxt;
    logic prv;
    logic ped = 0;
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            prv <= 0;
        else
            prv <= pedestrian_btn;
    end
    assign ped_red = ~prv & pedestrian_btn;
    always_ff @( posedge clk ) begin
        if (trans | ped_red) timer <= 0;
        else
        timer <= timer + 1;
        end
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            cur <= GREEN;
        end else begin
            cur <= nxt;
        end
    end
    always_comb begin
        if (ped_red)
        ped = ~ped;
        if ( timer == 0 ) trans = 0;
        case (cur)
        RED: begin 
            if ( timer == 4) begin nxt = GREEN; trans = 1; ped = 0; end
            else nxt = RED; 
        end
        GREEN: begin
            if (ped) begin
                if (timer == 4) begin nxt = YELLOW; trans = 1; end
                else nxt = GREEN;
            end
            else nxt = GREEN;
        end
        YELLOW: begin
        if (timer == 2) begin nxt = RED; trans = 1; end
        else nxt = YELLOW;
        end
        endcase
    end
    assign red = (cur == RED);
    assign yellow = (cur == YELLOW);
    assign green = (cur == GREEN);
endmodule