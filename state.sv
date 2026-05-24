module pc (
    input logic clk,
    input logic start_pc,
    output logic busy
);
    typedef enum logic { run, stop } state;
    state cur, nxt;
    always_ff @(posedge clk) begin
        cur <= nxt;
    end

    always_comb begin
        nxt = stop;
        case (cur)
            run: nxt = run;
            stop: if (start_pc) nxt = run;
                  else nxt = stop;
        endcase
    end
    assign busy = (cur == stop && start_pc);
endmodule