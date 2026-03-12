module alu_a_b(
    input clk,
    inout [7:0] bus,
	input wire clear,
    input wire reset, 
	inout [7:0] reg_a,
	inout [7:0] reg_b,
    output [7:0] alu_value,
    input wire alu_flag,
    input wire a_out_flag,
    input wire a_in_flag,
    input wire b_out_flag,
    input wire b_in_flag,
    input wire b_sub
);


reg a_in, b_in, alu_in;
reg a_ack, b_ack, alu_ack;


initial begin
    reg_a = 8'b00001100;
    reg_b = 8'b00100000;
end


always @(*) begin
    
    if (b_sub == 0 )begin
        alu_value <= reg_a + reb_b;
    end
    
    else begin
        alu_value <= reg_a - reg_b;
    end
end


always @(posedge a_in_flag or posedge a_ack) 
    if(a_ack) a_out <= 1'b0; else a_out <= 1'b1;

always @(posedge b_in_flag or posedge b_ack) 
    if(b_ack) b_out <= 1'b0; else b_out <= 1'b1;

always @(posedge a_out_flag)
    bus <= reg_a;

always @(posedge b_out_flag)
    bus <= reg_b;

always @(posedge alu_flag)
    bus <= alu_value;

always @(posedge clk or posedge clear or posedge reset)
    if(clear) begin
        reg_a <= 8'b00000000;
    end
    
    else if(reset) begin
        reg_b <= 8'b00000000;
    end

    else begin
        {a_ack, b_ack, alu_ack} <= 3'b000;
        
        if (a_out_flag) begin
            
        end
    end


endmodule
