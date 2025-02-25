`timescale 1ns/1ps
`define D_SIZE 4
module tb_piso_shift_reg();
	reg clk, rst, enIn;
	reg [`D_SIZE-1:0] parallel_in;
	wire serial_out;

	piso_shift_reg dut(.clk(clk),.rst(rst),.enIn(enIn),.parallel_in(parallel_in),.serial_out(serial_out));
// Generate clk
always #5 clk = ~clk;

initial begin
	$display(" ** %0d Parallel In Serial Out ** ",`D_SIZE);
	$monitor("At %06t: Parallel = %b, enIn = %b, serial_out = %b", $time, parallel_in, enIn, serial_out);
	clk = 0;
	rst = 0; enIn = 0;
	#10 rst = 1;
	#10 rst = 0; parallel_in = $urandom & ((1<<`D_SIZE)-1);
	#10 enIn = 1;
	#10 enIn = 0; parallel_in = $urandom & ((1<<`D_SIZE)-1);
	#50 enIn = 1;
	#10 enIn = 0;
	#50 $stop;
end
endmodule 