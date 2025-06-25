`timescale 1ns/10ps

module Adder_TB();
	reg [3:0] OperandoA, OperandoB;
	wire [4:0] Soma;
	
	Adder DUT(
       .OperandoA(OperandoA),
       .OperandoB(OperandoB),
       .Soma(Soma)
   );
	
	initial begin
		OperandoA = 1;
		OperandoB = 2;
		
		#10 
		OperandoA = 2;
		OperandoB = 2;
		
		#10 
		OperandoA = 10;
		OperandoB = 6;
		
		#10 
		OperandoA = 15;
		OperandoB = 15;
		
		#10;
	end
endmodule