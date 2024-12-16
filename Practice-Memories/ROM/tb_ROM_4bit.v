`timescale 1ns/1ps
module tb_ROM_4bit ();
	reg [1:0] address;
	wire [3:0] data;
	
	ROM_4bit dut(.address(address),.data(data));
	
initial begin
	$monitor("Address = $b, data = %b", address, data);
	
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
