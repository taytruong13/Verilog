`timescale 1ns/1ps
module tb_Full_Adder;
	reg A, B, Cin;
	wire Sum, Carry;
	
Full_Adder dut(.A(A),.B(B),.Cin(Cin),.Sum(Sum),.Carry(Carry));

initial begin
		A = 1'b0; B = 1'b0; Cin = 1'b0; //0 0 0
	#5 	A = 1'b0; B = 1'b0; Cin = 1'b1; //0 0 1
	#5	A = 1'b0; B = 1'b1; Cin = 1'b0; //0 1 0
	#5 	A = 1'b0; B = 1'b1; Cin = 1'b1; //0 1 1
	#5 	A = 1'b1; B = 1'b0; Cin = 1'b0; //1 0 0
	#5 	A = 1'b1; B = 1'b0; Cin = 1'b1; //1 0 1
	#5	A = 1'b1; B = 1'b1; Cin = 1'b0; //1 1 0
	#5 	A = 1'b1; B = 1'b1; Cin = 1'b1; //1 1 1
	#5	A = 1'b0; B = 1'b0; Cin = 1'b0;
	#5 $stop;
end
endmodule 
