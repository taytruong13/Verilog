# 1001 Moore Sequence Detector
In Moore Machine, output only depens on the present state. It is dependent of current input. 

This program uses a Finite State Machine (FSM) to detect the desired sequence.
The states represent the progress of detecting each bit of the sequence 1101. When the sequence 1101 is detected, the detected output is activated.
I also write code for Shift register to detect 1101 sequence (in the below), you can use the same testbench to check how it work and how FSM is better.
|State|Description|
|:---:|:---------:|
|IDLE|Initial state, waiting for bit 1|
|S1|First bit received
|S11|Two consecutive bits 1 received|
|S110|Received 110, waiting for the last bit 1 to be received|
|DETECTED|Detected the sequence 1101|

## The module in Verilog code
```
module FSM_Moore_detector(
	input clk, rst,
	input in_bit,
	output reg detected
);

// Define states using parameter 
parameter IDLE	= 3'b000;
parameter S1 	= 3'b001;
parameter S11 	= 3'b010;
parameter S110 	= 3'b011;
parameter DETECTED = 3'b100;

// Declare state variables 
reg [2:0] current_state, next_state;

// Sequential Logic for state transitions
always @(posedge clk or posedge rst) begin
	if(rst)
		current_state <= IDLE; // Reset to initial states
	else
		current_state <= next_state; // Move to next state 
end

// Combinational logic for state transitions and output 
always @(*) begin
	// Default values
	next_state = current_state;
	detected  = 1'b0;
	
	case (current_state)
		IDLE: begin
			if(in_bit)  // in_bit 1
				next_state = S1; // Move to state S1 if bit 1 is received 
		end
		
		S1: begin
			if(in_bit)  // in_bit 1
				next_state = S11; // Move to S11 if bit 1 is received 
			else
				next_state = IDLE; // Return to IDLE if bit 0
		end
		
		S11: begin 
			if(~in_bit) // in_bit 0
				next_state = S110; // Move to S110 if bit 0 is received 
			else
				next_state = S11;  // Stay in S11 if in_bit 0
		end 
		
		S110: begin
			if(in_bit)
				next_state = DETECTED; // Move to DETECTED if bit 1 is received
			else 
				next_state = IDLE; // Return to IDLE if bit 0;
		end 
		
		DETECTED: begin 
			detected = 1'b1; // Output is 1 when sequence 1101 is detected 
			if(in_bit)
				next_state = S1; // Continue to detect next sequence 
			else
				next_state = IDLE; // Return to IDLE
		end
		
		default: next_state = IDLE; // Default case
	endcase
end
endmodule 
```
## Module in Verilog for Shift Register detector 1101
```
// if you want to test with Shift Register, use this code below
module shift_detector_1101 (
	input clk, rst, in_bit,
	output reg detected
);
	reg [3:0] sequence;
always @(posedge clk or posedge rst) begin
	if(rst)begin
		sequence <= 4'b0000;
		detected <= 1'b0;
	end else begin
		sequence = sequence >> 1;
		sequence[3] = in_bit;
		detected = (sequence == 4'b1101) ? 1'b1 : 1'b0;
	end
end 
endmodule 
```
_(the simulation showed below)_

## Testbench for 1101 Detector 
In the testbench here, I use the sequence 1101101101 to demonstrate that we should use a Finite State Machine to detect separately 1101 sequences. If we use the Shift register and AND gates component, the circuit will detect three 1101s in the sequence. When using FSM, only two times 1101 appear in the 1101101101. 

```
`timescale 1ns/1ps
module tb_FSM_Moore_detector ();
	reg clk, rst;
	reg in_bit;
	wire detected;
	
	// Instantiate the module 
	FSM_Moore_detector dut(.clk(clk),.rst(rst),.in_bit(in_bit),.detected(detected));
	
	// Clock generation
always #5 clk = ~clk;

	// Test sequence 1101
initial begin
	clk = 0;
	rst = 1;
	in_bit = 0;
	#10 rst = 0;
	
	// Input sequence: 1101101101
	#10 in_bit = 1; // 1
	#10 in_bit = 1; // 11
	#10 in_bit = 0; // 110
	#10 in_bit = 1; // 1101 -> Detected
	#10 in_bit = 1; // 1
	#10 in_bit = 0; // 10 -> IDLE
	#10 in_bit = 1; // 1
	#10 in_bit = 1; // 11
	#10 in_bit = 0; // 110
	#10 in_bit = 1; // 1101 -> Detected
	
	#50 $stop;
end
endmodule
```

## Simulation on ModelSim
### FSM 1101 Detector 
<img src=https://i.imgur.com/LZEZr7E.png>
### Shift Register 1101 Detector
<img src=https://i.imgur.com/mDJfZwx.png>