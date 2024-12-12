`timescale 1ns/1ps
`define D_SIZE 4
module tb_decoder_4to16();
	reg [`D_SIZE-1:0] in;
	wire [(1<<`D_SIZE)-1:0] out;
	integer i;

	decoder_4to16 dut(.in(in),.out(out));
	initial begin
		$display("** Decoder %01d to %01d **", `D_SIZE,(1<<`D_SIZE));
		$monitor("in = %b, out = %b", in, out);
		for(i=0;i<(1<<`D_SIZE); i=i+1) begin
			in = i[`D_SIZE-1:0];
			#5;
		end
		$stop;
	end
endmodule