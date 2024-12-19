# 1010 Mealy Sequence Detector
In Mealy Machine, output depens on the present state and input.

This program uses a Finite State Machine (FSM) to detect the desired sequence.
The states represent the progress of detecting each bit of the sequence 1101. When the sequence 1101 is detected, the detected output is activated.
|State|Description|
|:---:|:---------:|
|S0|Initial state, waiting for bit 1|
|S1|First bit received
|S2|Received bit 0|
|S3|Received 101, waiting for the last bit 0 to be received|
|S4|Detected the sequence 1010|

## The module in Verilog code
```
module FSM_Mealy_detector(
	input din, clk, rst,
	output reg dout
);
	reg [1:0] current_state, next_state;
	
	parameter 	S0 = 2'b00,
				S1 = 2'b01,
				S2 = 2'b10,
				S3 = 2'b11;
always @(posedge clk or posedge rst) begin
	if(rst)
		current_state <= S0;
	else
		current_state <= next_state;
end 

always @(current_state or din) begin
	case (current_state)
		S0: begin
			if(din) begin
				next_state = S1;
				dout = 1'b0;
			end else begin
				next_state = S0;
				dout = 1'b0;
			end
		end 
		
		S1: begin
			if(~din) begin
				next_state = S2;
				dout = 1'b0;
			end else begin 
				next_state = S1;
				dout = 1'b0;
			end 
		end 
		
		S2: begin
			if(din) begin
				next_state = S3;
				dout = 1'b0;
			end else begin 
				next_state = S2;
				dout = 1'b0;
			end 
		end 
		
		S3: begin 
			if(~din) begin 
				next_state = S0;
				dout = 1'b1;
			end else begin 
				next_state = S1;
				dout = 1'b0;
			end 
		end 
		
		default: next_state = S0;
	endcase
end 
endmodule 
```

## Testbench for 1010 Detector 
```
`timescale 1ns/1ps
//Detect 1010 sequence 

module tb_FSM_Mealy_detector();
	reg din, clk, rst;
	wire dout;

	FSM_Mealy_detector dut(.din(din),.clk(clk),.rst(rst),.dout(dout));

always #5 clk = ~clk;

initial begin
	din = 0;
	clk = 0;
	rst = 1;
	
	#10 rst = 0;
	din = 1; #10;
	din = 0; #10;
	din = 1; #10;
	din = 0; #10;
	din = 1; #10;
	$stop;
end
endmodule
```

## Simulation on ModelSim
<img src=https://i.imgur.com/kCNg9z8.png>