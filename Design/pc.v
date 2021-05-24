`timescale 1ps/1ps
module PC (
    input clk,
    input rstn,
    input[31:0] next_pc,
    output reg [31:0]now_pc
    
);
initial begin
    now_pc=0;
end
always @(posedge clk or negedge rstn) 
begin
     now_pc=next_pc;
        
    
end
endmodule //pc