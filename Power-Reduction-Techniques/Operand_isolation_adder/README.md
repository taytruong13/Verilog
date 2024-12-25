#Operand Isolation Adder
Operand isolation prevents unnecessary computation in combinational logic by gating input signals. This reduces dynamic power by limiting switching activity in inactive paths.
## Design Description
- **Module Name**: `operand_isolation_adder`
- **Functionality**: An 8-bit adder with operand isolation. The operands are isolated when the `enable` signal is low, ensuring no power is consumed in the adder.
## Code Snippet
```
// 8-bit adder
module operand_isolation_adder (
	input wire enable,
	input wire [7:0] a, b,
	output reg [7:0] sum
);
	reg [7:0] a_isolated, b_isolated; 
	
always @(*) begin
	if(enable) begin 
		a_isolated = a;
		b_isolated = b;
	end else begin 
		a_isolated = 8'b0;
		b_isolated = 8'b0;
	end 
	sum = a_isolated + b_isolated;
end 
endmodule
```
## Testbench
```
module tb_operand_isolation_adder;
    reg enable;
    reg [7:0] a, b;
    wire [7:0] sum;

    operand_isolation_adder dut (
        .enable(enable),
        .a(a),
        .b(b),
        .sum(sum)
    );

initial begin
	enable = 0; a = 8'h0F; b = 8'hF0;
	#10 enable = 1; // Enable operand isolation
	#10 a = 8'hAA; b = 8'h55; // Change inputs
	#10 enable = 0; // Disable operand isolation
	#10 enable = 1; a = 8'hFF; b = 8'h01; // Re-enable operand isolation
	#20 $stop;
end

initial begin
	$monitor($time, " enable=%b a=%h b=%h sum=%h", enable, a, b, sum);
end
endmodule
```
## Simulation on ModelSim
<img src=https://i.imgur.com/9NtBVPp.png>