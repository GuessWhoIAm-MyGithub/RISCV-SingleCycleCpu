`timescale 1ps/1ps
`include "parameters.v"

module control(
    //input
    input[6:0] opcode,
    input[6:0] func7,
    input[2:0] func3,
  //output
    output reg Alusrc1,//for mux between pc and readData1
    output reg Alusrc2,//for mux between imm and readData2
    output reg MemtoReg,
    output reg RegWrite,
    output reg [2:0]MemRead,
    output reg [1:0]MemWrite,
    output reg Branch,
    output reg Add4,
    output reg jalr,
    output reg [4:0]Aluop
);

initial begin
Alusrc1<=0;
Alusrc2<=0;
MemRead<=0;
MemWrite<=0;
MemtoReg<=0;
RegWrite<=0;
Add4<=0;
Branch<=0;
jalr<=0;
Aluop[4:0]<=0;
end
// assign Alusrc=(opcode==I_TYPE)|(opcode==S_TYPE)|(opcode==R_IMM);
// assign MemtoReg=(opcode==I_TYPE);
// assign RegWrite=(opcode==R_TYPE)|(opcode==I_TYPE)|(opcode==R_IMM);
// assign MemRead=(opcode==I_TYPE);
// assign MemWrite=(opcode==S_TYPE);
// assign Branch=(opcode==B_TYPE);
// assign Aluop[1]=(opcode==R_TYPE)|(opcode==R_IMM);
// assign Aluop[0]=(opcode==B_TYPE);

always @(*) 
begin
  case (opcode)
    //lui
    `LUI:
    begin
      Alusrc1<=0;
      Alusrc2<=1;
      RegWrite<=1;
      Aluop[4:0]<=`ALU_ADD_LUI;
      MemWrite[1:0]<=0;
      MemRead[2:0]<=0;
      Branch<=0;
      MemtoReg<=0;
      Add4<=0;
      jalr<=0;
    end
    //auipc
    `AUIPC:
    begin
      Alusrc1<=1;
      Alusrc2<=1;
      RegWrite<=1;
      Aluop[4:0]<=`ALU_ADD;
      MemWrite[1:0]<=0;
      MemRead[2:0]<=0;
      Branch<=0;
      MemtoReg<=0;
      Add4<=0;
      jalr<=0;

    end
      //jal
    `JAL:
    begin
      Alusrc1<=1;
      Alusrc2<=1;
      RegWrite<=1;
      Aluop[4:0]<=`ALU_ADD4;
      MemWrite[1:0]<=0;
      MemRead[2:0]<=0;
      Branch<=1;
      Add4<=1;
      jalr<=1;
      MemtoReg<=0;
    end
    //jalr
    `JALR:
    begin
      Alusrc1<=1;
      Alusrc2<=1;
      RegWrite<=1;
      Aluop[4:0]<=`ALU_ADD4;
      MemWrite[1:0]<=0;
      MemRead[2:0]<=0;
      Branch<=1;
      Add4<=1;
      jalr<=1;
      MemtoReg<=0;
    end
    //beq etc.
    `B_TYPE:
    begin
      Alusrc1<=0;
      Alusrc2<=0;
      MemWrite[1:0]<=0;
      RegWrite<=0;
      MemRead[2:0]<=0;
      Branch<=1;
      MemtoReg<=0;
      jalr<=0;
      Add4<=0;
      
      case (func3)
        3'b000:
        //beq
          Aluop[4:0]<=`ALU_BEQ;   
          3'b001:
        //bne
            Aluop[4:0]<=`ALU_BNE;
          3'b100:
        //blt
          Aluop[4:0]<=`ALU_BLT;
          3'b101:
        //bge
            Aluop[4:0]<=`ALU_BGE;
          3'b110:
        //bltu
            Aluop[4:0]<=`ALU_BLTU;
          3'b111:
        //bgeu
            Aluop[4:0]<=`ALU_BGEU;
      endcase
    end
    `I_TYPE:
    begin
      Alusrc1<=0;
      Alusrc2<=1;
      Aluop[4:0]<=`ALU_ADD;
      MemtoReg<=1;
      RegWrite<=1;
      MemWrite[1:0]<=0;
      Branch<=0;
      jalr<=0;
      Add4<=0;
        case(func3)
          `FUNC3_LB: MemRead[2:0]<=`MEMREAD_LB;
          `FUNC3_LH: MemRead[2:0]<=`MEMREAD_LH;
          `FUNC3_LW: MemRead[2:0]<=`MEMREAD_LW;
          `FUNC3_LBU:MemRead[2:0]<=`MEMREAD_LBU;
          `FUNC3_LHU: MemRead[2:0]<=`MEMREAD_LHU;
        endcase
    end
    `S_TYPE:
    begin
      Alusrc1<=0;
      Alusrc2<=1;
      Aluop[4:0]<=`ALU_ADD;
      MemtoReg<=0;
      RegWrite<=0;
      MemRead[2:0]<=0;
      Branch<=0;
      jalr<=0;
      Add4<=0;
      case(func3)
        `FUNC3_SB:MemWrite[1:0]<=`MEMWRITE_SB;
        `FUNC3_SH:MemWrite[1:0]<=`MEMWRITE_SH;
        `FUNC3_SW:MemWrite[1:0]<=`MEMWRITE_SW;
      endcase  
    end
    `R_IMM:
    begin
      Alusrc1<=0;
      Alusrc2<=1;
      MemtoReg<=0;
      RegWrite<=1;
      MemRead[2:0]<=0;
      MemWrite[1:0]<=0;
      Branch<=0;
      jalr<=0;
      Add4<=0;
      case(func3)
        3'b101:Aluop[4:0]<=(func7[6:0]===7'b0000000)?`ALU_SRL:`ALU_SRA;
        3'b001:Aluop[4:0]<=`ALU_SLL;
        3'b111:Aluop[4:0]<=`ALU_AND;
        3'b110:Aluop[4:0]<=`ALU_OR;
        3'b100:Aluop[4:0]<=`ALU_XOR;
        3'b011:Aluop[4:0]<=`ALU_SLTU;
        3'b010:Aluop[4:0]<=`ALU_SLT;
        3'b000:Aluop[4:0]<=`ALU_ADD;
      endcase
    end
     `R_TYPE:
     begin
      Alusrc1<=0;
      Alusrc2<=0;
      MemtoReg<=0;
      RegWrite<=1;
      MemRead[2:0]<=0;
      MemWrite[1:0]<=0;
      Branch<=0;
      jalr<=0;
      Add4<=0;
        case(func3)
          3'b000:Aluop=(func7==7'b0000000)?`ALU_ADD:`ALU_SUB;
          3'b001:Aluop=`ALU_SLL;
          3'b010:Aluop=`ALU_SLT;
          3'b011:Aluop=`ALU_SLT;
          3'b100:Aluop=`ALU_XOR;
          3'b101:Aluop=(func7==7'b0000000)?`ALU_SRL:`ALU_SRA;
          3'b110:Aluop=`ALU_OR;
          3'b111:Aluop=`ALU_AND;
        endcase
    end
  endcase
end
endmodule