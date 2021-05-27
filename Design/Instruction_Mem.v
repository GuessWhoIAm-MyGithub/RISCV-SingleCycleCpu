`timescale 1ps/1ps
module Instruction_Mem 
(
    
    input [31:0]pc,
    output [31:0]instruction
);
parameter ins_addr=16;//2^16=64MB指令空间

reg[31:0] instructions_mem[(2**(ins_addr)-1):0];
initial
begin
$readmemh ("F:/Files/SingleCycleProcessor/testInstructions/testIns4.txt",instructions_mem);
end
assign instruction=instructions_mem[pc>>2];
endmodule //Instruction_Mem


