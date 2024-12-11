module Full_Adder(
	input A, B, Cin, 
	output Sum, Carry
	);
	assign {Sum, Carry} = {A^B^Cin, (A&B)|(A&Cin)|(B&Cin)};
endmodule 



	