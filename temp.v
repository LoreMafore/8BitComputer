 computer_base.v
module computer(
    input [3:0] pc_drive //TEMP FOR TESTING PC
);

// Control Wires
wire Enable_Counter;
wire Counter_Out;
wire Counter_In;
wire Counter_Clear;

// Temp Drivers
assign Enable_Counter = pc_drive[0];
assign Counter_Out = pc_drive[1];
assign Counter_In = pc_drive[2];
assign Counter_Clear = pc_drive[3];


// Program Counter
program_counter pc(
    .clock(clock), 
    .bus(bus), 
    .enable(Enable_Counter), 
    .c_out(Counter_Out), 
    .c_in(Counter_In), 
    .clear(Counter_Clear), 
    .reset(Reset), 
    .led(led)
);

endmodule
