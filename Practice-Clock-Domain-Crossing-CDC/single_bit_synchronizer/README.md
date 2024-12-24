# Single-Bit Signal Synchronization
Transmits a single-bit signal (e.g `enable`) from clock domain A to clock domain B using a double-flip-flop synchronizer technique.
## RTL Design
```
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
```
## Testbench for Single-Bit Signal Synchronization
```
`timescale 1ns/1ps
module tb_single_bit_synchronizer ();
	reg clk_a, clk_b;
	reg signal_a;
	wire signal_b;
	
	// Instantiate the DUT
	single_bit_synchronizer dut(.clk_a(clk_a),.clk_b(clk_b),.signal_a(signal_a),.signal_b(signal_b));
	
// Clock domain A generation
initial begin
	clk_a = 0;
	forever #10 clk_a = ~clk_a; // 50MHz clock
end
// Clock doamin B generation
initial begin
	clk_b = 0;
	forever #15 clk_b = ~clk_b; // 33.33 MHz Clock
end 

// Test stimulus 
initial begin
	signal_a = 0;
	#25 signal_a = 1; // Assert signal_a 
	#40 signal_a = 0; // Deassert signal_a
	#30 signal_a = 1; // assert signal_a again
	#50 $stop;
end

// Monitor
initial begin 
	$monitor($time, " clk_a=%b, clk_b=%b, signal_a=%b, signal_b=%b", clk_a, clk_b, signal_a, signal_b);
end 

endmodule
```
## Simulation on ModelSim
<img src=https://i.imgur.com/BEONCgf.png>