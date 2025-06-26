`timescale 1ns/100ps
module register_TB();

	reg Reset, CLK;
	reg [31:0] in;
	wire [31:0] out;
	
	register DUT(
		.CLK(CLK),
		.in(in),
		.out(out),
		.Reset(Reset)
	);
	
	always
		#5 CLK = ~CLK; 

	initial 
	begin
		Reset = 1;  
		CLK = 0;    
		in = 0; 
		#10 Reset = 0;
		#10 in = 32'h11101110; 	
		#10 in = 32'h024FBFF0; 
 
		#10 Reset = 1; 
		#10 Reset = 0;
		#10 in = 32'hFFFFFFFF; 
		#10; 
		$stop; 
	end
	
endmodule