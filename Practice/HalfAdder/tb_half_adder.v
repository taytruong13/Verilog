`timescale 1ns/1ps
module tb_half_adder;
	reg A, B;
	wire Sum, Carry;

half_adder dut(.A(A),.B(B),.Sum(Sum),.Carry(Carry));

initial begin
		A = 1'b0; B = 1'b0;
	#5	A = 1'b0; B = 1'b1;
	#5 	A = 1'b1; B = 1'b0;
	#5	A = 1'b1; B = 1'b1;
	#5	A = 1'b0; B = 1'b0;
	#5 $stop;
end
endmodule