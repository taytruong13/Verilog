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