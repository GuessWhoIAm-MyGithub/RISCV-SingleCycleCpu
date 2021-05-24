module muxMemtoReg (
    input MemtoReg,//control signal 
    input [31:0]Aluresult,//result from alu
    input [31:0]Memdata,//result get from memory
    output wire [31:0]dataToReg

);
assign dataToReg=MemtoReg?Memdata:Aluresult;//if 1,memory data to register,else alu result to register


endmodule //muxMemtoReg