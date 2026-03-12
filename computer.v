module computer(
    input [3:0] pc_drive,
    input CLK,
    input RESET,
    inout [7:0] eight_bit_bus,
    output [3:0] LEDS, 
	inout [7:0] REG_A,
	inout [7:0] REG_B
    output [7:0] ALU_VALUE, 
);

//Control Wires 
wire ENABLE_COUNTER;
wire COUNTER_OUT;
wire COUNTER_IN;
wire COUNTER_CLEAR;
wire ALU_FLAG;
wire A_IN_FLAG;
wire A_OUT_FLAG;
wire B_IN_FLAG;
wire B_OUT_FLAG;
wire B_SUB;

assign ENABLE_COUNTER = ~pc_drive[0];
assign COUNTER_OUT    = ~pc_drive[1];
assign COUNTER_IN     = ~pc_drive[2];
assign COUNTER_CLEAR  = ~pc_drive[3];


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
alu alu_a_b(
	.clk(CLK),
	.bus(eight_bit_bus),
	.clear(COUNTER_CLEAR),
	.reset(RESET),
	.reg_a(REG_A),
	.reg_b(REG_B),
    .alu_value(ALU_VALUE),
    .alu_flag(ALU_FLAG),
    .a_flag(A_IN_FLAG),
    .a_flag(A_OUT_FLAG),
    .b_flag(B_IN_FLAG),
    .b_flag(B_OUT_FLAG),
    .b_sub(B_SUB)
)


//Output Register


//Instruction_Controls


endmodule
