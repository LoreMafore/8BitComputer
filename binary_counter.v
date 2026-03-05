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

    localparam LOCKOUT_CYCLES = 27'd50_000_000;
	 
    reg [3:0]  counter;
    reg [3:0]  bus_latch;
    reg        is_counter_enabled;
    reg        counter_enable_prev;
    reg        counter_out_prev;
	 reg        counter_in_prev;
    reg [26:0] enable_lockout_timer;
    reg        in_lockout;
    initial begin
        leds                 = 4'b0000;
        counter              = 4'b0000;
        bus_latch            = 4'b0000;
        is_counter_enabled   = 1'b0;
        counter_enable_prev  = 1'b0;
        counter_out_prev     = 1'b0;
		  counter_in_prev      = 1'b0;
        enable_lockout_timer = 27'd0;
        in_lockout           = 1'b0;
    end

    assign bus[7:4] = 4'bz;
    assign bus[3:0] = bus_latch;

    always @(posedge clk or posedge clear) begin
        if (clear) begin
            counter              <= 4'b0000;
            bus_latch            <= 4'b0000;
            is_counter_enabled   <= 1'b0;
            counter_enable_prev  <= 1'b0;
            counter_out_prev     <= 1'b0;
				counter_in_prev      <= 1'b0;
            in_lockout           <= 1'b0;
            enable_lockout_timer <= 27'd0;
        end else begin

            counter_enable_prev <= counter_enable;
            counter_out_prev    <= counter_out;
				counter_in_prev     <= counter_in;

            if (counter_out && !counter_out_prev)
                bus_latch <= counter;

            if (in_lockout) begin
                if (enable_lockout_timer >= LOCKOUT_CYCLES - 1'b1) begin
                    enable_lockout_timer <= 27'd0;
                    in_lockout           <= 1'b0;
                end else begin
                    enable_lockout_timer <= enable_lockout_timer + 1'b1;
                end
            end else begin
                if (counter_enable && !counter_enable_prev) begin
                    is_counter_enabled   <= ~is_counter_enabled;
                    in_lockout           <= 1'b1;
                    enable_lockout_timer <= 27'd0;
                end
            end

				if (counter_in && !counter_in_prev) begin
                counter <= bus[3:0];
            end else if (is_counter_enabled) begin
                counter <= counter + 1'b1;
            end
        end
    end

    always @(*) begin
        leds = counter;
    end

endmodule

