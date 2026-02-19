module computer(
    //Base
	input clk,
	input reset,
	inout [7:0] 8_bit_bus,
	output [3:0] LED,
    wire Reset,

    //Program Counter
    input counter_enable,
    input counter_out,
    input counter_in,
    input clear,


    //A_B_ALU


    //Output Register


    //Instruction_Controls

	);

binary_counter counter(
	.bus(8_bit_bus)
    .CLK(clk)
    .counterEnable(counter_enable)
    .counterOut(counter_out)
    .counterIn(counter_in)
	);
	
endmodule
