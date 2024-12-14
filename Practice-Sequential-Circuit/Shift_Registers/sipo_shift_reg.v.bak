// Serial in Parallel Out  - SIPO - shift register
// Change size number for another size of SIPO
`define D_SIZE 4
module sipo_shift_reg(
	input clk, rst, serial_in,
	output [`D_SIZE-1:0] parallel_out
);
	reg [`D_SIZE-1:0] shift_reg;
	genvar g;
always @(posedge clk or posedge rst) begin
	if(rst) begin
		shift_reg <= 'b0;
	end else begin
		shift_reg[0] <= serial_in;
		generate
			for(g=1;g<`D_SIZE;g=g+1) begin
				shift_reg[g] <= shift_reg[g-1];
			end
		endgenerate
	end
end

assign parallel_out = shift_reg;
endmodule