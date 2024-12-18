// if you want to test with Shift Register, use this code below
module shift_detector_1101 (
	input clk, rst, in_bit,
	output reg detected
);
	reg [3:0] sequence;
always @(posedge clk or posedge rst) begin
	if(rst)begin
		sequence <= 4'b0000;
		detected <= 1'b0;
	end else begin
		sequence = sequence >> 1;
		sequence[3] = in_bit;
		detected = (sequence == 4'b1101) ? 1'b1 : 1'b0;
	end
end 
endmodule 