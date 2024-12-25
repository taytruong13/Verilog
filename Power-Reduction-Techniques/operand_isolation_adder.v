// 8-bit adder
module operand_isolation_adder (
	input wire enable,
	input wire [7:0] a, b,
	output reg [7:0] sum
);
	reg [7:0] a_isolated, b_isolated; 
	
always @(*) begin
	if(enable) begin 
		a_isolated = a;
		b_isolated = b;
	end else begin 
		a_isolated = 8'b0;
		b_isolated = 8'b0;
	end 
	sum = a_isolated + b_isolated;
end 
endmodule