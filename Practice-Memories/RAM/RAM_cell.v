//1-Bit RAM Cell
module RAM_Cell(
	input wire write_en, write_data, read_en,
	output reg read_data
);
	reg memory_bit;
	always @(posedge write_en or posedge read_en) begin
		if(write_en)
			memory_bit <= write_data;
		else if(read_en)
			read_data <= memory_bit;
	end
endmodule 