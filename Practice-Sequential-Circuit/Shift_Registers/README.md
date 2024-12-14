### Contents
- [SISO Shift Register](#siso)
- [SIPO Shift Register Free SIZE](#sipo)
- [PISO Shift Register Free SIZE](#piso)
- [Bidirectioanl Shift Register](#bidir)

<a name="siso"></a>
# Serial In Serial Out (SISO) Shift Register 4bit
## The module
```
// Serial in Serial Out (SISO) Shirt Register 
module siso_shift_reg(
	input clk, serial_in,
	output serial_out
);
	reg [3:0] shift_reg;	
always @(posedge clk) begin
	shift_reg[0] <= serial_in; // Data shift from right to left
	shift_reg[1] <= shift_reg[0];
	shift_reg[2] <= shift_reg[1];
	shift_reg[3] <= shift_reg[2];
end
```
## Testbench for SISO
```
`timescale 1ns/1ps
module tb_siso_shift_reg();
	reg clk, serial_in;
	wire serial_out;
	
	siso_shift_reg dut(.clk(clk),.serial_in(serial_in),.serial_out(serial_out));
	
always #5 clk = ~clk;

initial begin
	clk = 0;
	serial_in = 0;
	$display("** SISO shift Register **");
	$monitor("At %06t: [Serial_in, Serial_out] = [%b, %b]", $time, serial_in, serial_out);
	
	#10 serial_in = 1'b1;
	#10 serial_in = 1'b1;
	#10 serial_in = 1'b0;
	#10 serial_in = 1'b1;
	#10 serial_in = 1'b0;
	#50 $stop;
end
endmodule
```

## Simulation on Modelsim 
<img src=https://i.imgur.com/GUOXDxs.png>

<a name="sipo"></a>
# Serial in Parallel Out (SIPO) Shift Register - Free SIZE
In this version of code, I use the variable `D_SIZE` to create a changable size of SIPO.
Then I use the `generate` function to create `always` blocks for each register's bit. 

## The module with `generate` function
```
// Serial in Parallel Out  - SIPO - shift register
// Change size number for another size of SIPO
`define D_SIZE 4
module sipo_shift_reg(
	input clk, rst, serial_in,
	output [`D_SIZE-1:0] parallel_out
);
	reg [`D_SIZE-1:0] shift_reg;
	genvar g;
	// Generate register instance
	always @(posedge clk or posedge rst) begin
		if(rst) shift_reg <= 'b0;
		else shift_reg[0] <= serial_in;
	end
	
	generate 
		for(g=1;g<`D_SIZE;g=g+1) begin : reg_inst
			always @(posedge clk or posedge rst) begin 
				if(~rst) shift_reg[g] <= shift_reg[g-1];
			end
		end
	endgenerate
	assign parallel_out = shift_reg;
endmodule 
```
## The module 4bit SIPO
If you don't want to use `generate` function, with 4bit SIPO, you can use the code below: 
```
module sipo_shift_reg (
    input clk, rst, serial_in,
    output [3:0] parallel_out
);

    reg [3:0] shift_reg;

always @(posedge clk or posedge rst) begin
    if (rst) shift_reg <= 4'b0000;
    else begin
        shift_reg[0] <= serial_in;
        shift_reg[1] <= shift_reg[0];
        shift_reg[2] <= shift_reg[1];
        shift_reg[3] <= shift_reg[2];
    end
end
assign parallel_out = shift_reg;

endmodule
```
## Testbench for SIPO 
```
`timescale 1ns/1ps
`define D_SIZE 4 // change this number for another size of SIPO Shift Register
module tb_sipo_shift_reg();
	reg clk, rst, serial_in;
	wire [`D_SIZE-1:0] parallel_out;

	sipo_shift_reg dut(.clk(clk),.rst(rst),.serial_in(serial_in),.parallel_out(parallel_out));
// Clock generate:
always #5 clk = ~clk;
// 
initial begin
	clk = 0;
	serial_in = 0;
	rst = 1;
	$display("** %0d Bit SIPO Shift Register **", `D_SIZE);
	$monitor("At %06t: serial_in = %b, Parallel_out = %b", $time, serial_in, parallel_out);
	#20 rst = 0;
	#10 serial_in = 1;
	#10 serial_in = 0;
	#10 serial_in = 1;
	#20 serial_in = 0;
	#10 serial_in = 1;
	#10 serial_in = 0;
	#10 $stop;
end
endmodule
```
## Simulation on ModelSim 
<img src=https://i.imgur.com/UpZJGUj.png>

<a name="piso"></a>
# Parallel In Serial Out (PISO) Shift Register
Like SIPO module I have presented above, in the module of PISO (parallel in and serial out) here, you can also change the size of the module with the number of ``` `define D_SIZE ```. 
## PISO free size module with `generate` function
```
// Parallel In Serial Out PISO shift register
`define D_SIZE 4
module piso_shift_reg(
	input clk, rst, enIn,
	input [`D_SIZE-1:0] parallel_in,
	output serial_out
);
	reg [`D_SIZE-1:0] shift_reg;
	genvar g;

always @(posedge clk or posedge rst) begin // asynchronous reset
	if(rst) shift_reg <= 'b0;
	else if(enIn) shift_reg <= parallel_in;
	else shift_reg[`D_SIZE-1] <= 1'b0; //shift from left to right
end

//generate other shift_reg
generate
	for(g=`D_SIZE-2; g>=0; g=g-1) begin : reg_inst
	   always @(posedge clk or posedge rst) begin
		if(~rst&~enIn) shift_reg[g] <= shift_reg[g+1];
	   end
	end
endgenerate

assign serial_out = shift_reg[0];
endmodule 
```
## Testbench for PISO shift register
```
`timescale 1ns/1ps
`define D_SIZE 4
module tb_piso_shift_reg();
	reg clk, rst, enIn;
	reg [`D_SIZE-1:0] parallel_in;
	wire serial_out;

	piso_shift_reg dut(.clk(clk),.rst(rst),.enIn(enIn),.parallel_in(parallel_in),.serial_out(serial_out));
// Generate clk
always #5 clk = ~clk;

initial begin
	$display(" ** %0d Parallel In Serial Out ** ",`D_SIZE);
	$monitor("At %06t: Parallel = %b, enIn = %b, serial_out = %b", $time, parallel_in, enIn, serial_out);
	clk = 0;
	rst = 0; enIn = 0;
	#10 rst = 1;
	#10 rst = 0; parallel_in = $urandom & ((1<<`D_SIZE)-1);
	#10 enIn = 1;
	#10 enIn = 0; parallel_in = $urandom & ((1<<`D_SIZE)-1);
	#50 enIn = 1;
	#10 enIn = 0;
	#50 $stop;
end
endmodule 
```
## Simulation on ModelSim
<img src=https://i.imgur.com/tkodkxs.png>

<a name="pipo"></a>
# Parallel In Parallel Out (PIPO) Register
## The module
```
//parallel in parallel out shift register
`define D_SIZE 4
module pipo_shift_reg(
	input clk,
	input [`D_SIZE-1:0] din,
	output reg [`D_SIZE-1:0] dout
	);

always @(posedge clk) begin
	dout = din;
end
endmodule
```
## Testbench for PIPO
```
`timescale 1ns/1ps
`define D_SIZE 4
module tb_pipo_shift_reg();
	reg clk;
	reg [`D_SIZE-1:0] din;
	wire [`D_SIZE-1:0] dout;
	
	pipo_shift_reg dut(.clk(clk),.din(din),.dout(dout));
	
always #5 clk = ~clk;
initial begin
	$monitor("Input = %b, Output = %b", din, dout);
	clk = 0;
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#10 din = $urandom & ((1<<`D_SIZE)-1); 
	#30 $stop;
end
endmodule
```
## Simulation on ModelSim
<img src=https://i.imgur.com/UthOgFa.png>

<a name="bidir"></a>
# Bidirectional Shift Register
## The Module 
```
//Bidirectional Shift Register
`define D_SIZE 4
module  bidir_shift_reg(
	input clk, in, en, dir, rst,
	output reg [`D_SIZE-1:0] out
);

