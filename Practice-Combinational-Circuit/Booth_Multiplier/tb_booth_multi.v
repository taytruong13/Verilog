`timescale 1ns/1ps
`define D_SIZE 4
module tb_booth_multi();
	reg signed [`D_SIZE-1:0] M, Q;
	wire signed [2*`D_SIZE-1:0] Product;
	
	booth_multi #(`D_SIZE) dut(.M(M),.Q(Q),.Product(Product));
	
initial begin
	$monitor("M x Q = %b x %b = %b = (dec) %02d x %02d = %03d", M, Q, Product, M, Q, Product);
	M = 4'b0101; Q = 4'b0110; #10;
	M = 4'b1100; Q = 4'b0011; #10;
	M = 4'b1101; Q = 4'b1001; #10;
	M = 4'b1001; Q = 4'b0111; #10;
	$stop;
end
endmodule