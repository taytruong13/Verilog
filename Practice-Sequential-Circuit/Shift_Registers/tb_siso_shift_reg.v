`timescale 1ns/1ps
module tb_siso_shift_reg();
	reg clk, serial_in;
	wire serial_out;
	
	siso_shift_reg dut(.clk(clk),.serial_in(serial_in),.serial_out(serial_out));
	
always #5 clk = ~clk;

initial begin
	clk = 0;
	serial_in = 0;
	$display("** SISO shift Register **");
	$monitor("At %06t: [Serial_in, Serial_out] = [%b, %b]", $time, serial_in, serial_out);
	
	#10 serial_in = 1'b1;
	#10 serial_in = 1'b1;
	#10 serial_in = 1'b0;
	#10 serial_in = 1'b1;
	#10 serial_in = 1'b0;
	#50 $stop;
end
endmodule