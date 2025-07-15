`timescale 1ns/100ps

module PLL_TB();
	reg CLK;
	wire CLK_SYS, CLK_MUL;
	
	PLL DUT(
			  .inclk0(CLK),
			  .c0(CLK_SYS),
			  .c1(CLK_MUL)
			 );
	
	
	
	always #10 CLK = ~CLK;
	initial CLK = 0;	
	initial #1000 $stop;
endmodule 