module ring_counter #(parameter N = 4) (
	input clk, rst,
	output reg [N-1:0] q
);
// Initail value: set the most significant bit to 1
initial begin
	q <= 1'b1 << (N-1);
end

// shirt register logic
always @(posedge clk or posedge rst) begin 
	if(rst) begin
		// reset the counter to initial state
		q <= 1'b1 << (N-1);
	end else begin
		// Shirt all bít one positon to the right
		q <= {q[0], q[N-1:1]};
	end
end

endmodule