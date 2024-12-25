`timescale 1ns/1ps
module tb_multi_voltage_system();
    reg clk, rst, high_perf_en;
    reg [7:0] data_in;
    wire [7:0] data_out;

    multi_voltage_system uut (
        .clk(clk),
        .reset(rst),
        .high_perf_en(high_perf_en),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock generator 100MHz
    end

    initial begin
        rst = 1; high_perf_en = 0; data_in = 8'h00;
        #10 rst = 0; data_in = 8'hA5; // Release reset and provide data
        #10 high_perf_en = 1; // Enable high-performance mode
        #20 high_perf_en = 0; // Switch to low-performance mode
        #20 $finish;
    end

    initial begin
        $monitor($time, " clk=%b rst=%b high_perf_en%b data_in=%h data_out=%h", clk, rst, high_perf_en, data_in, data_out);
    end
endmodule