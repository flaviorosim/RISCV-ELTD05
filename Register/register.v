module register #(parameter TAM=32)(
	input [TAM-1:0] in,
	input CLK, Reset, 
	output reg [TAM-1:0] out
);
	always @(posedge CLK, posedge Reset)
		if(Reset)
			out <= 0;
		else
			out <= in;
endmodule 