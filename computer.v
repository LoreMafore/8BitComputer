module computer(
    input [3:0] pc_drive,
    input CLK,
    input RESET,
    inout [7:0] eight_bit_bus,
    output [3:0] LEDS, 
    output [5:0] ALU_WIRES
);

//Control Wires 
wire ENABLE_COUNTER;
wire COUNTER_OUT;
wire COUNTER_IN;
wire COUNTER_CLEAR;

assign COUNTER_OUT    = ~pc_drive[1];
assign COUNTER_IN     = ~pc_drive[2];
assign COUNTER_CLEAR  = ~pc_drive[3];


wire ALU_FLAG;
wire A_IN_FLAG;
wire A_OUT_FLAG;
wire B_IN_FLAG;
wire B_OUT_FLAG;
wire B_SUB;

assign ALU_FLAG   = ALU_WIRES[0];
assign A_IN_FLAG  = ALU_WIRES[1];
assign A_OUT_FLAG = ALU_WIRES[2];
assign B_IN_FLAG  = ALU_WIRES[3];
assign B_OUT_FLAG = ALU_WIRES[4];
assign B_SUB      = ALU_WIRES[5];

//Program Counter
binary_counter counter(
    .clk(CLK),
    .bus(eight_bit_bus),
    .counter_enable(ENABLE_COUNTER),
    .counter_out(COUNTER_OUT),
    .counter_in(COUNTER_IN),
    .clear(COUNTER_CLEAR),
    .reset(RESET),
    .leds(LEDS)
);


//A_B_ALU
alu a_b_alu(
    .clk(CLK),
    .bus(eight_bit_bus),
    .clear(COUNTER_CLEAR),
    .reset(RESET),
    .alu_flag(ALU_FLAG),
    .a_in_flag(A_IN_FLAG),
    .a_out_flag(A_OUT_FLAG),
    .b_in_flag(B_IN_FLAG),
    .b_out_flag(B_OUT_FLAG),
    .b_sub(B_SUB)
);


//Output Register


//Instruction_Controls


endmodule
