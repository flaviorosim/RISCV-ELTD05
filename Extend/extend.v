module extend(
	input  [15:0] in,
	output reg [31:0] out,
	input en
);

	always @(*)begin
		out <= 32'd0;
		if(en) begin
			if(in[15])begin
				out <= {16'hFFFF,in[15:0]};
			end
			else begin
				out <= {16'h0000,in[15:0]};
			end
		end
	end
	
endmodule	