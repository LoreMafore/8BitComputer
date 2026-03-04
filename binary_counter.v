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
	 reg [3:0] bus_latch;
	 
    initial begin
		  leds = 4'b0001;
        counter = 4'b0001;
		  bus_latch = 4'b0000;
    end
	 
    assign bus[7:4] = 4'bz;
	 assign bus[3:0] = bus_latch;
	 
	 always @(posedge clk or posedge reset)
    begin
        if (reset)
            bus_latch <= 4'b0000;
        else if (counter_out)
            bus_latch <= counter;
    end

    always @(posedge clk or posedge reset)
    begin
        if (reset)
        begin
            counter <= 4'b1001; 
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

