module D_ff(
	input clk, D,
	output reg Q, 
	output Qbar
);
    always @(posedge clk) begin
	Q <= D;
    end

    assign Qbar = ~Q;

endmodule