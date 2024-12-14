module comparator_4bit(
	input [3:0] inA, inB,
	output A_eq_B, A_lt_B, A_gt_B
);
	wire [4:0] diffAB;
	assign diffAB = inA - inB;
	assign A_gt_B = ~diffAB[4];
	assign A_lt_B = diffAB[4];
	assign A_eq_B = ~(|diffAB);

endmodule 
