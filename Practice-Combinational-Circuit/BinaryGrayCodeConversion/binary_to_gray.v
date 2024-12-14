module binary_to_gray #(parameter SIZE = 4)(
	input [SIZE-1:0] bin,
	output [SIZE-1:0] gray
	);
	genvar g;
	assign gray[SIZE-1] = bin[SIZE-1];
	generate 
		for(g=SIZE-2; g>=0; g=g-1) begin
			assign gray[g] = bin[g+1]^bin[g];
		end
	endgenerate
endmodule 
