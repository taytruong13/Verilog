`timescale 1ns/1ps
module tb_encoder_4to2();
	reg [3:0] in;
	wire [1:0] out;
	
	encoder_4to2 dut(.in(in),.out(out));	

	initial begin
		$monitor("in = %b, out = %b", in, out);
	end
	
	initial begin
		in = 4'b0000;
		#5 in = 4'b0001;
		#5 in = 4'b0010;
		#5 in = 4'b0100;
		#5 in = 4'b1000;
		#5 in = 4'b1111;
		#5 in = 4'b1010;
		#5 in = 4'b0000;
		#5 $stop;
	end
endmodule 
		