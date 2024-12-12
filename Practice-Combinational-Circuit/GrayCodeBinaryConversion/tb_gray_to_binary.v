`timescale 1ns/1ps
`define D_SIZE 8 //D_SIZE<=32 (equal or smaller than 32)
module tb_gray_to_binary #(parameter SIZE = `D_SIZE)();
	reg [SIZE-1:0] gray;
	wire [SIZE-1:0] bin;
	integer i;
	
	gray_to_binary #(SIZE) dut(.gray(gray),.bin(bin));
	
	initial begin
		$monitor("Gray %b --> Binary %b", gray, bin);
	end
	
	initial begin
		gray = 1'b0;
		#5;
		for(i=0; i<SIZE; i=i+1) begin
			gray = $urandom & ((1 << SIZE)-1);
			#5;
		end
		$stop;
	end
endmodule 