`timescale 1ns/10ps

module CONTROL_TB();
	reg Clk, St, K, M;
	wire Idle, Done, Load, Sh, Ad;
	
	CONTROL DUT(
		.Clk(Clk),
		 .K(K),
		 .St(St),
		 .M(M),
		 .Idle(Idle),
		 .Done(Done),
		 .Load(Load),
		 .Sh(Sh),
		 .Ad(Ad)
	);
	
	initial begin
		Clk = 0;
		forever #5 Clk = ~Clk;
	end
	
	initial begin
		#10 St = 0;K = 0;M = 0;
		
		#10 St = 1;K = 0;M = 0;
		
		#10 St = 1;K = 0;M = 0;
		
		#10 St = 0;K = 0;M = 1;
		
		#10 St = 0;K = 0;M = 1;
		
		#10 St = 0;K = 1;M = 0;
		
		#10 St = 0;K = 1;M = 0;
		
		#10 St = 0;K = 0;M = 0;
		
		#10 St = 0;K = 0;M = 0;
	end
	
	initial
		#100 $stop;
	
endmodule