module alu(
    input clk,
    inout wire [7:0] bus,
    input wire clear,
  //  input wire reset, 
    input wire alu_flag,
    input wire a_out_flag,
    input wire a_in_flag,
    input wire b_out_flag,
    input wire b_in_flag,
    input wire b_sub
);

reg [7:0] reg_a;
reg [7:0] reg_b;
reg [7:0] alu_value;
reg [7:0] bus_latch;
reg a_in, b_in, a_ack, b_ack, alu_ack;

initial begin
    reg_a     = 8'b00001100;
    reg_b     = 8'b00100000;
    alu_value = 8'b00000000;
end

always @(*) begin
    if (b_sub == 1'b0)
        alu_value = reg_a + reg_b;
    else
        alu_value = reg_a - reg_b;
end

always @(*) begin
    if (a_out_flag)
        bus_latch = reg_a;
    else if (b_out_flag)
        bus_latch = reg_b;
    else if (alu_flag)
        bus_latch = 8'b00000001;
end

assign bus = (a_out_flag || b_out_flag || alu_flag) ? bus_latch : 8'bz;

always @(posedge a_in_flag or posedge a_ack) 
    if(a_ack) a_in <= 1'b0; else a_in <= 1'b1;

always @(posedge b_in_flag or posedge b_ack) 
    if(b_ack) b_in <= 1'b0; else b_in <= 1'b1;

always @(posedge clk or posedge clear or posedge reset) begin
    if(clear) begin
        reg_a <= 8'b00000000;
        a_ack <= 1'b0;
    end
  //  else if(reset) begin
    //    reg_b <= 8'b00000000;
      //  a_ack <= 1'b0;
    //end
    else begin
        {a_ack, b_ack, alu_ack} <= 3'b000;
        if (a_in) begin
            reg_a <= bus;
            a_ack <= 1'b1;
        end
        if (b_in) begin
            reg_b <= bus;
            b_ack <= 1'b1;
        end
    end
end

endmodule