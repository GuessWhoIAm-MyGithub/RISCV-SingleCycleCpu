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

assign outData1=registers[reg1];//Fetch data
assign outData2=registers[reg2];
integer j;
initial j<=0;
always @(negedge clk) begin
    $display("clock %d :",j);
    j=j+1;
    $display("rf[3] = %h",registers[3]);
    $display("rf[4] = %h",registers[4]);
    $display("rf[5] = %h",registers[5]);
    $display("rf[6] = %h",registers[6]);
    $display("rf[7] = %h",registers[7]);
    $display("rf[8] = %h",registers[8]);
    $display("rf[9] = %h",registers[9]);
    $display("rf[10] = %h",registers[10]);
    $display("rf[23] = %h",registers[23]);
    $display("rf[24] = %h",registers[24]);
    $display("rf[27] = %h",registers[27]);
    $display("rf[28] = %h",registers[28]);
    
end
always@(negedge clk)//negeedge to write data
    begin
        if(RegWrite) 
            begin
            registers[reg_dest]=reg_dest==0?0:dataToWrite;//x0永远置0    
            end
    end
endmodule