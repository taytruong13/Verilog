`timescale 1ns/1ps
module tb_D_ff();
	reg clk, D;
	wire Q, Qbar;
	
	D_ff dut(.clk(clk),.D(D),.Q(Q),.Qbar(Qbar));


	always #5 clk = ~clk;

	initial begin
		$display("** D Flip Flop **");
		$monitor("At %06t: D = %b, Q = %b, Qbar = %b", $time, D, Q, Qbar);
		clk = 0;
		#10 D = 0;
		#10 D = 1;
		#10 D = 0;
		#10 $stop;
	end
endmodule