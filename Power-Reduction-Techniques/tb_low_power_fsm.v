`timescale 1ns/1ps
module tb_low_power_fsm();
    reg clk, rst, enable;
    wire [1:0] state;

    low_power_fsm uut (
        .clk(clk),
        .reset(rst),
        .enable(enable),
        .state(state)
    );

initial begin
	clk = 0;
	forever #5 clk = ~clk; // Clock generator 100MHz
end

initial begin
	rst = 1; enable = 0;
	#10 rst = 0; enable = 1; // Start FSM
	#40 enable = 0; // Pause FSM
	#20 enable = 1; // Resume FSM
	#40 $stop;
end

initial begin
	$monitor($time, " clk=%b rst=%b enable=%b state=%b", clk, rst, enable, state);
end
endmodule