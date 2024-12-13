module SR_ff_sync_rst(
	input clk, rst, S, R,
	output reg Q
);
always @(posedge clk) begin
	if(rst) Q <= 1'b0;
	else begin
	    case ({S, R})
		2'b10 : Q <= 1'b1;
		2'b01 : Q <= 1'b0;
		default : Q <= Q;
	    endcase
	end
end
endmodule