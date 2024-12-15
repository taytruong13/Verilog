### Contents
- [1-bit RAM Cell](#1bitram)
- [4-bit RAM](#4bitram)
- [8-bit RAM](#8bitram)
- 

=================================

<a name="1bitram"></a>
# 1-bit RAM Cell

A 1-bit Ram cell is the fundamental building block of random access memory (RAM). It can store one bit of data, meaning either a 0 or a 1. Essentially, a 1-bit RAM cell acts like a tiny electronics switch, which can be turned on (1) or off (0). To read or write to this cell, electrical signals are used to control the transistors within the cell. 

## The module in Verilog code
```
//1-Bit RAM Cell
module RAM_Cell(
	input wire write_en, write_data, read_en,
	output reg read_data
);
	reg memory_bit;
	always @(posedge write_en or posedge read_en) begin
		if(write_en)
			memory_bit <= write_data;
		else if(read_en)
			read_data <= memory_bit;
	end
endmodule 
```
## Testbench for 1-bit RAM cell
```
`timescale 1ns/1ps
module tb_RAM_cell();
	reg write_en, write_data, read_en;
	wire read_data;
	reg clk;
	
	RAM_Cell dut(.write_en(write_en), .write_data(write_data),
				.read_en(read_en), .read_data(read_data));
always #5 clk = ~clk;

initial begin
	clk = 0;
	write_en = 1'b0;
	write_data = 1'b0;
	read_en = 1'b0;
	
	write_en = 1'b1; write_data =1'b1; #10;
	write_en = 1'b0; read_en = 1'b1; #10;
	
	if (read_data)
		$display("Test Passed: Read Data is Correct");
	else
		$display("Test Failed: Read Data is Incorrect");
	
	$stop;
end
endmodule 
```
## Simulation on ModalSim
<img src=https://i.imgur.com/YBWnuKn.png>

<a name="4bitram"></a>
# 4-bit RAM
4-bit RAM is a memory unit tht can store 4 bits of data simultaneously. This means it can represent 16 different values (from `4'b0000` to `4'b1111` in binary).
Structurally, a 4-bit RAM cell is typically composed of 4 individual 1-bit RAM Cells. These cells operate independently but are controlled by the same clock and address signals. 

A 4-Bit RAM module is a digital memory component capable of storing and retrieving 4 bits of binary data. It typically has 16 memory locations, each capable of holding a 4-bit binary value. It supports read and write operations controlled by address selection and write/read enable signals, making it suitable for various applications requiring moderate storage capacity.

## The module in Verilog code
```

```
## Testbench for 4-bit RAM 
```

```
## Simulation on ModelSim
<img src=>