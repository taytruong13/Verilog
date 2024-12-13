`timescale 1ns/1ps
module tb_D_latch();
	reg D, En;
	wire Q, Qbar;
	// Instantiated the unit under test
	d_latch dut(.D(D),.En(En),.Q(Q),.Qbar(Qbar));
	
	initial begin
		$display("** D Latch **");
		$monitor("D = %b, En = %b, Q = %b, Qbar = %b", D, En, Q, Qbar);
		D = 0; En = 0;
		#5 D = 1; En = 0;
		#5 En = 1;
		#5 D = 0;
		#5 En = 0;
		#5 $stop;
	end
endmodule 