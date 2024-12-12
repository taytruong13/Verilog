`timescale 1ns/1ps
module tb_decoder_3to8();
	reg [2:0] in;
	wire [7:0] out;
	integer i;
	
	decoder_3to8 dut(.in(in),.out(out));
	
	initial begin
		$display("**Decoder 3 to 8**");
		$monitor("in = %b, out = %b_%b", in, out[7:4], out[3:0]);
		for(i=0; i<8; i=i+1) begin
			in = i[2:0];
			#5;
		end
		$stop;
	end
endmodule
	