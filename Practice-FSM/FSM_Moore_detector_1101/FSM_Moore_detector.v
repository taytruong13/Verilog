module FSM_Moore_detector(
	input clk, rst,
	input in_bit,
	output reg detected
);

// Define states using parameter 
parameter IDLE	= 3'b000;
parameter S1 	= 3'b001;
parameter S11 	= 3'b010;
parameter S110 	= 3'b011;
parameter DETECTED = 3'b100;

// Declare state variables 
reg [2:0] current_state, next_state;

// Sequential Logic for state transitions
always @(posedge clk or posedge rst) begin
	if(rst)
		current_state <= IDLE; // Reset to initial states
	else
		current_state <= next_state; // Move to next state 
end

// Combinational logic for state transitions and output 
always @(*) begin
	// Default values
	next_state = current_state;
	detected  = 1'b0;
	
	case (current_state)
		IDLE: begin
			if(in_bit)  // in_bit 1
				next_state = S1; // Move to state S1 if bit 1 is received 
		end
		
		S1: begin
			if(in_bit)  // in_bit 1
				next_state = S11; // Move to S11 if bit 1 is received 
			else
				next_state = IDLE; // Return to IDLE if bit 0
		end
		
		S11: begin 
			if(~in_bit) // in_bit 0
				next_state = S110; // Move to S110 if bit 0 is received 
			else
				next_state = S11;  // Stay in S11 if in_bit 0
		end 
		
		S110: begin
			if(in_bit)
				next_state = DETECTED; // Move to DETECTED if bit 1 is received
			else 
				next_state = IDLE; // Return to IDLE if bit 0;
		end 
		
		DETECTED: begin 
			detected = 1'b1; // Output is 1 when sequence 1101 is detected 
			if(in_bit)
				next_state = S1; // Continue to detect next sequence 
			else
				next_state = IDLE; // Return to IDLE
		end
		
		default: next_state = IDLE; // Default case
	endcase
end
endmodule 
				
				