always @(posedge clk or posedge rst) begin
	if(rst) out <= 'b0;
	else if(en) begin
		case (dir)
			1'b0 : out <= {out[`D_SIZE-2:0], in}; //shift to left 
			1'b1 : out <= {in, out[`D_SIZE-1:1]}; //shift to right
		endcase
	end else out <= out;
end
endmodule
```
## Testbench for Bidirectional shift register
```
`timescale 1ns/1ps
`define D_SIZE 4
module tb_bidir_shift_reg();
	reg clk, in, en, dir, rst;
	wire [`D_SIZE-1:0] out;
	
	bidir_shift_reg dut(.clk(clk),.in(in),.en(en),.dir(dir),.rst(rst),.out(out));
//clock generate
always #5 clk = ~clk;
initial begin
	$monitor("in=%b en=%b dir=%b rst=%b out=%b", in, en, dir, rst, out);
	clk = 0;
	rst = 0;
	en = 0;
	dir = 0;
	in = 0;
	#5;
	rst = 1;
	#10 rst = 0; en = 1;
	repeat (8) begin
		#10 in = $random;
	end
	
	dir = 1;
	repeat (8) begin
		#10 in = $random;
	end
	#20 $stop;
end 
endmodule
```
## Simulation on ModelSim
<img src=https://i.imgur.com/vf40Wgb.png>
