`timescale 1ns/10ps

module Multiplicador_TB;

    reg [15:0] Multiplicando;
    reg [15:0] Multiplicador;
    reg Clk, Rst, St;

    wire [31:0] Produto;
    wire Idle, Done;
    
    
    Multiplicador DUT (
        .Multiplicando(Multiplicando),
        .Multiplicador(Multiplicador),
        .Produto(Produto),
        .Idle(Idle),
        .Done(Done),
        .Clk(Clk),
        .Rst(Rst),
        .St(St)
    );
    
    
    initial begin
        Clk = 0;
        forever #10 Clk = ~Clk;
    end
    
    
    initial begin
        
        Rst = 1;
        St = 0;
        Multiplicando = 0;
        Multiplicador = 0;
        
        
        #20;
        Rst = 0;
        
        Multiplicando = 16'd5; //5
        Multiplicador = 16'd3; //3
		  //tem que dar 15 = 0000 1111
        St = 1;
        #20 St = 0;
        
        
        wait(Done);
        #20 Rst = 1;
		  #15 Rst = 0;
        
        Multiplicando = 16'd10; //10
        Multiplicador = 16'd4;  //4
		  //tem que dar 40 = 0010 1000
        #10 St = 1;
        #20 St = 0;
        
        wait(Done);
        #20;

        Multiplicando = 16'd1000; //1000
        Multiplicador = 16'd50; //50 
		  //tem que dar 50.000 = 1100 0011 0101 0000
        #10 St = 1;
        #20 St = 0;

        wait(Done);
        #20;
        
    end
	 
	 initial 
		#800 $stop;
   
endmodule