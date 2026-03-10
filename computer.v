module computer(
    input [3:0] pc_drive,
    input CLK,
    input RESET,
    inout [7:0] eight_bit_bus,
    output [3:0] LEDS 
);

//Control Wires 
wire ENABLE_COUNTER;
wire COUNTER_OUT;
wire COUNTER_IN;
wire COUNTER_CLEAR;

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


//Output Register


//Instruction_Controls


endmodule
