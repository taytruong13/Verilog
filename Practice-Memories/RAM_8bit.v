module RAM_8bit(
	input wire [7:0] address,
	input wire write_en,
	input wire [7:0] write_data,
	input wire read_en,
	output reg [7:0] read_data
);

	reg [7:0] memory [0:255];
always @(posedge write_en or posedge read_en) begin
	begin 
		if(write_en)
			memory[address] <= write_data;
		else if(read_en)
			read_data <= memory[address];
	end
end
endmodule 