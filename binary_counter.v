module binary_counter(
    input clk,
    inout [7:0] bus,
    input counter_enable,
    input counter_out,
    input counter_in,
    input clear,
    input reset,
    output[3:0] leds,
    );

    
    reg [3:0] counter = 4'b1111;
    assign bus = 8'bz;
   
    always@((posedge clk && counter_enable == 1) or posedge reset or posedge clear ) begin : main_block

        if (reset or clear)
        begin
            counter = 4'b1111;
            diable main_block; 
        end
        
        counter <= counter + 1;
    end

    always@((posedge clk && counter_in) or posedge counter_out) begin: bus_ops
       
        if(counter_out)
        begin
            bus[0] <= counter[0]
            bus[1] <= counter[1]
            bus[3] <= counter[3]
            bus[4] <= counter[4]
        end
        
        else
        begin
            bus[0] <= counter[0]
            bus[1] <= counter[1]
            bus[3] <= counter[3]
            bus[4] <= counter[4]
        end

endmodule
