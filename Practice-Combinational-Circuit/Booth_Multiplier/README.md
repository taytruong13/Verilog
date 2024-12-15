# Booth Multiplier 
First, we need to understand the priciple of this Booth algorithm with the diagram below:
<img src=https://i.imgur.com/jS8RTzb.png>
## The module
```
`define D_SIZE 4
//Calculate:  M x Q = Product 
module booth_multi #(parameter Size = `D_SIZE)(
	input signed [Size-1:0] M, Q,  
	output signed [2*Size-1:0] Product
	);
	genvar g;
	wire signed [Size-1:0] A [0:Size];
	wire signed [Size-1:0] Qt [0:Size];
	wire q_1 [Size-1:0];
	
	//initiative value
	assign q_1[0] = 1'b0;
	assign A[0] = 'b0;
	assign Qt[0] = Q;
					
	generate
		for(g=0;g<=Size;g=g+1) begin : booth_loop
			booth_unit #(Size) bu(
				.q_1(q_1[g]),
				.M(M),
				.A(A[g]),
				.Q(Qt[g]),
				//output
				.At(A[g+1]),
				.Qt(Qt[g+1]),
				.q_1out(q_1[g+1]));
		end
	endgenerate

	assign Product = {A[Size],Qt[Size]};
endmodule 
	
// Booth unit for each step of counter
module booth_unit #(parameter Size = `D_SIZE)(
	input q_1,
	input [Size-1:0] M, A, Q,
	output reg [Size-1:0] At, Qt,
	output reg q_1out
	);
	wire [Size-1:0] Add, Sub;
	wire [1:0] qq_1;
	assign qq_1 = {Q[0], q_1};
	Adder #(Size) adder_u(.inA(A),.inB(M),.SumAB(Add));
	Subtractor #(Size) sub_u(.inA(A),.inB(M),.DiffAB(Sub));
	
always @(*) begin 
	case (qq_1)
		2'b00, 
		2'b11 : {At,Qt,q_1out} = {A[Size-1],A,Q};
		2'b10 : {At,Qt,q_1out} = {Sub[Size-1],Sub,Q};
		2'b01 : {At,Qt,q_1out} = {Add[Size-1],Add,Q};
	endcase
end
endmodule

// Adder for Q0Q-1 = 01
module Adder #(parameter Size = `D_SIZE) (
	input [Size-1:0] inA, inB,
	output [Size-1:0] SumAB
	);
	assign SumAB = inA + inB;
endmodule 

// Subtractor for Q0Q-1 = 10
module Subtractor #(parameter Size = `D_SIZE) (
	input [Size-1:0] inA, inB,
	output [Size-1:0] DiffAB
	);
	assign DiffAB = inA - inB;
endmodule 
```
## Testbench for Booth Multiplier
```
`timescale 1ns/1ps
`define D_SIZE 4
module tb_booth_multi();
	reg signed [`D_SIZE-1:0] M, Q;
	wire signed [2*`D_SIZE-1:0] Product;
	
	booth_multi #(`D_SIZE) dut(.M(M),.Q(Q),.Product(Product));
	
initial begin
	$monitor("M x Q = %b x %b = %b = (dec) %02d x %02d = %03d", M, Q, Product, M, Q, Product);
	M = 4'b0101; Q = 4'b0110; #10;
	M = 4'b1100; Q = 4'b0011; #10;
	M = 4'b1101; Q = 4'b1001; #10;
	M = 4'b1001; Q = 4'b0111; #10;
	$stop;
end
endmodule
```
## Simulation on Modelsim 
<img src=https://i.imgur.com/pPxEFxB.png>