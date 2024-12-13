### Contents
- [4 to 2 decoder](#decoder2to4)
- [8 to 3 decoder](#decoder3to8)
- [4 to 16 Decoder and free SIZE](#decoder4to16)

<a name="decoder2to4"></a>
# 2 to 4 Decoder
## The module
```
module decoder_2to4(
	input wire [1:0] in,
	output reg [3:0] out
	);
always @(*) begin
	case(in)
		2'b00 : out = 4'b0001;
		2'b01 : out = 4'b0010;
		2'b10 : out = 4'b0100;
		2'b11 : out = 4'b1000;
		default : out = 4'b0000;
	endcase
end
endmodule
```
## Testbench for 2 to 4 Decoder
```
`timescale 1ns/1ps
module tb_decoder_2to4();
	reg [1:0] in;
	wire [3:0] out;
	
	decoder_2to4 dut(.in(in),.out(out));
	
	initial begin
		$display("**Decoder 2 to 4**");
		$monitor("in = %b, out = %b", in, out);

		in = 2'b00;
		#5 in = 2'b01;
		#5 in = 2'b10;
		#5 in = 2'b11;
		#5 in = 2'b00;
		#5 $stop;
	end
endmodule
```
## Schematics
`update later`
## Simulation on Modelsim 
<img src=https://i.imgur.com/fC61S95.png>

<a name="decoder3to8"></a>
# 3 to 8 Decoder
## The module
```
module decoder_3to8 (
	input [2:0] in,
	output reg [7:0] out
	);
always @(*) begin
	out = 8'b0000_0000;
	out[in] = 1'b1;
end
endmodule
```
## Testbench for 3 to 8 Decoder
```
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
```
## Schematic
`update later`
## Simulation on Modelsim
<img src=https://i.imgur.com/KiV74gl.png>

<a name="decoder4to16"></a>
# 4 to 16 Decoder and free SIZE
In this type of code, we can change the number D_SIZE to create different sizes of Decoder.
|D_SIZE|Type of Decoder|
|------|---------------|
|1|1 to 2|
|2|2 to 4|
|3|3 to 8|
|4|4 to 16|
|...|...|

In the example code below, we have D_SIZE = 4, we can change the number at **`define D_SIZE 4`**, and we will do the same thing on testbench if we want to change the SIZE of Decoder

## The module
```
// Decoder for all SIZE
// D_SIZE = 1 for 1to2 decoder
// D_SIZE = 2 for 2to4 decoder
// D_SIZE = 3 for 3to8 decoder
// and so far...
`define D_SIZE 4
module decoder_4to16(
	input [`D_SIZE-1:0] in,
	output reg [(1<<`D_SIZE)-1:0] out
	);
always @(*) begin
	out = '0;
	out[in] = 1'b1;
end
endmodule
```
## Testbench for 4 to 16 Decoder and free SIZE
```
`timescale 1ns/1ps
`define D_SIZE 4
module tb_decoder_4to16();
	reg [`D_SIZE-1:0] in;
	wire [(1<<`D_SIZE)-1:0] out;
	integer i;

	decoder_4to16 dut(.in(in),.out(out));
	initial begin
		$display("** Decoder %01d to %01d **", `D_SIZE,(1<<`D_SIZE));
		$monitor("in = %b, out = %b", in, out);
		for(i=0;i<(1<<`D_SIZE); i=i+1) begin
			in = i[`D_SIZE-1:0];
			#5;
		end
		$stop;
	end
endmodule
```
## Simulation on Modelsim
<img src=https://i.imgur.com/hqfL9la.png>

