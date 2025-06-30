module Counter (
	input Load, Clk,
	output reg K
);

	reg [4:0] count;

	always @(posedge Clk) begin
		if (Load) begin
			count <= 0;
			K <= 0;
		end else if (count == 15) begin
			count <= 0;
			K <= 1;
		end else begin
			count <= count + 1;
			K <= 0;
		end
	end

endmodule
