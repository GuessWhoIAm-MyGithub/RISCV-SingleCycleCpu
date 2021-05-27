`timescale 1ps/1ps
`include "parameters.v"
module DataMemory#(parameter DM_addr=16) (
    input clk,
    input [2:0]MemRead,
    input [1:0]MemWrite,
    input [31:0] Address,
    input [31:0]dataToMem,
    output reg[31:0]data    
);
integer i;
initial begin
data=0;
end
reg [7:0] Memory[16-1:0];//64MB内存
initial
    begin
        for(i=0;i<2**DM_addr;i=i+1) Memory[i]=32'b0;
    end
always @(posedge clk) begin

    $display("Mem[0] = %h",Memory[0]);
    $display("Mem[1] = %h",Memory[1]);
    $display("Mem[2] = %h",Memory[2]);
    $display("Mem[3] = %h",Memory[3]); 
    $display("------------------------"); 
end


always @(*) //读数据
   begin
       case(MemRead)
        `MEMREAD_LB:data<={{24{Memory[Address][7]}},Memory[Address][7:0]};
        `MEMREAD_LH:data<={{16{Memory[Address+1][7]}},Memory[Address+1],Memory[Address]};
        `MEMREAD_LW:data<={Memory[Address+3],Memory[Address+2],Memory[Address+1],Memory[Address]};
        `MEMREAD_LBU:data<={24'b0,Memory[Address][7:0]};
        `MEMREAD_LHU:data<={16'b0,Memory[Address+1],Memory[Address]};
       endcase
   end

always@(negedge clk &&MemWrite!=2'b0)
    begin
        case(MemWrite)
            `MEMWRITE_SB:
                Memory[Address]<={24'b0,dataToMem[7:0]};
            `MEMWRITE_SH:
                begin
                    Memory[Address]<=dataToMem[7:0];
                    Memory[Address+1]<=dataToMem[15:8];
                end  
            `MEMWRITE_SW:
                begin
                    Memory[Address]<=dataToMem[7:0];
                    Memory[Address+1]<=dataToMem[15:8];
                    Memory[Address+2]<=dataToMem[23:16];
                    Memory[Address+3]<=dataToMem[31:24];
                end
                
        endcase
    end





always @(negedge clk) 
begin
    if(MemWrite&&!MemRead)
        Memory[Address]=dataToMem;
end

endmodule //DataMemory