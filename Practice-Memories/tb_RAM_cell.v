`timescale 1ns/1ps
module tb_RAM_cell();
	reg write_en, write_data, read_en;
	wire read_data;
	reg clk;
	
	RAM_Cell dut(.write_en(write_en), .write_data(write_data),
				.read_en(read_en), .read_data(read_data));
always #5 clk = ~clk;

initial begin
	clk = 0;
	write_en = 1'b0;
	write_data = 1'b0;
	read_en = 1'b0;
	
	write_en = 1'b1; write_data =1'b1; #10;
	write_en = 1'b0; read_en = 1'b1; #10;
	
	if (read_data)
		$display("Test Passed: Read Data is Correct");
	else
		$display("Test Failed: Read Data is Incorrect");
	
	$stop;
end
endmodule 