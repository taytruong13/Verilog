### Contents
- [4 to 2 encoder](#4to2encoder)
- [8 to 3 encoder](#encoder_8to3)


<a name="4to2encoder"></a>
# 4 to 2 Encoder
## The module
```
module encoder_4to2(
	input [3:0] in, 
	output reg [1:0] out
	);
   always @(*) begin
	case(in)
		4'b0001 : out = 2'b00;
		4'b0010 : out = 2'b01;
		4'b0100 : out = 2'b10;
		4'b1000 : out = 2'b11;
		default : out = 2'bxx;
	endcase
    end
endmodule 
```
## Testbench for 4 to 2 encoder
```
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
```
## Schematics
`update later`
## Simulation on Modelsim 
<img src=https://i.imgur.com/pyxGeRZ.png>

<a name="encoder_8to3"></a>
# 8 to 3 Encoder
## The module
```
module encoder_8to3 (
	input [7:0] in,
	output reg [2:0] out
);
    always @(*) begin
	case(in)
		8'b0000_0001 : out = 3'b000;
		8'b0000_0010 : out = 3'b001;
		8'b0000_0100 : out = 3'b010;
		8'b0000_1000 : out = 3'b011;
		8'b0001_0000 : out = 3'b100;
		8'b0010_0000 : out = 3'b101;
		8'b0100_0000 : out = 3'b110;
		8'b1000_0000 : out = 3'b111;
		default : out = 3'bxxx;
	endcase
    end
endmodule
```
## Testbench for 8 to 2 Encoder
```
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
```
## Schematic
`update later`
## Simulation on Modelsim
<img src=https://i.imgur.com/QJ2Lsuf.png>
