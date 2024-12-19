# PWM Generator
A PWM (Pulse Width Modulation) Generator is a circuit that produces a digital signal with a varying pulse width. It is commonly used in applications such as motor speed controlm LED dimming, and audio synthesis.
the percentage of time in which the PWM signal remains HIGH (ON time) is called duty cycle. If the signal is always ON, it is in 100% duty cycle and if it is always off, it is 0% duty cycle. 
`Duty cycle = Turn ON time/(Turn ON time + Turn OFF time)`

## The module in Verilog code
```
module PWM(
	input clk,
	input [7:0] duty, // Duty cycle = Turn ON time / (Turn ON time + Turn OFF time)
	output reg out
);

	reg [7:0] count;
initial begin
	count = 8'b0;
end
	
always @(posedge clk) begin
	count = count + 1;
	out = (count <= duty) ? 1 : 0;
end 
endmodule 
```

## Testbench for PWM generator 
```
`timescale 1ns/1ps
module tb_PWM();
	reg clk;
	reg [7:0] duty[0:3];
	wire out [0:3];
	
	PWM dut0(.clk(clk),.duty(duty[0]),.out(out[0]));
	PWM dut1(.clk(clk),.duty(duty[1]),.out(out[1]));
	PWM dut2(.clk(clk),.duty(duty[2]),.out(out[2]));
	PWM dut3(.clk(clk),.duty(duty[3]),.out(out[3]));
	
always #1 clk = ~clk;
initial begin
	clk = 0;
	duty[0] = 'd25; // ~10% 
	duty[1] = 'd50; // ~20%
	duty[2] = 'd100; // ~40% 
	duty[3] = 'd200; // ~80%
	#51200;
	$stop;
end
endmodule  
	
```

## Simulation on ModelSim
<img src=https://i.imgur.com/DmKwGoq.png>