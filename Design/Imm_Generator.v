`include "parameters.v"
module Imm_Generator 
(
    input [31:0] instruction,
    output reg [31:0] imm_out
);

initial
begin
imm_out=0;
end
always @(*) 
begin
    case(instruction[6:0])
       
        `LUI:
            imm_out[31:0]={instruction[31:12],{12'b0}};
        `AUIPC:
            imm_out[31:0]={instruction[31:12],12'b0};
        `JAL:
            imm_out[31:0]={{12{instruction[31]}},instruction[31],instruction[19:12],instruction[20],instruction[30:21],1'b0};
        `JALR:
            imm_out[31:0]={{20{instruction[31]}},instruction[31:20]};
        `B_TYPE:
            imm_out[31:0]=(instruction[14]&instruction[13])?{19'b0,instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0}:{{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],{1'b0}};
        `I_TYPE:
            imm_out[31:0]=instruction[14]?{20'b0,instruction[31:20]}:{{20{instruction[31]}},instruction[31:20]}; 
        `S_TYPE:
            imm_out[31:0]={{20{instruction[31]}},instruction[31:25],instruction[11:7]};
        `R_IMM:
            imm_out[31:0]=(instruction[12]&!instruction[13])?{{27{instruction[31]}},instruction[24:20]}:{{20{instruction[31]}},instruction[31:20]};

    endcase
end
endmodule //Imm_Generator