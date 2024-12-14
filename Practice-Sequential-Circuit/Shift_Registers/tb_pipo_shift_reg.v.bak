`timescale 1ns/1ps
`define D_SIZE 4
module tb_pipo_shift_reg();
	reg clk;
	reg [`D_SIZE-1:0] din;
	wire [`D_SIZE-1:0] dout;
	
	pipo_shift_reg dut(.clk(clk),.din(din),.dout(dout));
	
always #5 clk = ~clk;
initial begin
	$monitor("Input = %b, Output = %b", din, dout);
	clk = 0;
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#30 $stop;
end
endmodule