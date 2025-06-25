`timescale 1ns/10ps

module Counter_TB();
    reg Clk, Load;
    wire K;
    
    Counter DUT(
        .Clk(Clk),
        .Load(Load),
        .K(K)
    );
    
   
    initial begin
        Clk = 0;
        forever #10 Clk = ~Clk;
    end
    

    initial begin
        
        Load = 1;
        #20; 
        
   
        Load = 0;
        #140; 
        
        
        Load = 1;
        #20;
		  
        Load = 0;
        #100;
        
        
    end
    
	 initial 
			#200 $stop;
    
endmodule
