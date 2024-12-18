`timescale 1ns/1ps
//Detect 1010 sequence 

module tb_FSM_Mealy_detector();
	reg din, clk, rst;
	wire dout;

	FSM_Mealy_detector dut(.din(din),.clk(clk),.rst(rst),.dout(dout));

always #5 clk = ~clk;

initial begin
	din = 0;
	clk = 0;
	rst = 1;
	
	#10 rst = 0;
	din = 1; #10;
	din = 0; #10;
	din = 1; #10;
	din = 0; #10;
	din = 1; #10;
	$stop;
end
endmodule