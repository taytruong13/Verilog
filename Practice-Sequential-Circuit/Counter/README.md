### Contents
- [Ring Counter](#ringcounter)
- [Johnson Counter](#johnsoncounter)
- [Gray Counter](#graycounter)

=========================================
<a name="ringcounter"></a>
# Ring Counter 
## The module
```
module ring_counter #(parameter N = 4) (
	input clk, rst,
	output reg [N-1:0] q
);
// Initail value: set the most significant bit to 1
initial begin
	q <= 1'b1 << (N-1);
end

// shirt register logic
always @(posedge clk or posedge rst) begin 
	if(rst) begin
		// reset the counter to initial state
		q <= 1'b1 << (N-1);
	end else begin
		// Shirt all bít one positon to the right
		q <= {q[0], q[N-1:1]};
	end
end
endmodule
```
## Testbench for Ring Counter
```
`timescale 1ns/1ps
`define D_SIZE 4
module tb_ring_counter();
	reg clk, rst;
	wire [`D_SIZE-1:0] q;
	
	ring_counter #(`D_SIZE) dut(.clk(clk),.rst(rst),.q(q));

always #5 clk = ~clk;

initial begin
	clk = 1'b0;
	rst = 1'b1;
	#10 rst = 1'b0;
end

initial begin
	$monitor("At %06t, clk=%b, rst=%b, q=%b", $time, clk, rst, q);
	#50 $stop;
end
endmodule
```
## Simulation on Modelsim 
<img src=https://i.imgur.com/Ffl31rl.png>

<a name="johnsoncounter"></a>
# Johnson Counter
## The module
```
module johnson_counter #(parameter N = 4) (
	input clk, rst,
	output reg [N-1:0] q
);
// Initial value: set the MSB to 1
initial begin
	q <= 1'b1 << (N-1);
end

// shift register logic
always @(posedge clk or posedge rst) begin
	if(rst) q <= 1'b1 << (N-1);
	else q <= {~q[0], q[N-1:1]};
end 
endmodule
```
## Testbench for Johnson Counter
```
`timescale 1ns/1ps
`define D_SIZE 4
module tb_johnson_counter();
	reg clk, rst;
	wire [`D_SIZE-1:0] q;

	johnson_counter #(`D_SIZE) dut(.clk(clk),.rst(rst),.q(q));
// Generate clock
always #5 clk = ~clk;
//reset signal
initial begin
	clk = 1'b0;
	rst = 1'b1;
	#10 rst = 1'b0;
end

initial begin
	$monitor("At %06t: clk=%b, rst=%b, q=%b", $time, clk, rst, q);
	#100 $stop;
end
endmodule
```
## Simulation on ModelSim 
<img src=https://i.imgur.com/v01zjgP.png>

<a name="graycounter"></a>
# Gray Counter
We can easily change the Size of the Gray Counter with ``` `define D_SIZE``` in the Testbench.

## The module
```
module gray_counter #(parameter N = 4)(
	input clk, rst,
	output [N-1:0] gray_count
);
	reg [N-1:0] bin_count;
	bin_to_gray #(N) btg(.bin(bin_count),.gray(gray_count));
	always @(posedge clk or posedge rst) begin
		if(rst) bin_count <= 'b0;
		else bin_count <= bin_count + 1;
	end
endmodule 

module bin_to_gray #(parameter SIZE = 4)(
	input [SIZE-1:0] bin,
	output [SIZE-1:0] gray
);
	assign gray[SIZE-1] = bin[SIZE-1];
	genvar g;
	generate
		for(g=SIZE-2; g>=0; g=g-1) begin : cal_gray_bits
			assign gray[g] = bin[g+1]^bin[g];
		end
	endgenerate
endmodule 
			
```
## Testbench for Gray counter
```
`timescale 1ns/1ps
`define D_SIZE 4

module tb_gray_counter();
	reg clk, rst;
	wire [`D_SIZE-1:0] gray_count;
	
	gray_counter #(`D_SIZE) dut(.clk(clk),.rst(rst),.gray_count(gray_count));
	
always #5 clk = ~clk;
initial begin 
	clk = 0; 
	rst = 1;
	#5 rst = 0;
end
initial begin
	$monitor("At %06t: counter = %02d = %b", $time, gray_count, gray_count);
	#200 $stop;
end
endmodule
```
## Simulation on ModelSim
<img src=https://i.imgur.com/vPcWkwE.png>
