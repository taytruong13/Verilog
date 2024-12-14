module gray_counter #(parameter N = 4)(
	input clk, rst,
	output [N-1:0] gray_count
);
	reg [N-1:0] bin_count;
	bin_to_gray #(N) btg(.bin(bin_count),.gray(gray_count));
	always @(posedge clk or posedge rst) begin
		if(rst) bin_count <= 'b0;
		else bin_count <= bin_count + 1;
	end
endmodule 

module bin_to_gray #(parameter SIZE = 4)(
	input [SIZE-1:0] bin,
	output [SIZE-1:0] gray
);
	assign gray[SIZE-1] = bin[SIZE-1];
	genvar g;
	generate
		for(g=SIZE-2; g>=0; g=g-1) begin : cal_gray_bits
			assign gray[g] = bin[g+1]^bin[g];
		end
	endgenerate
endmodule 
			