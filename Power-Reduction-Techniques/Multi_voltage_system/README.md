# Multi-Voltage Design
Multi-voltage design involves dynamically switching between voltage levels based on performance requirements. This allows systems to balance power and performance effectively.

## Design Description
- **Module Name**: `multi_voltage_system`
- **Functionality**: A system that toggles between high- and low-performance modes based on a control signal. Data is processed differently in each mode to reflect real-world power-performance trade-offs.
## Code snippet
```
module multi_voltage_system (
	input wire clk, rst,
	input wire high_perf_en,
	input wire [7:0] data_in,
	output wire [7:0] data_out
);
	wire [7:0] high_perf_data, low_perf_data;
	
	high_perf_module high_perf(
		.clk(clk),
		.reset(reset),
        .data_in(data_in),
        .data_out(high_perf_data)
	);
	
	low_perf_module low_perf (
        .clk(clk),
        .reset(rst),
        .data_in(data_in),
        .data_out(low_perf_data)
    );

    assign data_out = high_perf_en ? high_perf_data : low_perf_data;
endmodule
```
## Testbench
```
`timescale 1ns/1ps
module tb_multi_voltage_system();
    reg clk, rst, high_perf_en;
    reg [7:0] data_in;
    wire [7:0] data_out;

    multi_voltage_system uut (
        .clk(clk),
        .reset(rst),
        .high_perf_en(high_perf_en),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock generator 100MHz
    end

    initial begin
        rst = 1; high_perf_en = 0; data_in = 8'h00;
        #10 rst = 0; data_in = 8'hA5; // Release reset and provide data
        #10 high_perf_en = 1; // Enable high-performance mode
        #20 high_perf_en = 0; // Switch to low-performance mode
        #20 $finish;
    end

    initial begin
        $monitor($time, " clk=%b rst=%b high_perf_en%b data_in=%h data_out=%h", clk, rst, high_perf_en, data_in, data_out);
    end
endmodule
```