`timescale 1ns/100ps

module extend_TB ();

	reg [15:0] in;
	reg en;
	wire [31:0] out;
	
	extend DUT (
	.in(in),
	.out(out),
	.en(en)
	);
	
	initial begin
		en = 0;
		in = 16'h0004;
		#10; 
		en = 1;
		
		#10; 
		in = 16'hFFFF;
		
		#10;
		in = 16'hA000;
		
		#10;
		$stop;
	end
	
endmodule
