module johnson_counter #(parameter N = 4) (
	input clk, rst,
	output reg [N-1:0] q
);
// Initial value: set the MSB to 1
initial begin
	q <= 1'b1 << (N-1);
end

// shift register logic
always @(posedge clk or posedge rst) begin
	if(rst) q <= 1'b1 << (N-1);
	else q <= {~q[0], q[N-1:1]};
end 
endmodule