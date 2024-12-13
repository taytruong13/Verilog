module SR_latch(
	input S, R, 
	output reg Q, Qbar
	);
	always @(posedge S or posedge R) begin
		if(R) begin
			Q <= 1'b0;
			Qbar <= 1'b1;
		end else if (S) begin
			Q <= 1'b1;
			Qbar <= 1'b0;
		end
	end
endmodule 