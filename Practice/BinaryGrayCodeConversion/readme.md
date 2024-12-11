# Binary to Gray code converter
```
module binary_to_gray #(parameter SIZE = 4)(
	input [SIZE-1:0] bin,
	output [SIZE-1:0] gray
	);
	genvar g;
	assign gray[SIZE-1] = bin[SIZE-1];
	generate 
		for(g=SIZE-2; g>=0; g=g-1) begin
			assign gray[g] = bin[g+1]^bin[g];
		end
	endgenerate
endmodule 
```

# Testbench Binary to Gray Code converter D_SIZE = 8
```
`timescale 1ns/1ps
`define D_SIZE 8  // D_SIZE <= 32
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
```

# Schematic
`updating`

# Simulation on ModelSim

![This is an alt text.](https://i.imgur.com/qAcZpuo.png "Binary to Gray code converter")
