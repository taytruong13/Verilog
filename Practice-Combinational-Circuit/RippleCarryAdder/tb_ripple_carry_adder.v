`timescale 1ns/1ps
module tb_ripple_carry_adder #(parameter WIDTH = 4)();
	reg [WIDTH-1:0] a, b;
	reg cin;
	wire [WIDTH-1:0] sum, cout;
	
	ripple_carry_adder dut(
		.a(a),.b(b),
		.cin(cin),
		.sum(sum),.cout(cout)
	);
	
	initial begin 
		$monitor("cin = %b, %b + %b = %b, cout = %b", cin, a, b, sum, cout);
	end
	
	initial begin
		cin = 1'b0;
		a = 4'b0000; b = 4'b0000;
		#10;
		a = 4'b0001; b = 4'b0010;
		#10;
		a = 4'b0011; b = 4'b0101;
		#10;
		a = 4'b0111; b = 4'b1011;
		#10;
		// With Cin = 1
		cin = 1'b1;
		a = 4'b0000; b = 4'b0000;
		#10;
		a = 4'b0001; b = 4'b0010;
		#10;
		a = 4'b0011; b = 4'b0101;
		#10;
		a = 4'b0111; b = 4'b1011;
		#10 $stop;
	end
endmodule
		