`include "parameters.v"
module AluControl (
    input [4:0] Aluop,
    input [6:0] Func7,
    input [2:0] Func3,
    input Add4,
    output reg [4:0]operation
);

initial operation<=0;

always @(*) 
begin
    // case (Aluop)
    //     //`ALU_ADD_LUI:
        
    // endcase
end
endmodule //AluControl
/*
Readme:
Aluop from control 
Func7 from instruction
Func3 from instruction
Adder4 especially for jal and jalr
opearation for alu
*/