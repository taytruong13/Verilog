// 1x4 demux
module demux_1x4(
	input wire din, 
	input wire [1:0] sel,
	output wire dout_0, dout_1, dout_2, dout_3
);
	assign dout_0 = (sel == 2'b00) ? din : 1'b0;
	assign dout_1 = (sel == 2'b01) ? din : 1'b0;
	assign dout_2 = (sel == 2'b10) ? din : 1'b0;
	assign dout_3 = (sel == 2'b11) ? din : 1'b0;
endmodule