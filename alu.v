module Alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] C
);
always@(*)
    case(ALUOp)
    3'b000: C=A+B;
    3'b001: C=A-B;
    3'b010: C=A&B;
    3'b011: C=A|B;
    3'b100: C=A>>B;
    3'b101: C=(A>>B)|(~(A[31]>>B)+1);
    3'b110: 
        begin
        if(A[31]==B[31]&&A[31]==1'b0)
            C=A>B?1:0;
        if(A[31]==B[31]&&A[31]==1'b1)
            C=A>=B?0:1;
        else 
            C=A[31]>B[31]?0:1;
        end
    3'b111: C=A>B?1:0;
    endcase
endmodule