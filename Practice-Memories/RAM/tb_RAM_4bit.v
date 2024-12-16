`timescale 1ns/1ps
module tb_RAM_4bit();
	reg [3:0] address;
	reg write_en;
	reg [3:0] write_data;
	reg read_en;
	wire [3:0] read_data;
	reg clk;
	
	RAM_4bit dut(.address(address),.write_en(write_en),.write_data(write_data),
				.read_en(read_en),.read_data(read_data));
				
always #5 clk = ~clk;

initial begin
	address = 0;
	write_en = 0;
	write_data = 4'b000;
	read_en = 0;
	
	write_en = 1;
	address = 2;
	write_data = 4'b1101;
	#10;
	
	write_en = 0;
	read_en = 1;
	address = 2;
	#10 
	
	if(read_data == 4'b1101)
		$display("Test Passed: Read Data is Correct");
	else
		$display("Test Failed: Read Data is Incorrect");
	
	$stop;
end
endmodule 
	
	
	

