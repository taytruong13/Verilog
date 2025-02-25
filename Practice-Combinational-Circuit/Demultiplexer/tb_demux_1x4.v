`timescale 1ns/1ps
module tb_demux_1x4();
	reg din;
	reg [1:0] sel;
	wire dout_0, dout_1, dout_2, dout_3;
	integer i;

	demux_1x4 dut(.din(din),.sel(sel),
			.dout_0(dout_0),.dout_1(dout_1),.dout_2(dout_2),.dout_3(dout_3));
	// Monitor
	initial begin
		$monitor("din = %b, sel = %b, dout[3-0] = %b", din, sel, {dout_3, dout_2, dout_1, dout_0});
	end
	
	initial begin
		din = 1'b0; sel = 2'b00;
		#5;
		din = 1'b1;
		for(i = 0; i<4; i=i+1) begin
			sel = i; 
			#5;
		end
		sel = 2'b0;
		#5 $stop;
	end
endmodule