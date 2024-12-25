module clock_gating_register (
	input wire clk, rst, enable, 
	input wire [7:0] data_in,
	output reg [7:0] data_out
);

	wire gated_clk;
	assign gated_clk = clk & enable; // clock gating logic
	
	always @(posedge gated_clk or posedge rst) begin
		if(rst)
			data_out <= 8'b0;
		else 
			data_out <= data_in;
	end 
endmodule
