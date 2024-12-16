module ROM_8bit(
	input wire [2:0] address, //eg. 16 blocks
	output reg [7:0] data
);
	reg [7:0] mem [0:15]; // 16 blocks, each block has 8 bits = 1byte
initial begin
	mem[0]  = 8'b0001_1100;
	mem[1]  = 8'b0110_0110;
	mem[2]  = 8'b1010_1010;
	mem[3]  = 8'b0101_0101;
	mem[4]  = 8'b1111_0000;
	mem[5]  = 8'b0000_1111;
	mem[6]  = 8'b1011_1011;
	mem[7]  = 8'b0111_0111;
	mem[8]  = 8'b1100_1100;
	mem[9]  = 8'b0011_0011;
	mem[10] = 8'b1101_1101;
	mem[11] = 8'b0010_0010;
	mem[12] = 8'b1110_1110;
	mem[13] = 8'b0001_0001;
	mem[14] = 8'b1000_1000;
	mem[15] = 8'b0100_0100;
end

always @(*) begin
	data <= mem[address];
end
endmodule 