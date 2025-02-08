### Content
- [1x2 Demux](#Demux_1x2)
- [1x4 Demux](#Demux_1x4)
- [1x8 Demux with generate](#Demux_1x8_generate)

=======================================

<a name="Demux_1x2"></a>
# 1x2 Demux
## The module
```Verilog
module demux_1x2 (
	input wire din, 
	input wire sel, 
	output wire dout_0,
	output wire dout_1
	);
	
	assign dout_0 = (~sel) ? din : 1'b0;
	assign dout_1 = (sel) ? din : 1'b0;

endmodule
```
## Testbench for 1x2 Demux
```Verilog
`timescale 1ns/1ps
module tb_demux_1x2();
	reg din;
	reg sel;
	wire dout_0;
	wire dout_1;
	
	demux_1x2 dut(.din(din),.sel(sel),.dout_0(dout_0),.dout_1(dout_1));
	
	initial begin 
		$monitor("din = %b, sel = %b, dout_0 = %b, dout_1 = %b", din, sel, dout_0, dout_1);
	end 
	
	initial begin 
			din = 1'b0; sel = 1'b0; 
		#5	din = 1'b0; sel = 1'b1; 
		#5 	din = 1'b1; sel = 1'b0;
		#5 	din = 1'b1; sel = 1'b1;
		#5	din = 1'b0; sel = 1'b0;
		#5 $stop;
	end
endmodule
```
## Schematics
`update later`
## Simulation on Modelsim 
<img src=https://i.imgur.com/MmvKlKr.png>

<a name="Demux_1x4"></a>
# 1x4 Demux
## The module
```Verilog
module demux_1x4(
	input wire din, 
	input wire [1:0] sel,
	output wire dout_0, dout_1, dout_2, dout_3
);
	assign dout_0 = (sel == 2'b00) ? din : 1'b0;
	assign dout_1 = (sel == 2'b01) ? din : 1'b0;
	assign dout_2 = (sel == 2'b10) ? din : 1'b0;
	assign dout_3 = (sel == 2'b11) ? din : 1'b0;
endmodule
```
## Testbench for 1x4 Demux
```Verilog
`timescale 1ns/1ps
module tb_demux_1x4();
	reg din;
	reg [1:0] sel;
	wire dout_0, dout_1, dout_2, dout_3;
	integer i;

	demux_1x4 dut(.din(din),.sel(sel),
			.dout_0(dout_0),.dout_1(dout_1),.dout_2(dout_2),.dout_3(dout_3));
	// Monitor
	initial begin
		$monitor("din = %b, sel = %b, dout[3-0] = %b", din, sel, {dout_3, dout_2, dout_1, dout_0});
	end
	
	initial begin
		din = 1'b0; sel = 2'b00;
		#5;
		din = 1'b1;
		for(i = 0; i<4; i=i+1) begin
			sel = i; 
			#5;
		end
		sel = 2'b0;
		#5 $stop;
	end
endmodule
```
## Schematic
`update later`
## Simulation on Modelsim
<img src=https://i.imgur.com/HbCJCCs.png>

<a name="Demux_1x8_generate"></a>
# 1x8 Demux with generate function
## The module
```Verilog
// 1x8 demux
// 1x2mux|SIZE=1; 1x4mux|SIZE=2; 1x8mux|SIZE=3; 1x16mux|SIZE=4...
module demux_1x8 #(parameter SIZE=3) (
	input wire din,
	input wire [SIZE-1:0] sel,
	output wire [(1<<SIZE)-1:0] dout
	);
	genvar g;
	generate 
		for(g=0; g<(1<<SIZE); g=g+1) begin : gen_demux //named generate block
			assign dout[g] = (sel == g[SIZE-1:0]) ? din : 1'b0;
		end
	endgenerate
endmodule
```
## Testbench for 1x8 Demux
```Verilog
//Testbend for Demux SIZE = 3 (1x8)
`define D_SIZE 3
module tb_demux_1x8();
	reg din;
	reg [`D_SIZE-1:0] sel;
	wire [(1<<`D_SIZE)-1:0] dout;
	integer i;
	
	demux_1x8 #(`D_SIZE) dut(.din(din),.sel(sel),.dout(dout));
	
	initial begin
		$monitor("din = %b, sel = %d, dout[%01d-0] = %b", din, sel, ((1<<`D_SIZE)-1), dout);
	end
	
	initial begin
		din = 1'b0; 
		sel = 0;
		#5;
		din = 1'b1;
		for(i=0; i<(1<<`D_SIZE); i=i+1) begin
			sel = i[(1<<`D_SIZE)-1:0];
			#5;
		end
		din = 1'b0;
		sel = 0;
		#5 $stop;
	end
endmodule 
```
## Schematic
`update later`
## Simulation on Modelsim 
<img src=https://i.imgur.com/DOSVWf2.png>

