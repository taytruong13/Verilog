module gray_to_binary #(parameter SIZE) (
	input [SIZE-1:0] gray,
	output [SIZE-1:0] bin
	);
	genvar g;
	
	assign bin[SIZE-1] = gray[SIZE-1];
	generate
		for(g=SIZE-2; g>=0; g=g-1) begin
			assign bin[g] = bin[g+1]^gray[g];
		end
	endgenerate
endmodule
