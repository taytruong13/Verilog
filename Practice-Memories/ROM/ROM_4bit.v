module ROM_4bit(
	input wire [1:0] address, //eg. 4 blocks
	output reg [3:0] data
);
	reg [3:0] mem [0:3]; // 4 blocks, each block has 4 bits
initial begin
	mem[0] = 4'b0001;
	mem[1] = 4'b0110;
	mem[2] = 4'b0011;
	mem[3] = 4'b0111;
end

always @(*) begin
	data <= mem[address];
end
endmodule 