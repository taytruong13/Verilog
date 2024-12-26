#Low-Power FSM (Finite State Machine)
Finite State Machines (FSMs) are used extensively in digital systems. By encoding state transitions with Gray Code, switching activity is minimized, leading to lower power consumption.
## Design Description
- **Module Name**: `low_power_fsm`
- **Functionality**: A 4-state FSM using Gray Code encoding. Each transition differs by only one bit, reducing switching power.
## Code Snippet
```
// Lower Power FSM
module low_power_fsm (
	input wire clk, rst, enable,
	output reg [1:0] state
);

	parameter 	S0 = 2'b00,
			S1 = 2'b01,
			S2 = 2'b11,// use gray code for states
			S3 = 2'b10;
always @(posedge clk or posedge rst) begin
	if(rst) 
		state <= S0;
	else if(enable) begin
		case (state)
			S0: state <= S1;
			S1: state <= S2;
			S2: state <= S3;
			S3: state <= S0;
			default: state <= S0;
		endcase
	end 
end 
endmodule 
```
## Testbench
```
`timescale 1ns/1ps
module tb_low_power_fsm();
    reg clk, rst, enable;
    wire [1:0] state;

    low_power_fsm uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .state(state)
    );

initial begin
	clk = 0;
	forever #5 clk = ~clk; // Clock generator 100MHz
end

initial begin
	rst = 1; enable = 0;
	#10 rst = 0; enable = 1; // Start FSM
	#40 enable = 0; // Pause FSM
	#20 enable = 1; // Resume FSM
	#40 $stop;
end

initial begin
	$monitor($time, " clk=%b rst=%b enable=%b state=%b", clk, rst, enable, state);
end
endmodule
```
## Simulation on ModelSim
<img src=https://i.imgur.com/OxV4fEj.png>