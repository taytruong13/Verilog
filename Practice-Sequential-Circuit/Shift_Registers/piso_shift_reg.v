// Parallel In Serial Out PISO shift register
`define D_SIZE 4
module piso_shift_reg(
	input clk, rst, enIn,
	input [`D_SIZE-1:0] parallel_in,
	output serial_out
);
	reg [`D_SIZE-1:0] shift_reg;
	genvar g;

always @(posedge clk or posedge rst) begin // asynchronous reset
	if(rst) shift_reg <= 'b0;
	else if(enIn) shift_reg <= parallel_in;
	else shift_reg[`D_SIZE-1] <= 1'b0; //shift from left to right
end

//generate other shift_reg
generate
	for(g=`D_SIZE-2; g>=0; g=g-1) begin : reg_inst
	   always @(posedge clk or posedge rst) begin
		if(~rst&~enIn) shift_reg[g] <= shift_reg[g+1];
	   end
	end
endgenerate

assign serial_out = shift_reg[0];
endmodule 
	
	