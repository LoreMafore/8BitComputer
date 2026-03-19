module alu(
    input clk,
    inout reg [7:0] bus,
    output reg [7:0] alu_value,
    input wire clear,
    input wire reset, 
    input wire alu_flag,
    input wire a_out_flag,
    input wire a_in_flag,
    input wire b_out_flag,
    input wire b_in_flag,
    input wire b_sub
);


reg a_in, b_in, alu_in;
reg a_ack, b_ack, alu_ack;
reg [7:0] reg_a;
reg [7:0] reg_b;

initial begin
    reg_a     = 8'b00001100;
    reg_b     = 8'b00100000;
    alu_value = 8'b00000000;
end


always @(*) begin
    if (b_sub == 0 )begin
        alu_value <= reg_a + reg_b;
    end
    
    else begin
        alu_value <= reg_a - reg_b;
    end
end


always @(posedge a_in_flag or posedge a_ack) 
    if(a_ack) a_in <= 1'b0; else a_in <= 1'b1;

always @(posedge b_in_flag or posedge b_ack) 
    if(b_ack) b_in <= 1'b0; else b_in <= 1'b1;

always @(posedge a_out_flag or posedge b_out_flag or alu_flag)begin
    if(a_out_flag) begin 
        bus <= reg_a;
    end 
    
    if(b_out_flag) begin 
        bus <= reg_b;
    end 

    if(alu_flag) begin 
        bus <= alu_value;
    end
end

always @(posedge clk or posedge clear or posedge reset)
    if(clear) begin
        reg_a <= 8'b00000000;
        a_ack <= 1'b0;
    end
    
    else if(reset) begin
        reg_b <= 8'b00000000;
        a_ack <= 1'b0;
    end

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

endmodule
