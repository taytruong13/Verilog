//Bidirectional Shift Register
`define D_SIZE 4
module  bidir_shift_reg(
	input clk, in, en, dir, rst,
	output reg [`D_SIZE-1:0] out
);

always @(posedge clk or posedge rst) begin
	if(rst) out <= 'b0;
	else if(en) begin
		case (dir)
			1'b0 : out <= {out[`D_SIZE-2:0], in}; //shift to left 
			1'b1 : out <= {in, out[`D_SIZE-1:1]}; //shift to right
		endcase
	end else out <= out;
end
endmodule