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
    reg [3:0] counter = 4'b0000;
    reg [3:0] out_latch = 4'b0000; 
    reg is_enabled = 1'b0;
    reg is_outputting = 1'b0;      
    reg out_flag, in_flag, en_flag;
    reg out_ack, in_ack, en_ack;

    always @(posedge counter_out or posedge out_ack) 
        if (out_ack) out_flag <= 1'b0; else out_flag <= 1'b1;

    always @(posedge counter_in or posedge in_ack) 
        if (in_ack) in_flag <= 1'b0; else in_flag <= 1'b1;

    always @(posedge counter_enable or posedge en_ack) 
        if (en_ack) en_flag <= 1'b0; else en_flag <= 1'b1;

    always @(posedge clk or posedge clear) begin
        if (clear) begin
            counter      <= 4'b0000;
            out_latch    <= 4'b0000;
            is_enabled   <= 1'b0;
            is_outputting <= 1'b0;
            {out_ack, in_ack, en_ack} <= 3'b000;
        end else begin
            {out_ack, in_ack, en_ack} <= 3'b000;

            if (en_flag) begin
                is_enabled <= ~is_enabled;
                en_ack     <= 1'b1;
            end

            if (in_flag) begin
                counter <= bus[3:0];
                in_ack  <= 1'b1;
            end else if (is_enabled) begin
                counter <= counter + 1'b1;
            end
            
            if (out_flag) begin
                is_outputting <= ~is_outputting; 
                out_latch     <= counter;       
                out_ack       <= 1'b1;
            end
        end
    end

    assign bus = (is_outputting) ? {4'b0000, out_latch} : 8'bzzzzzzzz;
    
    always @(*) leds = counter;

endmodule
