module ROM_1bit(
	input wire [1:0] address,
	output reg data
);
	parameter DEPTH = 4; // eg. ROM has 4 memory cells
	// Array to store data
	reg mem [0:DEPTH-1];
	// ROM s data
initial begin
	mem[0] = 1'b0;
	mem[1] = 1'b1;
	mem[2] = 1'b0;
	mem[3] = 1'b1;
end
	
//Read data
always @(*) begin
	data = mem[address];
end 

endmodule 