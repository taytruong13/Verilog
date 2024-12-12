# Gray code to Binary converter
```
module gray_to_binary #(parameter SIZE) (
	input [SIZE-1:0] gray,
	output [SIZE-1:0] bin
	);
	genvar g;
	
	assign bin[SIZE-1] = gray[SIZE-1];
	generate
		for(g=SIZE-2; g>=0; g=g-1) begin
			assign bin[g] = bin[g+1]^gray[g];
		end
	endgenerate
endmodule
```
# How does it work? 
![This is an alt text.](https://i.imgur.com/FIuju8i.png "Binary to Gray code converter")

# Testbench Gray code to Binary converter D_SIZE = 8
```
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
```

# Schematic
`updating`

# Simulation on ModelSim

![This is an alt text.](https://i.imgur.com/sls0cBk.png "Binary to Gray code converter")
