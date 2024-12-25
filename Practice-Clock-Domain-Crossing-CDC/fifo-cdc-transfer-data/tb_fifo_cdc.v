`timescale 1ns/1ps
module tb_fifo_cdc();
	reg clk_write, clk_read, rst;
	reg [7:0] data_in;
	reg write_en, read_en;
	wire [7:0] data_out;
	wire fifo_empty, fifo_full;
	
	fifo_cdc #(.DEPTH(16)) dut(
		.clk_write(clk_write),
		.clk_read(clk_read),
		.rst(rst),
		.data_in(data_in),
		.write_en(write_en),
		.read_en(read_en),
		.data_out(data_out),
		.fifo_empty(fifo_empty),
		.fifo_full(fifo_full)
	);
// clock generation
	initial begin
		clk_write = 0;
		forever #5 clk_write = ~clk_write; // 100 MHz clock
	end 
	
	initial begin 
		clk_read = 0;
		forever #7 clk_read = ~clk_read; // ~71,43 MHz clock
	end
	
	initial begin
		rst = 1;
		write_en = 0;
		read_en = 0;
		data_in = 0;
		#20 rst = 0;
		
		// Write data_in
		#10 write_en = 1;
		data_in = 8'hAA;
		#10 data_in = 8'hBB;
		#10 data_in = 8'hCC;
		#10 write_en = 0;
		
		// read_data
		#30 read_en = 1;
		#20 read_en = 0;
		
		#50 $stop; 
	end 
	
	initial begin 
		$monitor($time, " data_in=%h, data_out=%h, fifo_empty=%b, fifo_full=%b", data_in, data_out, fifo_empty, fifo_full);
	end
endmodule 