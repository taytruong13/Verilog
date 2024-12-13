# 4 Bit Comparator
## The module
```
module comparator_4bit(
	input [3:0] inA, inB,
	output A_eq_B, A_lt_B, A_gt_B
);
	wire [4:0] diffAB;
	assign diffAB = inA - inB;
	assign A_gt_B = ~diffAB[4];
	assign A_lt_B = diffAB[4];
	assign A_eq_B = ~(|diffAB);

endmodule 
```
## Testbench for 4 Bit Comparator
```
`timescale 1ns/1ps
module tb_comparator_4bit();
	reg [3:0] inA, inB;
	wire A_eq_B, A_lt_B, A_gt_B;
	integer i;

	comparator_4bit dut(.inA(inA),.inB(inB),
				.A_eq_B(A_eq_B),.A_lt_B(A_lt_B),.A_gt_B(A_gt_B));
	
	initial begin
		$display("** 4 Bit Comparator **");
		$monitor("A = %b, B = %b --> [equal,less,greater] = [%b,%b,%b]", inA, inB,A_eq_B, A_lt_B, A_gt_B);
		inA = 4'b0000; inB = 4'b0000;
		#10 inA = 4'b0111;
		for(i = 0; i < 16; i= i+1) begin
			inB = i;
			#10;
		end
		$stop;
	end
endmodule 
```

## Simulation on Modelsim 
<img src=https://i.imgur.com/2rN2nwc.png>
