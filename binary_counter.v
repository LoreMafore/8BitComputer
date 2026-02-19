module binary_counter(
	inout [7:0] bus,
    input CLK,
    input counterEnable,
    input counterOut,
    input counterIn,
    input CLEAR,
    input RESET,
    output[3:0] led,
	);

    reg [25:0] counter
	assign bus = 8'bz;
	
endmodule
