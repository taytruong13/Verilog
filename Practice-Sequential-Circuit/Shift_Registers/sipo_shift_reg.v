// Serial in Parallel Out  - SIPO - shift register
// Change size number for another size of SIPO
`define D_SIZE 4
module sipo_shift_reg(
	input clk, rst, serial_in,
	output [`D_SIZE-1:0] parallel_out
);
	reg [`D_SIZE-1:0] shift_reg;
	genvar g;
	// Generate register instance
	always @(posedge clk or posedge rst) begin
		if(rst) shift_reg <= 'b0;
		else shift_reg[0] <= serial_in;
	end
	
	generate 
		for(g=1;g<`D_SIZE;g=g+1) begin : reg_inst
			always @(posedge clk or posedge rst) begin 
				if(~rst) shift_reg[g] <= shift_reg[g-1];
			end
		end
	endgenerate
	assign parallel_out = shift_reg;
endmodule 