module single_bit_synchronizer (
	input wire clk_a, // Clock domain A
	input wire clk_b, // Clock domain B
	input wire signal_a, // Input signal from clock domain A
	output reg signal_b // Synchronized output in clock domain B
);	
	reg sync_ff1, sync_ff2;  // 2 flip-flop to hold signal from domain A
	
	// Synchronizer logic
	always @(posedge clk_b) begin
		sync_ff1 <= signal_a; // First stage of synchronization
		sync_ff2 <= sync_ff1; // Second stage of synchronization
		signal_b <= sync_ff2; // output in clock domain B
	end 
endmodule

	
	