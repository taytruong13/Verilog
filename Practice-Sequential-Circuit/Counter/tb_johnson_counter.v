`timescale 1ns/1ps
`define D_SIZE 4
module tb_johnson_counter();
	reg clk, rst;
	wire [`D_SIZE-1:0] q;

	johnson_counter #(`D_SIZE) dut(.clk(clk),.rst(rst),.q(q));
// Generate clock
always #5 clk = ~clk;
//reset signal
initial begin
	clk = 1'b0;
	rst = 1'b1;
	#10 rst = 1'b0;
end

initial begin
	$monitor("At %06t: clk=%b, rst=%b, q=%b", $time, clk, rst, q);
	#100 $stop;
end
endmodule