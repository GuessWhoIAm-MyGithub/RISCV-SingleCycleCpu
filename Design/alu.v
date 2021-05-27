`include "parameters.v"
module alu(
    input [31:0] src1,
    input [31:0] src2,
    input [4:0]operation,
    output reg [31:0]result,
    output reg zero
);
initial begin
result=0;
zero=0;
end
always @(*)
case(operation)
    `ALU_ADD_LUI:begin
        result<=src2;
        zero<=0;
    end
    `ALU_ADD:
    begin
        result<=src1+src2;
        zero<=0;
    end
    `ALU_SUB:
    begin
        result<=src1-src2;
        zero<=0;
    end
    `ALU_ADD4:
    begin
        result<=src1+4;
        zero<=1;
    end
        
    `ALU_BEQ:
        begin
            result=src1-src2;
            zero=result==0;
        end
    `ALU_BNE:
        begin
            result=src1-src2;
            zero=result==0?0:1;
        end
    `ALU_BLT:
        begin
            zero=$signed(src1)<$signed(src2);
        end
    `ALU_BGE:
        begin
            zero=$signed(src1)>=$signed(src2);
        end
    `ALU_BLTU:
        begin
            zero=(src1)<(src2);
        end
    `ALU_BGEU:
        begin
            zero=(src1)>=(src2);
        end
    `ALU_SRL:
        begin
            result<=src1>>src2;
            zero<=0;
        end
    `ALU_SRA:
        begin
            result<=$signed(src1)>>$signed(src2);
            zero<=0;
        end
    `ALU_SLL:
        begin
            result=src1<<src2;
            zero<=0;
        end
    `ALU_AND:
        begin
            result<=src1&src2;
            zero<=0;
        end
    `ALU_OR:
        begin
            result<=src1 |src2;
            zero<=0;
        end
    `ALU_XOR:
        begin
            result<=src1^src2;
            zero<=0;
        end
    `ALU_SLT:begin
            result<=($signed(src1)<$signed(src2));
            zero<=0;
        end
    `ALU_SLTU:begin
            result<=(src1<src2);
            zero<=0;
        end
endcase

endmodule