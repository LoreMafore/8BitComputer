module computer(
    //Base
	input clk,
	input reset,
	inout [7:0] 8_bit_bus,
	output [3:0] LED,
    wire Reset,

    //Program Counter


    //A_B_ALU


    //Output Register


    //Instruction_Controls

	);

binary_counter counter(
	.bus(8_bit_bus)
	);
	
endmodule
