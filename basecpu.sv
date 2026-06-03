module alu(
    input logic clk,C_in,EN,
    input logic [3:0] A,B,opcode,
    output logic [3:0] r
);
logic [4:0] op_cin;
assign op_cin = {opcode,C_in};
always @(posedge clk) begin
    if (EN) begin
        case (op_cin)
        5'b00000: r <= A;
        5'b00001: r <= A + 1;
        5'b00010: r <= A + B;
        5'b00011: r <= A + B + 1;
        5'b00100: r <= A + ~B;
        5'b00101: r <= A + ~B + 1;
        5'b00110: r <= A - 1;
        5'b00111: r <= A;
        5'b01000: r <= A & B;
        5'b01010: r <= A | B;
        5'b01100: r <= A ^ B;
        5'b01110: r <= ~A;
        5'b10000: r <= 0;
        default: r <= 4'bx;
        endcase
    end
end
endmodule
module MEM (
    input logic clk,EN,
    input logic [2:0] addr,
    output logic [12:0] data_frame
);
always @(posedge clk) begin
    if (EN) begin 
        case (addr)
        3'b000: data_frame <= 13'b0000_0001_0_0001;
        3'b001: data_frame <= 13'b0100_0100_0_0001;
        3'b010: data_frame <= 13'b0110_0110_0_1000;
        3'b011: data_frame <= 13'b0001_0010_0_0001;
        3'b100: data_frame <= 13'b1111_0000_0_1000;
        3'b101: data_frame <= 13'b0111_0001_1_0010;
        endcase
end
    end
endmodule
module controlunit (
    input logic clk,rst,end_s,
    input logic [12:0] data_frame,
    output logic [3:0] opcode,A_in,B_in,
    output logic C_in,ALU_en,MEM_en,
    output logic [2:0] addr
);
typedef enum logic [1:0] {init,fetch,excute,done} state_t;
state_t nxt,cur;
logic [2:0] addr_i = 0;
logic run = 1;
always_ff @(posedge clk or posedge rst) begin
    if (rst || ~run)
    begin 
        cur <= init;
        addr <= 0;
    end
    else begin
        cur <= nxt;
        addr <= addr_i;
    end
end
always_comb begin
    addr_i = addr;
    if (end_s)  run = 0;
    nxt  = init;
    ALU_en = 0; MEM_en = 0;
    A_in = data_frame[12:9];
    B_in = data_frame[8:5];
    C_in = data_frame[4];
    opcode = data_frame[3:0];
    case (cur)
    init: 
    begin 
        MEM_en = 0; ALU_en = 0;
        nxt = fetch;
    end
    fetch:
    begin 
        MEM_en = 1; ALU_en = 0;
        nxt = excute;
    end
    excute:
    begin 
        MEM_en = 0; ALU_en = 1;
        nxt = done;
    end
    done:
    begin
        MEM_en = 0; ALU_en = 0;
        if ( addr_i == 6 )
            nxt = init;
        else begin
            addr_i = addr_i + 1;
            nxt = fetch;
        end
    end
    endcase
end
endmodule
module cpu (
    input logic clk,rst,end_s,
    output logic [3:0] Y, A_in, B_in, opcode,
    output logic C_in
);
logic ALU_en, MEM_en;
logic [2:0] addr;
logic [12:0] data_frame;
wire c;
controlunit CU (
    .clk(clk),
    .rst(rst),
    .end_s(end_s),
    .data_frame(data_frame),
    .opcode(opcode),
    .A_in(A_in),
    .B_in(B_in),
    .C_in(C_in),
    .ALU_en(ALU_en),
    .MEM_en(MEM_en),
    .addr(addr)
);
alu ALU (
    .clk(clk),
    .C_in(C_in),
    .EN(ALU_en),
    .A(A_in),
    .B(B_in),
    .opcode(opcode),
    .r(Y)
);
MEM MEM (
    .clk(clk),
    .EN(MEM_en),
    .addr(addr),
    .data_frame(data_frame)
);
endmodule