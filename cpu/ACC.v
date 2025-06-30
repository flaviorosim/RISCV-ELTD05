module ACC (
	input Load, Sh, Ad, Clk, Rst,
	input [32:0] Entradas,
	output reg [32:0] Saidas
);

always @(posedge Clk) begin
	if (Rst)
		Saidas <= 0;
	else begin
		if (Load)
			Saidas <= {17'b0, Entradas[15:0]};
		else if (Ad)
			Saidas[32:16] <= Entradas[32:16];
		else if (Sh)
			Saidas <= Saidas >> 1;
	end
end

endmodule
