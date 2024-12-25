`timescale 1ns/1ps
module tb_clock_gating_register();
    reg clk, rst, enable;
    reg [7:0] data_in;
    wire [7:0] data_out;

    clock_gating_register dut (
        .clk(clk),
        .reset(rst),
        .enable(enable),
        .data_in(data_in),
        .data_out(data_out)
    );

initial begin
	clk = 0;
	forever #5 clk = ~clk; // Clock generator 100MHz
end

initial begin
	rst = 1; enable = 0; data_in = 8'h00;
	#10 rst = 0; // Release reset
	#10 enable = 1; data_in = 8'hAA; // Enable clock gating
	#20 enable = 0; // Disable clock gating
	#10 enable = 1; data_in = 8'h55; // Re-enable clock gating with new data
	#20 $stop;
end

initial begin
	$monitor($time, " clk=%b rst=%b enable=%b data_in=%h data_out=%h", clk, rst, enable, data_in, data_out);
end
endmodule