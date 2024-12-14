module d_latch(
	input D, En,
	output reg Q, Qbar
	);
	always @(En) begin
		if (En) begin
			Q <= D;
			Qbar <= ~D;
		end
	end
endmodule