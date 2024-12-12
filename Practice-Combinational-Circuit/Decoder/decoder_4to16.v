// Decoder for all SIZE
// D_SIZE = 1 for 1to2 decoder
// D_SIZE = 2 for 2to4 decoder
// D_SIZE = 3 for 3to8 decoder
// and so far...
`define D_SIZE 4
module decoder_4to16(
	input [`D_SIZE-1:0] in,
	output reg [(1<<`D_SIZE)-1:0] out
	);
always @(*) begin
	out = '0;
	out[in] = 1'b1;
end
endmodule
