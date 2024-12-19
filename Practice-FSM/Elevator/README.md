# ELEVATOR controller
## The module in Verilog code
```
// Controller for 5 floor elevator 
module elevator(
	input clk, rst,
	input [4:0] floor_req, // floor request signal
	output reg [4:0] floor_pos // signal indicating elevator position
);

parameter IDLE = 3'b000;
parameter MOVING_UP = 3'b001;
parameter MOVING_DOWN = 3'b010;
parameter STOPPED = 3'b011;

reg [2:0] state;
reg [4:0] floor_req_reg; // register to hold floor requests
reg [4:0] floor_pos_reg; // register to hold elevator position

always @(posedge clk or posedge rst) begin
	if(rst) begin
		state <= IDLE;
		floor_req_reg <= 5'b00000;
		floor_pos_reg <= 5'b00000;
		floor_pos <= floor_pos_reg;
	end else begin 
		case (state)
			IDLE: begin
				if(floor_req != 5'b00000) begin
					if (floor_req > floor_pos_reg)
						state <= MOVING_UP;
					else if (floor_req < floor_pos_reg)
						state <= MOVING_DOWN;
					else
						state <= STOPPED;
				end 
			end 
			
			MOVING_UP: begin
				if(floor_pos_reg == floor_req)
					state <= STOPPED;
				else
					floor_pos_reg <= floor_pos_reg + 1; // Move up one floor 
			end
			
			MOVING_DOWN: begin
				if(floor_pos_reg == floor_req)
					state <= STOPPED;
				else
					floor_pos_reg <= floor_pos_reg -1;
			end 
			
			STOPPED: begin 
				floor_req_reg[floor_pos_reg] <= 1'b0; // clear request from current floor
				if (floor_req != 5'b00000) begin
					if(floor_req > floor_pos_reg)
						state <= MOVING_UP;
					else if(floor_req < floor_pos_reg)
						state <= MOVING_DOWN;
					else
						state <=STOPPED;
				end else 
					state <= IDLE;
			end 
			
		endcase
		floor_pos <= floor_pos_reg;
		floor_req_reg[floor_req] <= 1'b1; // set request for requested floor
	end 
end 
endmodule

		
			
```

## Testbench for PWM generator 
```
`timescale 1ns/1ps
module tb_elevator();
	reg clk, rst;
	reg [4:0] floor_req;
	wire [4:0] floor_pos;
	
	elevator dut(.clk(clk),.rst(rst),.floor_req(floor_req),.floor_pos(floor_pos));
// clock generate
always #5 clk = ~clk;

initial begin
	clk = 1'b0;
	rst = 1'b1;
	floor_req = 5'b00000;
	#10 rst = 1'b0;
	
	#10 floor_req = 5'b00100; // request floor 3
	#100 floor_req = 5'b00010; // request floor 2
	#100 floor_req = 5'b01000; // request floor 4
	#100 floor_req = 5'b00001; // request floor 1
	#100 floor_req = 5'b10000; // request floor 5
	#100 $stop;
end 
endmodule 
```

## Simulation on ModelSim
<img src=https://i.imgur.com/rMYuYbD.png>