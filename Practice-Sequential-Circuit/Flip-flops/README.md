### Contents
- [SR Flip Flop](#SR_Flipflop)
- [JK Flip Flop](#JK_Flipflop)
- [D Flip FLop](#D_Flipflop)

<a name="SR_Flipflop"></a>
# SR Flip Flop
|Clock Edge| S | R | Q | Description |
|:---:| --- | --- | --- | --- |
| ↓ | X | X | Q | No Change (Store previous input)|
| ↑ | 0 | 0 | Q | No Change (Store previous input)|
| ↑ | 1 | 0 | 1 | Set Q to 1 |
| ↑ | 0 | 1 | 0 | Reset Q to 0 |
| ↑ | 1 | 1 | X | Invalid state |




## The module
```
module SR_ff_sync_rst(
	input clk, rst, S, R,
	output reg Q
);
always @(posedge clk) begin
	if(rst) Q <= 1'b0;
	else begin
	    case ({S, R})
		2'b10 : Q <= 1'b1;
		2'b01 : Q <= 1'b0;
		default : Q <= Q;
	    endcase
	end
end
endmodule
```
## Testbench for SR Flip flop sync with reset
```
`timescale 1ns/1ps
module tb_SR_ff_sync_rst ();
	reg clk, rst, S, R;
	wire Q;

	SR_ff_sync_rst dut(.clk(clk),.rst(rst),.S(S),.R(R),.Q(Q));

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	$display("** SR Flip flop sync with reset**");
	$monitor("At %t: S = %b, R = %b, rst = %b, Q = %b", $time, S, R, rst, Q);
	rst = 1; S = 0; R = 0;
	#15 rst = 0;
	#10 S = 1; R = 0;
	#10 S = 0; R = 1;
	#10 S = 0; R = 0;
	#10 $stop;
end
endmodule 
```

## Simulation on Modelsim 
<img src=https://i.imgur.com/I3c04uF.png>

<a name="JK_Flipflop"></a>
# JK Flip Flop
| J | K | Q(n+1) | State |
| --- | --- |:---:|:---:|
| 0 | 0 | Qn | No Change |
| 0 | 1 | 0 | RESET |
| 1 | 0 | 1 | SET |
| 1 | 1 | Qn’ | TOGGLE |

## The module
```
module jk_ff(
	input clk, j, k,
	output reg Q
);
always @(posedge clk) begin
	case ({j,k})
		2'b00 : Q <= Q;
		2'b01 : Q <= 1'b0;
		2'b10 : Q <= 1'b1;
		2'b11 : Q <= ~Q;
	endcase
end
endmodule
```
## Testbench for JK Flip FLop 
```
`timescale 1ns/1ps
module tb_jk_ff();
	reg clk, j, k;
	wire Q;

	jk_ff dut(.clk(clk),.j(j),.k(k),.Q(Q));

always #5 clk = ~clk;

initial begin
	$monitor("At %07t: j = %b, k = %b, Q = %b", $time, j, k, Q);

	clk = 0; j = 0; k = 0;
	#10 j = 1; k = 0; // set
	#10 j = 0; k = 1; // Reset
	#10 j = 1; k = 1; // Toggle
	#10 j = 0; k = 0; // No change
	#10 $stop;
end
endmodule 
```
## Simulation on Modelsim
<img src=https://i.imgur.com/Y2wQbdK.png>

<a name="D_Flipflop"></a>
# D Flip FLop 
| CLOCK | D | Q | Qbar |
|:---:| --- |:---:|:---:|
| 0 | 0 | NO CHANGE | NO CHANGE |
| 0 | 1 | NO CHANGE | NO CHANGE |
| 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 0 |

## The module
```
module D_ff(
	input clk, D,
	output reg Q, 
	output Qbar
);
    always @(posedge clk) begin
	Q <= D;
    end

    assign Qbar = ~Q;

endmodule
```
## Testbench for D Flip FLop
```
`timescale 1ns/1ps
module tb_D_ff();
	reg clk, D;
	wire Q, Qbar;
	
	D_ff dut(.clk(clk),.D(D),.Q(Q),.Qbar(Qbar));

	always #5 clk = ~clk;

	initial begin
		$display("** D Flip Flop **");
		$monitor("At %06t: D = %b, Q = %b, Qbar = %b", $time, D, Q, Qbar);
		clk = 0;
		#10 D = 0;
		#10 D = 1;
		#10 D = 0;
		#10 $stop;
	end
endmodule
```
## Simulation on Modelsim 
<img src=https://i.imgur.com/y4RZz3y.png>










