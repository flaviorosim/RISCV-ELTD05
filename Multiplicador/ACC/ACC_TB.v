`timescale 1ns/10ps
module ACC_TB();
	reg Load, Sh, Ad, Clk, Rst;
	reg [8:0] Entradas;
	wire [8:0] Saidas;
	
	ACC  DUT(
		.Load(Load),
		.Sh(Sh),
		.Ad(Ad),
		.Clk(Clk),
		.Rst(Rst),
		.Entradas(Entradas),
		.Saidas(Saidas)
	);
	
	initial begin
		Clk = 0;
		forever #10 Clk = ~Clk;
	end
	
	initial begin
	Rst = 0;
        Load = 0;
        Sh = 0;
        Ad = 0;
        Entradas = 9'b0;
        
  
        Rst = 1;
        #20 Rst = 0;
        
        
        Entradas = 9'b000001101; 
        Load = 1;
        #20 Load = 0;
        
        
        Entradas = 9'b100110000; 
        Ad = 1;
        #20 Ad = 0;
        
        
        Sh = 1;
        #20 Sh = 0;
		  #10;
	end
	
	initial 
		#120 $stop;
endmodule