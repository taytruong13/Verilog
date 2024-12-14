`timescale 1ns/1ps
`define D_SIZE 4 // change this number for another size of SIPO Shift Register
module tb_sipo_shift_reg();
	reg clk, rst, serial_in;
	wire [`D_SIZE-1:0] parallel_out;

	sipo_shift_reg dut(.clk(clk),.rst(rst),.serial_in(serial_in),.parallel_out(parallel_out));
// Clock generate:
always #5 clk = ~clk;
// 
initial begin
	clk = 0;
	serial_in = 0;
	rst = 1;
	$display("** %0d Bit SIPO Shift Register **", `D_SIZE);
	$monitor("At %06t: serial_in = %b, Parallel_out = %b", $time, serial_in, parallel_out);
	#20 rst = 0;
	#10 serial_in = 1;
	#10 serial_in = 0;
	#10 serial_in = 1;
	#20 serial_in = 0;
	#10 serial_in = 1;
	#10 serial_in = 0;
	#10 $stop;
end
endmodule