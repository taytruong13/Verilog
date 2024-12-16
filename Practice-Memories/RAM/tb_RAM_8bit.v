`timescale 1ns/1ps
module tb_RAM_8bit ();
	reg [7:0] address;
	reg write_en;
	reg [7:0] write_data;
	reg read_en;
	wire [7:0] read_data;
	reg clk;
	
	RAM_8bit dut(.address(address),.write_en(write_en),.write_data(write_data),.read_en(read_en),.read_data(read_data));
	
always #5 clk = ~clk;
initial begin
	address = 8'b0000_0000;
	write_en = 0;
	write_data = 8'b0000_0000;
	read_en = 0;
	
	write_en = 1;
	address = 8'b0000_0010; // = 2
	write_data = 8'b1111_1011;
	#10;
	
	write_en = 0;
	read_en = 1;
	address = 8'b0000_0010;
	#10;
	
	if (read_data == 8'b1111_1011)
		$display("Test Passed: Read data is Correct");
	else 
		$display("Test Failed: Read Data is Incorrect");
	
	$stop;
end

endmodule