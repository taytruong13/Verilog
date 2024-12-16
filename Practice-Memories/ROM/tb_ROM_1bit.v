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
