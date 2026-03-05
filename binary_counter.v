module binary_counter(
    input clk,
    inout [7:0] bus,
    input wire counter_enable,
    input wire counter_out,
    input wire counter_in,
    input wire clear,
    input wire reset,
    output reg [3:0] leds
    );
	 
    reg [3:0] counter;
	 reg [3:0] bus_latch;
	 reg is_counter_enabled;
	 reg counter_enable_prev;
	 
    initial begin
		  leds = 4'b0001;
        counter = 4'b0001;
		  bus_latch = 4'b0000;
		  is_counter_enabled = 1'b0;
		  counter_enable_prev = 1'b0;
    end
	 
    assign bus[7:4] = 4'bz;
	 assign bus[3:0] = bus_latch;
	 
	 always @(posedge clk)
    begin
        if (clear)
            bus_latch <= 4'b0000;
        else if (counter_out)
            bus_latch <= counter;
    end
	 
    always @(posedge clk)
    begin
        if (clear)
        begin
            is_counter_enabled <= 1'b0;
            counter_enable_prev <= 1'b0;
        end
        else
        begin
            counter_enable_prev <= counter_enable;
            if (counter_enable && !counter_enable_prev)
                is_counter_enabled <= ~is_counter_enabled;
        end
    end

    always @(posedge clk or posedge clear)
    begin
        if (clear)
        begin
            counter <= 4'b0000;
        end
        else if (counter_in)
        begin
            counter <= bus[3:0];
        end
        else if (is_counter_enabled)
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

