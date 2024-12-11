# Ripple Carry Adder n bit with Generate
```
module ripple_carry_adder #(parameter WIDTH = 4)(
	input [WIDTH-1:0] a,
	input [WIDTH-1:0] b,
	input cin,
	output [WIDTH-1:0] sum, cout
	);
	
	genvar g;
	//First full adder
	full_adder fa0(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(cout[0]));
	//2nd, 3rd, ... full adder generation
	generate
		for(g=1; g<WIDTH; g=g+1) begin
			full_adder fa(
					.a(a[g]),.b(b[g]),.cin(cout[g-1]),
					.sum(sum[g]),
					.cout(cout[g]));
		end
	endgenerate
endmodule 

// full adder module
module full_adder(
	input a, b, cin,
	output sum, cout
	);
	assign sum = a^b^cin;
	assign cout = (a&b)|(a&cin)|(b&cin);
endmodule
```

# Testbench for Ripple Carrry Adder 4 bit (WIDTH = 4)
```
`timescale 1ns/1ps
module tb_ripple_carry_adder #(parameter WIDTH = 4)();
	reg [WIDTH-1:0] a, b;
	reg cin;
	wire [WIDTH-1:0] sum, cout;
	
	ripple_carry_adder dut(
		.a(a),.b(b),
		.cin(cin),
		.sum(sum),.cout(cout)
	);
	
	initial begin 
		$monitor("cin = %b, %b + %b = %b, cout = %b", cin, a, b, sum, cout);
	end
	
	initial begin
		cin = 1'b0;
		a = 4'b0000; b = 4'b0000;
		#10;
		a = 4'b0001; b = 4'b0010;
		#10;
		a = 4'b0011; b = 4'b0101;
		#10;
		a = 4'b0111; b = 4'b1011;
		#10 $stop;
		//
		cin = 1'b1;
		a = 4'b0000; b = 4'b0000;
		#10;
		a = 4'b0001; b = 4'b0010;
		#10;
		a = 4'b0011; b = 4'b0101;
		#10;
		a = 4'b0111; b = 4'b1011;
		#10 $stop;
	end
endmodule
```

# Schematic
`updating`

# Simulation on ModelSim

![This is an alt text.](https://i.imgur.com/ZB3EN4Z.png "Half Adder Simulation")
