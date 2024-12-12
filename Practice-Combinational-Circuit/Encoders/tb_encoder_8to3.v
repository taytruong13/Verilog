`timescale 1ns/1ps
module tb_encoder_8to3();
	reg [7:0] in;
	wire [2:0] out;
	encoder_8to3 dut(.in(in),.out(out));

	initial begin
		$display("**Octal to Binary 8to3 encoder**");
		$monitor("in = %b, out = %b", in, out);
	end
	initial begin
		in = 8'b0000_0000;
		#5 in = 8'b0000_0001;
		#5 in = 8'b0000_0010;
		#5 in = 8'b0000_0100;
		#5 in = 8'b0000_1000;
		#5 in = 8'b0001_0000;
		#5 in = 8'b0010_0000;
		#5 in = 8'b0100_0000;
		#5 in = 8'b1000_0000;
		#5 in = 8'b1010_1110;
		#5 in = 8'b0000_0000;
		#5 $stop;
	end
endmodule 