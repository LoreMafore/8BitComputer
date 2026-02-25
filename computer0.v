module computer(
    //Base
    input clk,
    input reset,
    inout [7:0] eight_bit_bus,
    output [3:0] LED,
    wire Reset,

    //Program Counter


    //A_B_ALU


    //Output Register


    //Instruction_Controls

    );

binary_counter counter(
    .bus(eight_bit_bus)
    );
    
endmodule

