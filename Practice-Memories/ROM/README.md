### Contents
- [1-bit ROM](#1bitrom)
- [4-bit RAM](#4bitrom)
- [8-bit ROM](#8bitrom)


=================================

<a name="1bitrom"></a>
# 1-bit ROM

ROM, or Read-Only Memory, is a non-volatile storage medium that retains its contents even when the power is turned off. It's used to store essential system software and firmware that doesn't need to be modified. Unlike RAM, ROM is designed for read-only access, meaning its data cannot be altered after manufacturing.

## The module in Verilog code
```
module ROM_1bit(
	input wire [1:0] address,
	output reg data
);
	parameter DEPTH = 4; // eg. ROM has 4 memory cells
	// Array to store data
	reg mem [0:DEPTH-1];
	// ROM s data
initial begin
	mem[0] = 1'b0;
	mem[1] = 1'b1;
	mem[2] = 1'b0;
	mem[3] = 1'b1;
end
	
//Read data
always @(*) begin
	data = mem[address];
end 
endmodule 
```
## Testbench for ROM 1bit
```
`timescale 1ns/1ps
module tb_ROM_1bit();
	reg [1:0] address;
	wire data;
	
	ROM_1bit dut(.address(address),.data(data));
initial begin
	address = 0;
	#10;
	
	address = 1;
	#10; 
	
	if(data == 1'b1)
		$display("Test Passed");
	else
		$display("Test Failed");
		
	$stop;
end
endmodule
```
## Simulation on ModalSim
<img src=https://i.imgur.com/2cdstLG.png>

<a name="4bitrom"></a>
# 4-bit ROM
In the code below, a 4-bit ROM has 4 blocks, each block has 4 bits. 

## The module in Verilog code
```
module ROM_4bit(
	input wire [1:0] address, //eg. 4 blocks
	output reg [3:0] data
);
	reg [3:0] mem [0:3]; // 4 blocks, each block has 4 bits
initial begin
	mem[0] = 4'b0001;
	mem[1] = 4'b0110;
	mem[2] = 4'b0011;
	mem[3] = 4'b0111;
end

always @(*) begin
	data <= mem[address];
end
endmodule 
```
## Testbench for 4-bit ROM
```
`timescale 1ns/1ps
module tb_ROM_4bit ();
	reg [1:0] address;
	wire [3:0] data;
	
	ROM_4bit dut(.address(address),.data(data));
	
initial begin
	$monitor("Address = %b, data = %b", address, data);
	
	address = 2'b00;
	#10;
	address = 2'b01;
	#10;
	address = 2'b10;
	#10;
	address = 2'b11;
	#10 
	$stop;
end
endmodule

```
## Simulation on ModelSim
<img src=https://i.imgur.com/wQlN3Fq.png>

<a name="8bitrom"></a>
# 8-bit ROM

## The module in Verilog code
```
module ROM_8bit(
	input wire [2:0] address, //eg. 16 blocks
	output reg [7:0] data
);
	reg [7:0] mem [0:15]; // 16 blocks, each block has 8 bits = 1byte
initial begin
	mem[0]  = 8'b0001_1100;
	mem[1]  = 8'b0110_0110;
	mem[2]  = 8'b1010_1010;
	mem[3]  = 8'b0101_0101;
	mem[4]  = 8'b1111_0000;
	mem[5]  = 8'b0000_1111;
	mem[6]  = 8'b1011_1011;
	mem[7]  = 8'b0111_0111;
	mem[8]  = 8'b1100_1100;
	mem[9]  = 8'b0011_0011;
	mem[10] = 8'b1101_1101;
	mem[11] = 8'b0010_0010;
	mem[12] = 8'b1110_1110;
	mem[13] = 8'b0001_0001;
	mem[14] = 8'b1000_1000;
	mem[15] = 8'b0100_0100;
end

always @(*) begin
	data <= mem[address];
end
endmodule 
```

## Testbench for 8-bit RAM
```
`timescale 1ns/1ps
module tb_ROM_8bit ();
	reg [2:0] address;
	wire [7:0] data;
	
	ROM_8bit dut(.address(address),.data(data));
	integer i;
	
initial begin
	$monitor("Address = %02d, data = %b", address, data);
	for (i = 0; i<16; i = i+1) begin
      address = i; #10;
    end
end
endmodule
```
## Simulation on ModelSIM
<img src=https://i.imgur.com/j2NwbUW.png>
