// Serial in Serial Out (SISO) Shirt Register 
module siso_shift_reg(
	input clk, serial_in,
	output serial_out
);
	reg [3:0] shift_reg;	
always @(posedge clk) begin
	shift_reg[0] <= serial_in; // Data shift from right to left
	shift_reg[1] <= shift_reg[0];
	shift_reg[2] <= shift_reg[1];
	shift_reg[3] <= shift_reg[2];
end

	assign serial_out = shift_reg[3];
endmodule