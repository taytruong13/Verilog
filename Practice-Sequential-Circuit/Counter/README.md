### Contents
- [Ring Counter](#ringcounter)
- [Johnson Counter](#johnsoncounter)
- [xx](#xx)
- [Bidirectioanl Shift Register](#bidir)

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
