module multi_voltage_system (
	input wire clk, rst,
	input wire high_perf_en,
	input wire [7:0] data_in,
	output wire [7:0] data_out
);
	wire [7:0], high_perf_data, low_perf_data;
	
	high_perf_module high_perf(
		.clk(clk),
		.reset(reset),
        .data_in(data_in),
        .data_out(high_perf_data)
	);
	
	low_perf_module low_perf (
        .clk(clk),
        .reset(rst),
        .data_in(data_in),
        .data_out(low_perf_data)
    );

    assign data_out = high_perf_en ? high_perf_data : low_perf_data;
endmodule