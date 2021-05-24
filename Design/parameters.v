//opcode mapping
`define   LUI        7'b0110111//lui
`define AUIPC      7'b0010111//auipc
`define JAL        7'b1101111//jal
`define JALR       7'b1100111//jalr
`define B_TYPE     7'b1100011//beq bne blt bge bltu bgeu etc.
`define I_TYPE     7'b0000011//lb lh lw lbu lhu
`define S_TYPE     7'b0100011//sb sh sw
`define R_IMM      7'b0010011//addi slti sltiu xori ori andi slli srli srai
`define R_TYPE     7'b0110011//add sub sll slt sltu xor srl sra or and

//Aluop
`define ALU_ADD 5'b00000
`define ALU_SUB 5'b00001
`define ALU_SLL 5'b00010
`define ALU_SLT 5'b00011
`define ALU_XOR 5'b00100
`define ALU_SRL 5'b00101
`define ALU_SRA 5'b00110
`define ALU_OR  5'b00111
`define ALU_AND 5'b01000  
`define ALU_SLTU 5'b10000
`define ALU_ADD_LUI 5'b01111
`define ALU_ADD4 5'b10000 

//`define ALU_ADD_AUIPC 5'b10000 
//JUMP CONDITIONS 
`define ALU_BEQ   5'b01001
`define ALU_BNE   5'b01010
`define ALU_BLT   5'b01011
`define ALU_BGE   5'b01100
`define ALU_BLTU  5'b01101
`define ALU_BGEU  5'b01110




`define FUNC3_LB 3'b000
`define FUNC3_LH 3'b001
`define FUNC3_LW 3'b010
`define FUNC3_LBU 3'b100
`define FUNC3_LHU 3'b101    
//000 refers to not activate 
`define MEMREAD 3'b000 
`define MEMREAD_LB 3'b001
`define MEMREAD_LH 3'b010
`define MEMREAD_LW 3'b011
`define MEMREAD_LBU 3'b100
`define MEMREAD_LHU 3'b101

`define FUNC3_SB 3'b000
`define FUNC3_SH 3'b001
`define FUNC3_SW 3'b010
//00 refers to not activate
`define MEMWRITE 2'b00
`define MEMWRITE_SB 2'b01
`define MEMWRITE_SH 2'b10
`define MEMWRITE_SW 2'b11 

