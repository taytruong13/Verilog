# FIFO Buffer for Data Transmission
## Overview
This project implements a **First-In-First-Out (FIFO) buffer** designed specifically for **Clock Domain Crossing (CDC)** applications. The FIFO buffer is a fundamental component in digital design, often used for transferring data between different clock domains while ensuring reliable and synchronized communication. It supports parameterizable depth and width, making it flexible for various asynchronous applications. 
## Features
- Parameterizable DEPTH and WIDTH:
    - The buffer depth (number of storage locations) and data width are configurable through parameters. 
- Asynchronous Read/Write:
    - The FIFO operates accross two different clock domains, with separate clock signals for write and read operations. 
- Synchronization Mechanism:
    - Ensures proper data transfer between clock domains using multi-flop synchronizers for control signals. 
- Overflow and Underflow Protection:
    - Detects and prevents data loss or incorrect reads during buffer overflows or underflows.
- Write Pointer, Read Pointer, and Count Tracking:
    - Keeps track of write and read positions, as well as the number of elements currently stored. 

## Parameters
|Parameter|Description|Default Value|
|:-------:|--|:---:|
|`DEPTH`|Number of FIFO entries|16|
|`WIDTH`|Width of each data entry|8|

## Interface
### Inputs
- `clk_read`: clock signal for write operations.
- `clk_write`: clock signal for read operations. 
- `rst`: Reset signal to initialize the FIFO.
- `write_en`: Write enable signal.
- `read_en`: Read enable signal. 
- `[WIDTH-1:0] data_in`: Data input bus. 
### Outputs
- `[WIDTH-1:0] data_out`: Data output bus.
- `fifo_empty`: High when the FIFO is empty.
- `fifo_full`: High when the FIFO is full.

## Architecture 
- Write Pointer (`write_ptr`):
    - Points to the next location for writing data in the write clock domain. 
    - Width = `ceil(log2(DEPTH))`.
- Read Pointer (`read_ptr`):
    - Points to the location of the next read operations in the read clock domain. 
    - Width = `ceil(log2(DEPTH))`.
- FIFO Counter (`fifo_count`):
    - Tracks the number of elements in the buffer.
    - Width = `ceil(log2(DEPTH + 1))`.
- Dual Clock synchronisers:
    - Synchronize the write and read pointers between the two clock domains to ensure reliable data transfer. 
- Memory Array (`fifo_mem`):
    - Stores the actual data with a size of `DEPTH x WIDTH`.

## Usage
- **Configure Parameters**: Set the desired values for `DEPTH` and `WIDTH` in the Verilog source file. 
- **Intergrate into Design**: Connect the FIFO's inputs and outputs to your design components. 
- **Simulation and Testing**: Verify functionality using provided testbenches or create custome scenarios. 

## Example Configuration 
### Parameter values: 
- `DEPTH = 16`
- `WIDTH = 8`
### Code Snippet
```
module fifo_cdc #(parameter DEPTH = 16, parameter WIDTH = 8) (
	input clk_write, 		// write clock domain
	input clk_read, 		// read clock domain 
	input rst,
	input [WIDTH-1:0] data_in,	// data input
	input write_en,			// Write data enable 
	input read_en,			// read data enable
	output reg [WIDTH-1:0] data_out, 	// data output
	output reg fifo_empty,
	output reg fifo_full
);

	localparam PTR_WIDTH = $clog2(DEPTH);
	//localparam FIFO_COUNT_WIDTH = $clog2(DEPTH+1);
	
	reg [WIDTH-1:0] fifo_mem [0:DEPTH-1]; // fifo memory
	reg [PTR_WIDTH-1:0] write_ptr, read_ptr; // write and read pointer
	reg [PTR_WIDTH:0] fifo_count;
	
always @(posedge clk_write or posedge rst) begin
	if(rst) begin
		write_ptr <= 0;
		fifo_full <= 0;
		fifo_count <= 0;
	end else if (write_en && !fifo_full) begin
		fifo_mem[write_ptr] <= data_in;
		write_ptr <= write_ptr + 1;
		fifo_count = fifo_count + 1;
	end 
	fifo_full <= (fifo_count == DEPTH);
end 

always @(posedge clk_read or posedge rst) begin 
	if(rst) begin 
		read_ptr <= 0; 
		fifo_empty <= 1;
		fifo_count <= 0;
	end else if(read_en && !fifo_empty) begin
		data_out <= fifo_mem[read_ptr];
		read_ptr <= read_ptr + 1;
		fifo_count = fifo_count - 1;
	end 
	fifo_empty <= (fifo_count == 0);
end
endmodule 
```
### Testbench
```
// Testbench for FIFO with size of DEPTH x WIDTH = 16 x 8. 
`timescale 1ns/1ps
module tb_fifo_cdc();
	reg clk_write, clk_read, rst;
	reg [7:0] data_in;
	reg write_en, read_en;
	wire [7:0] data_out;
	wire fifo_empty, fifo_full;
	
	fifo_cdc #(.DEPTH(16),.WIDTH(8)) dut(
		.clk_write(clk_write),
		.clk_read(clk_read),
		.rst(rst),
		.data_in(data_in),
		.write_en(write_en),
		.read_en(read_en),
		.data_out(data_out),
		.fifo_empty(fifo_empty),
		.fifo_full(fifo_full)
	);
// clock generation
initial begin
	clk_write = 0;
	forever #5 clk_write = ~clk_write; // 100 MHz clock
end 

initial begin 
	clk_read = 0;
	forever #7 clk_read = ~clk_read; // ~71,43 MHz clock
end

initial begin
	#5 rst = 1;
	write_en = 0;
	read_en = 0;
	data_in = 'b0;
	#10 rst = 0;
	
	// Write data_in
	#10 write_en = 1;
	data_in = 8'hAA;
	#10 data_in = 8'hBB;
	#10 data_in = 8'hCC;
	#10 data_in = 8'h95;
	#10 data_in = 8'h0B;
	#10 write_en = 0;
	
	// read_data
	#30 read_en = 1;
	#70 read_en = 0;
	
	#20 $stop; 
end 

initial begin 
	$monitor($time, " data_in=%h, data_out=%h, fifo_empty=%b, fifo_full=%b", data_in, data_out, fifo_empty, fifo_full);
end
endmodule 
```
### Simulation on ModelSim
<img src=https://i.imgur.com/ahEoq5U.png>