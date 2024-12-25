#Clock Gating Register
Clock gating is a widely used technique to reduce dynamic power consumption in digital designs. It disables the clock signal for specific registers or modules when they are not required, reducing unnecessary switching activity.

## Design Description
- **Module Name**: `clock_gating_register`
- **Functionality**: An 8-bit register that updates only when the enable signal is active. The clock signal is gated using the enable signal to prevent switching activity when unnecessary.

## Code Snippet
```
module clock_gating_register (
	input wire clk, rst, enable, 
	input wire [7:0] data_in,
	output reg [7:0] data_out
);

	wire gated_clk;
	assign gated_clk = clk & enable; // clock gating logic
	
	always @(posedge gated_clk or posedge rst) begin
		if(rst)
			data_out <= 8'b0;
		else 
			data_out <= data_in;
	end 
endmodule
```
## Testbench
```
`timescale 1ns/1ps
module tb_clock_gating_register();
    reg clk, rst, enable;
    reg [7:0] data_in;
    wire [7:0] data_out;

    clock_gating_register dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .data_in(data_in),
        .data_out(data_out)
    );

initial begin
	clk = 0;
	forever #5 clk = ~clk; // Clock generator 100MHz
end

initial begin
	rst = 1; enable = 0; data_in = 8'h00;
	#10 rst = 0; // Release reset
	#10 enable = 1; data_in = 8'hAA; // Enable clock gating
	#20 enable = 0; // Disable clock gating
	#10 enable = 1; data_in = 8'h55; // Re-enable clock gating with new data
	#20 $stop;
end

initial begin
	$monitor($time, " clk=%b rst=%b enable=%b data_in=%h data_out=%h", clk, rst, enable, data_in, data_out);
end
endmodule
```
## Simulation on ModelSim
<img src=https://i.imgur.com/5gENxIR.png>