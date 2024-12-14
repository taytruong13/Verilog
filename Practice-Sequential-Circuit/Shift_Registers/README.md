### Contents
- [SISO Shift Register](#siso)
- [SIPO Shift Register Free SIZE](#sipo)

<a name="siso"></a>
# Serial In Serial Out (SISO) Shift Register
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
