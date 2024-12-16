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