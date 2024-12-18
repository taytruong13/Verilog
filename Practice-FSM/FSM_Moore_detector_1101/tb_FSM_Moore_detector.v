`timescale 1ns/1ps
module tb_FSM_Moore_detector ();
	reg clk, rst;
	reg in_bit;
	wire detected;
	
	// Instantiate the module 
	FSM_Moore_detector dut(.clk(clk),.rst(rst),.in_bit(in_bit),.detected(detected));
	// shift_detector_1101 dut(.clk(clk),.rst(rst),.in_bit(in_bit),.detected(detected));
	
	// Clock generation
always #5 clk = ~clk;

	// Test sequence 1101
initial begin
	clk = 0;
	rst = 1;
	in_bit = 0;
	#10 rst = 0;
	
	// Input sequence: 1101101101
	#10 in_bit = 1; // 1
	#10 in_bit = 1; // 11
	#10 in_bit = 0; // 110
	#10 in_bit = 1; // 1101 -> Detected
	#10 in_bit = 1; // 1
	#10 in_bit = 0; // 10 -> IDLE
	#10 in_bit = 1; // 1
	#10 in_bit = 1; // 11
	#10 in_bit = 0; // 110
	#10 in_bit = 1; // 1101 -> Detected
	
	#50 $stop;
end

endmodule