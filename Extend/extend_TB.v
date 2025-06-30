`timescale 1ns/100ps

module extend_TB ();

	reg [15:0] in;

	wire [31:0] out;
	
	extend DUT (
	.in(in),
	.out(out),
	);
	
	initial begin

		in = 16'h0004;
		#10; 
		
		#10; 
		in = 16'hFFFF;
		
		#10;
		in = 16'hA000;
		
		#10;
		$stop;
	end
	
endmodule
