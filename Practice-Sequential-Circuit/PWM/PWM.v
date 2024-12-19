module PWM(
	input clk,
	input [7:0] duty, // Duty cycle = Turn ON time / (Turn ON time + Turn OFF time)
	output reg out
);

	reg [7:0] count;
initial begin
	count = 8'b0;
end
	
always @(posedge clk) begin
	count = count + 1;
	out = (count < duty) ? 1 : 0;
end 

endmodule 