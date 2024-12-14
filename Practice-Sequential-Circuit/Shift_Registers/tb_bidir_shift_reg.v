`timescale 1ns/1ps
`define D_SIZE 4
module tb_bidir_shift_reg();
	reg clk, in, en, dir, rst;
	wire [`D_SIZE-1:0] out;
	
	bidir_shift_reg dut(.clk(clk),.in(in),.en(en),.dir(dir),.rst(rst),.out(out));
//clock generate
always #5 clk = ~clk;
initial begin
	$monitor("in=%b en=%b dir=%b rst=%b out=%b", in, en, dir, rst, out);
	clk = 0;
	rst = 0;
	en = 0;
	dir = 0;
	in = 0;
	#5;
	rst = 1;
	#10 rst = 0; en = 1;
	repeat (8) begin
		#10 in = $random;
	end
	
	dir = 1;
	repeat (8) begin
		#10 in = $random;
	end
	#20 $stop;
end 
endmodule
	
	