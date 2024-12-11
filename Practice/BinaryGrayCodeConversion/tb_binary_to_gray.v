`timescale 1ns/1ps
`define D_SIZE 8  // D_SIZE <= 32; D_SIZE has to be bigger than 32
module tb_binary_to_gray #(parameter SIZE = `D_SIZE)();
	reg [SIZE-1:0] bin;
	wire [SIZE-1:0] gray;
	integer i;
	
	binary_to_gray #(SIZE) dut(.bin(bin),.gray(gray));
	
	initial begin
		$monitor("Binary %b --> Gray %b", bin, gray);
	end
	
	initial begin
		bin = 1'b0;
		#5;
		for(i=0; i<SIZE;i=i+1) begin 
			bin = $urandom & ((1 << SIZE) -1);
			#5;
		end
		$stop;
	end
endmodule