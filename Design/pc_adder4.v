`timescale 1ps/1ps
module pc_adder (
    input[31:0] now_pc,
    input [31:0] imm,
    input [31:0] readData1, 
    input Branch,
    input zero,
    input jalr,
    input jal,
    output reg[31:0] next_pc
);
initial begin
    next_pc=0;
end
always @(*) begin//mux is achieved here
    if(Branch&&zero&&~jalr)//beq
        next_pc=(now_pc+imm)&32'h0000FFFF;
    if(Branch&&zero&&jalr)//jalr
        next_pc=(readData1+imm)&32'h0000FFFF;//对jalr单独一种情况
    if(Branch&&zero&&jal)
        next_pc=(now_pc+imm)&32'h0000FFFF;
    if(~zero&&~jal&&~jalr) 
        next_pc=now_pc+4; 
        

end
endmodule //pc_adder4