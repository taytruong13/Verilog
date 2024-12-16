`timescale 1ns/1ps
`define D_S 8  // design for ALU 8 bit
module tb_ALU_8bit ();
	reg [3:0] operation;
	reg [`D_S-1:0] A, B;
	wire [2*`D_S-1:0] result;
	wire carry_flag;
	
	ALU_8bit dut(.operation(operation),.A(A),.B(B),.result(result),.carry_flag(carry_flag));
	
// Clock generate 
	reg clk = 0;
always #5 clk = ~clk;

						
// test case
	integer i;
initial begin
	A = $urandom %((1<<`D_S)-1);
	B = $urandom %((1<<`D_S)-1);
	
	for(i=0;i<16;i=i+1) begin
		operation = i; #5;
		$display("Operation %b: A=%b, B=%b --> result=%b", operation, A, B, result);
		#5;
	end
end
endmodule 