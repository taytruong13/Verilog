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
