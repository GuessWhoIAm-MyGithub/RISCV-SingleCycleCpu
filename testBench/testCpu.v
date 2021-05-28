`timescale 1ps/1ps
module testCPU();
/*
40 instructions supported SingleCycleCpu accomplished
time-date:9:42 24th May 2021
Coder:GuessWhoIam
*/


wire [31:0]now_pc;
wire [31:0] instruction;
wire [31:0]next_pc;
wire MemtoReg,RegWrite;
wire [2:0]MemRead;
wire [1:0]MemWrite;
wire [4:0] Aluop;
wire jalr,jal;
wire Alusrc1,Alusrc2;
wire Add4;
reg clk,rstn;
wire[31:0]imm;
wire Branch;

wire [4:0]reg1=instruction[19:15];
wire[4:0]reg2=instruction[24:20];
wire[4:0]reg_dest=instruction[11:7];
wire[31:0] dataToWrite;
wire [31:0]outData1;
wire [31:0]outData2;//from register

wire [31:0] src1;
wire [31:0] src2;
//wire [3:0] operation;
wire [31:0]result;
wire zero;
wire [6:0]Func7=instruction[31:25];
wire [2:0]Func3=instruction[14:12];
wire [31:0] readOutData;//from memory
initial begin

    clk=1;
    rstn=0;
    //rstn=1'b1;  
end

always #30 clk=~clk;

pc_adder testpc_adder(
.now_pc(now_pc),
.imm(imm),
.readData1(outData1),
.Branch(Branch),
.zero(zero),
.jalr(jalr),
.jal(jal),
.next_pc(next_pc)
);

Instruction_Mem inst_mem(
    
    .pc(now_pc),
    .instruction(instruction)
);

PC testPC(
    .clk(clk),
    .rstn(rstn),
    .next_pc(next_pc),
    .now_pc(now_pc)
);

control  testcontrol(
.opcode(instruction[6:0]),
.func7(instruction[31:25]),
.func3(instruction[14:12]),
.Alusrc1(Alusrc1),
.Alusrc2(Alusrc2),
.MemtoReg(MemtoReg),
.RegWrite(RegWrite),
.MemRead(MemRead),
.MemWrite(MemWrite),
.Branch(Branch),
.Add4(Add4),
.jalr(jalr),
.jal(jal),
.Aluop(Aluop)
);

Imm_Generator testimm_gen(
.instruction(instruction),
.imm_out(imm)
);

Registers testReg(
.clk(clk),
.RegWrite(RegWrite),
.reg1(reg1),
.reg2(reg2),
.reg_dest(reg_dest),
.dataToWrite(dataToWrite),
.outData1(outData1),
.outData2(outData2)
);
muxRegtoAlu test_mux_reg_alu(
.Alusrc1(Alusrc1),
.Alusrc2(Alusrc2),
.readData1(outData1),
.PC(now_pc),
.readData2(outData2),
.immediate(imm),
.adder1(src1),
.adder2(src2)

);

alu testAlu(
.src1(src1),
.src2(src2),
.operation(Aluop),
.result(result),
.zero(zero)
);

DataMemory testMem(
.clk(clk),
.MemRead(MemRead),
.MemWrite(MemWrite),
.Address(result),
.dataToMem(outData2),
.data(readOutData)
);

muxMemtoReg test_mux_mem_reg(
.MemtoReg(MemtoReg),
.Aluresult(result),
.Memdata(readOutData),
.dataToReg(dataToWrite)
);
endmodule //testAlu
