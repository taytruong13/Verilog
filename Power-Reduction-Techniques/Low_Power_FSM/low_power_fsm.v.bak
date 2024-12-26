// Lower Power FSM
module low_power_fsm (
	input wire clk, rst, enable,
	output reg [1:0] state
);

	parameter 	S0 = 2'b00,
				S1 = 2'b01,
				S2 = 2'b11,// use gray code for states
				S3 = 1'b10;
always @(posedge clk or posedge rst) begin
	if(rst) 
		state <= S0;
	else if(enable) begin
		case (state)
			S0: state <= S1;
			S1: state <= S2;
			S2: state <= S3;
			S3: state <= S0;
			default: state <= S0;
		endcase
	end 
end 
endmodule 
				