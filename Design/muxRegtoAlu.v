module muxRegtoAlu (
    input Alusrc1,Alusrc2,
    input [31:0]readData1,//from Register1
    input [31:0]PC,  
    input [31:0]readData2,//from Register2
    input [31:0]immediate,//from imm_generator
    output wire [31:0]adder1,
    output wire [31:0]adder2//to Alu
    
);
assign adder2=Alusrc2?immediate:readData2;
assign adder1=Alusrc1?PC:readData1;
endmodule //muxReg2Alu


/*Readme:
Alusrc1:choose readData1 and pc
Alusrc2:choose readData2 and Imm
adder1 adder2:input to ALU
*/