### Contents
- [SR Latch](#SR_latch)
- [D Latch](#D_latch)

<a name="SR_latch"></a>
# SR Latch
## The module
```
module SR_latch(
	input S, R, 
	output reg Q, Qbar
	);
	always @(posedge S or posedge R) begin
		if(R) begin
			Q <= 1'b0;
			Qbar <= 1'b1;
		end else if (S) begin
			Q <= 1'b1;
			Qbar <= 1'b0;
		end
	end
endmodule 
```
## Testbench for SR Latch
```
`timescale 1ns/1ps
module tb_SR_latch();
	reg S, R;
	wire Q, Qbar;
	SR_latch dut(.S(S),.R(R),.Q(Q),.Qbar(Qbar));

	initial begin
		$display("** SR Latch **");
		$monitor("S = %b, R = %b --> Q = %b, Qbar = %b", S, R, Q, Qbar);
		S = 0; R = 0;
		#5 S = 1; R = 0;
		#5 S = 0; R = 1;
		#5 S = 0; R = 0;
		#5 $stop;
	end
endmodule
```
## Schematics
`update later`
## Simulation on Modelsim 
<img src=https://i.imgur.com/oCXB5pe.png>

<a name="D_latch"></a>
# D Latch
## The module
```
module d_latch(
	input D, En,
	output reg Q, Qbar
	);
	always @(En) begin
		if (En) begin
			Q <= D;
			Qbar <= ~D;
		end
	end
endmodule
```
## Testbench for 3 to 8 Decoder
```
`timescale 1ns/1ps
module tb_D_latch();
	reg D, En;
	wire Q, Qbar;
	// Instantiated the unit under test
	d_latch dut(.D(D),.En(En),.Q(Q),.Qbar(Qbar));
	
	initial begin
		$display("** D Latch **");
		$monitor("D = %b, En = %b, Q = %b, Qbar = %b", D, En, Q, Qbar);
		D = 0; En = 0;
		#5 D = 1; En = 0;
		#5 En = 1;
		#5 D = 0;
		#5 En = 0;
		#5 $stop;
	end
endmodule 
```
## Simulation on Modelsim
<img src=https://i.imgur.com/jyBX1va.png>
