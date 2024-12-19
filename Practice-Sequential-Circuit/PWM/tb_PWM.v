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
	