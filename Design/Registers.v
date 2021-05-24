module Registers(  
    input clk,  
    input RegWrite,  
    input[4:0] reg1,  
    input[4:0] reg2,  
    input[4:0] reg_dest,  
    input[31:0] dataToWrite,  
    output wire [31:0] outData1,  
    output wire [31:0] outData2
);
reg[31:0] registers[31:0];//32个寄存器
integer i;
initial
    begin
        for(i=0;i<32;i=i+1)  registers[i]<=0;//initialization
    end

assign outData1=registers[{27'b0,reg1}];//Fetch data
assign outData2=registers[{27'b0,reg2}];
always@(negedge clk)//negeedge to write data
    begin
        if(RegWrite) 
            begin
            registers[reg_dest]=reg_dest==0?0:dataToWrite;//x0永远置0    
            end
    end
endmodule