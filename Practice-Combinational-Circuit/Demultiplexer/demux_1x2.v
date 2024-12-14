// 1x2 Demux:
module demux_1x2 (
	input wire din, 
	input wire sel, 
	output wire dout_0,
	output wire dout_1
	);
	
	assign dout_0 = (~sel) ? din : 1'b0;
	assign dout_1 = (sel) ? din : 1'b0;

endmodule