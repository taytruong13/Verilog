module RAM_4bit(
	input wire [3:0] address,
	input wire write_en,
	input wire [3:0] write_data,
	input wire read_en,
	output reg [3:0] read_data
);
	reg [3:0] memory [0:15];

always @(posedge write_en or posedge read_en) begin
	if(write_en)
		memory[address] <= write_data;
	else if(read_en)
		read_data <= memory[address];
end
endmodule 