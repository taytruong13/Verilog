# ALU 8-bit
An 8-bit ALU (Arithmetic Logic Unit) is a fundamentl component of microprocessors. It performs basic arithmetic and logical operations on 8-bit integers. These operations include addition, subtraction, multiplication, division, AND, OR, XOR, and comparisons,... The ALU acts as a small "brain", carrying out the necessary calculations for the computer to execute instructions. 

In this module, my design performs 16 Operations shown in the table below:

|Operation|dec|AlU Operation|
|:-------:|:-:|-------------|
|0000|0|Addiction: A + B|
|0001|1|Subtraction: A - B|
|0010|2|Multipication: A * B|
|0011|3|Division: A / B|
|0100|4|Logical shift left: A << 1|
|0101|5|Logical shift right: A >> 1|
|0110|6|A rotated left by 1|
|0111|7|A rotated right by 1|
|1000|8|Logical AND: A & B|
|1001|9|Logical OR: A \| B|
|1010|10|Logical XOR: A ^ B|
|1011|11|Logical NOR: ~(A\|B)|
|1100|12|Logical NAND: ~(A&B)|
|1101|13|Logical XNOR: ~(A^B)|
|1110|14|Greater comparison|
|1111|15|Equal comparison|

## The module in Verilog code
```
`define D_S 8 // Size of the AlU
module ALU_8bit(
	input [3:0] operation,
	input [`D_S-1:0] A,  // Input A
	input [`D_S-1:0] B,  // Input B
	output reg [2*`D_S-1:0] result,
	output reg carry_flag 
); 

always @(*) begin
	case(operation)
		4'b0000 : begin // Addition
			result = A + B;
			carry_flag = result[`D_S];
		end
		
		4'b0001 : begin // Subtraction 
			result = A - B;
			carry_flag = result[`D_S];
		end 
		
		4'b0010 :  // Multiplication
			result = A * B;
		4'b0011 :  // Division 
			result = A/B;
		4'b0100 :  // Logical shift left 
			result = A << 1;
		4'b0101 :  // Logical shift right 
			result = A >> 1;
		4'b0110 :  // Rotate left 
			result = {A[`D_S-2:0],A[`D_S-1]};
		4'b0111 :  // Rotate right
			result = {A[0],A[`D_S-1:1]};
		4'b1000 :  // Logical AND
			result = A & B;
		4'b1001 :  // Logical OR
			result = A | B;
		4'b1010 :  // Logical XOR
			result = A ^ B;
		4'b1011 :  // Logical NOR
			result = ~(A|B);
		4'b1100 :  // Logical NAND
			result = ~(A & B);
		4'b1101 :  // Logical XNOR
			result = ~(A ^ B);
		4'b1110 :  // Greater comparison
			result = (A>B) ? 'b1 : 'b0;
		4'b1111 :  // Equal comparison 
			result = (A==B) ? 'b1 : 'b0;
		default : 
			result = 'bx;
	endcase
end 
endmodule 
```

## Testbench for ALU 8-bit
```
`timescale 1ns/1ps
`define D_S 8  // design for ALU 8 bit
module tb_ALU_8bit ();
	reg [3:0] operation;
	reg [`D_S-1:0] A, B;
	wire [2*`D_S-1:0] result;
	wire carry_flag;
	
	ALU_8bit dut(.operation(operation),.A(A),.B(B),.result(result),.carry_flag(carry_flag));
	
// Clock generate 
	reg clk = 0;
always #5 clk = ~clk;

						
// test case
	integer i;
initial begin
	A = $urandom %((1<<`D_S)-1);
	B = $urandom %((1<<`D_S)-1);
	
	for(i=0;i<16;i=i+1) begin
		operation = i; #5;
		$display("Operation %b: A=%b, B=%b --> result=%b", operation, A, B, result);
		#5;
	end
end
endmodule 
```

## Simulation on ModelSim
<img src=https://i.imgur.com/aJ2AiaC.png>