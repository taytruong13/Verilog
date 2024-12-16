`define D_S 8 // Size of the AlU
module ALU_8bit(
	input [3:0] operation,
	input [`D_S-1:0] A,  // Input A
	input [`D_S-1:0] B,  // Input B
	output reg [2*`D_S-1:0] result,
	output reg carry_flag 
); 


always @(*) begin
	case(operation)
		4'b0000 : begin // Addition
			result = A + B;
			carry_flag = result[`D_S];
		end
		
		4'b0001 : begin // Subtraction 
			result = A - B;
			carry_flag = result[`D_S];
		end 
		
		4'b0010 :  // Multiplication
			result = A * B;
		4'b0011 :  // Division 
			result = A/B;
		4'b0100 :  // Logical shift left 
			result = A << 1;
		4'b0101 :  // Logical shift right 
			result = A >> 1;
		4'b0110 :  // Rotate left 
			result = {A[`D_S-2:0],A[`D_S-1]};
		4'b0111 :  // Rotate right
			result = {A[0],A[`D_S-1:1]};
		4'b1000 :  // Logical AND
			result = A & B;
		4'b1001 :  // Logical OR
			result = A | B;
		4'b1010 :  // Logical XOR
			result = A ^ B;
		4'b1011 :  // Logical NOR
			result = ~(A|B);
		4'b1100 :  // Logical NAND
			result = ~(A & B);
		4'b1101 :  // Logical XNOR
			result = ~(A ^ B);
		4'b1110 :  // Greater comparison
			result = (A>B) ? 'b1 : 'b0;
		4'b1111 :  // Equal comparison 
			result = (A==B) ? 'b1 : 'b0;
		default : 
			result = 'bx;
	endcase
end 
endmodule 