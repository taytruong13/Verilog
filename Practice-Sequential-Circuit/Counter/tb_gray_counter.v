`timescale 1ns/1ps
`define D_SIZE 4

module tb_gray_counter();
	reg clk, rst;
	wire [`D_SIZE-1:0] gray_count;
	
	gray_counter #(`D_SIZE) dut(.clk(clk),.rst(rst),.gray_count(gray_count));
	
always #5 clk = ~clk;
initial begin 
	clk = 0; 
	rst = 1;
	#5 rst = 0;
end
initial begin
	$monitor("At %06t: counter = %02d = %b", $time, gray_count, gray_count);
	#200 $stop;
end
endmodule