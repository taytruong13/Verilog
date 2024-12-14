`timescale 1ns/1ps
`define D_SIZE 4
module tb_ring_counter();
	reg clk, rst;
	wire [`D_SIZE-1:0] q;
	
	ring_counter #(`D_SIZE) dut(.clk(clk),.rst(rst),.q(q));

always #5 clk = ~clk;

initial begin
	clk = 1'b0;
	rst = 1'b1;
	#10 rst = 1'b0;
end

initial begin
	$monitor("At %06t, clk=%b, rst=%b, q=%b", $time, clk, rst, q);
	#50 $stop;
end
endmodule