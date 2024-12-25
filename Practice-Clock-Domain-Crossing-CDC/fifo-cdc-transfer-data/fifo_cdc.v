// 8 (bit) x 16 (depth) fifo 
module fifo_cdc (
	input wire clk_write, 		// write clock domain
	input wire clk_read, 		// read clock domain 
	input wire rst,
	input wire [16:0] data_in,	// data input
	input wire write_en,		// Write data enable 
	input wire read_en,			// read data enable
	output reg [7:0] data_out, 	// data output
	output reg fifo_empty,
	output reg fifo_full
);

	parameter DEPTH = 16;
	reg [7:0] fifo_mem [0:DEPTH-1]; // fifo memory
	reg [3:0] write_ptr, read_ptr; // write and read pointer
	reg [4:0] fifo_count;
	
always @(posedge clk_write or posedge rst) begin
	if(rst) begin
		write_ptr <= 0;
		fifo_full <= 0;
	end else if (write_en && !fifo_full) begin
		fifo_mem[write_ptr] <= data_in;
		write_ptr <= write_ptr +1;
		fifo_count <= fifo_count + 1;
	end 
	fifo_full <= (fifo_count == DEPTH);
end 

always @(posedge clk_read or posedge rst) begin 
	if (rst) begin 
		read_ptr <= 0; 
		fifo_empty <= 1;
	end else if (read_en && !fifo_empty) begin
		data_out <= fifo_mem[read_ptr];
		read_ptr <= read_ptr + 1;
		fifo_count <= fifo_count - 1;
	end 
	fifo_empty <= (fifo_count == 0);
end
endmodule 

	