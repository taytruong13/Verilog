# Half Adder 
```
module half_adder(
	input A, B,
	output Sum, Carry
	);
	assign {Sum, Carry} = {A^B, A&B};
endmodule
```

# Truth tablle
|Input| |Output| |
|-----|-|------|-|
|A|B|Sum|Carry|
|0|0|0|0|
|0|1|1|0|
|1|0|1|0|
|1|1|0|1|

# Half Adder Testbench
```
`timescale 1ns/1ps
module tb_half_adder;
	reg A, B;
	wire Sum, Carry;

half_adder dut(.A(A),.B(B),.Sum(Sum),.Carry(Carry));

initial begin
		A = 1'b0; B = 1'b0;
	#5	A = 1'b0; B = 1'b1;
	#5 	A = 1'b1; B = 1'b0;
	#5	A = 1'b1; B = 1'b1;
	#5	A = 1'b0; B = 1'b0;
	#5 $stop;
end
endmodule
```

# Schematic
`updating`

# Simulation on ModelSim
![This is an alt text.](https://i.imgur.com/PXMXXs3.png "Half Adder Simulation")
