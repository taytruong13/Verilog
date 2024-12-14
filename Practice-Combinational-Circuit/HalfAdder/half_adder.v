module half_adder(
	input A, B,
	output Sum, Carry
	);
	assign {Sum, Carry} = {A^B, A&B};
endmodule
