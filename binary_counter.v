module binary_counter(
    input clk,
    inout [7:0] bus,
    input wire counter_enable,
    input wire counter_out,
    input wire counter_in,
    input wire clear,
    input reset,
    output reg [3:0] leds
    );
    
    reg [3:0] counter;
    initial begin
		  leds = 4'b0001;
        counter = 4'b0001;
    end
	 
    // Tri-state buffer for the bus
    assign bus = counter_out ? {4'b0000, counter} : 8'bz;

    // Sequential logic: Only include the clock and async reset/clear
    always @(posedge clk or posedge reset or posedge clear)
    begin
        if (reset)
        begin
            counter <= 4'b1001; // Reset to 0
        end
        else if (clear)
        begin
            counter <= 4'b0000;
        end
        else if (counter_in)
        begin
            counter <= bus[3:0];
        end
        else if (counter_enable)
        begin
            counter <= counter + 1'b1;
        end
    end

    // Continuous update for LEDs
    always @(*)
    begin 
        leds = counter;
    end

endmodule

