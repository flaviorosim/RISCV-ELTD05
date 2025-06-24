`timescale 1ns/100ps

module ADDRDecoding_TB;
    reg [31:0] addr;
	 reg WE;
    wire [31:0] iAddress;
    wire CS, iWE;

    // Instancia o módulo
    ADDRDecoding uut (
        .addr(addr),
        .CS(CS),
		  .WE(WE),
		  .iWE(iWE),
        .iAddress(iAddress)
    );

    initial begin
	
		  WE = 0;
		  
		  addr = 32'h205;
		  #10;
		  WE = 1;
		  #10;
		  
		  WE = 0;
        addr = 32'h24A;
		  #10;
		 
		  WE = 1;
		  #10;



		  
        addr = 32'h1249;
		  #10;
	
		  addr = 32'h1EE2;
		  #10;
		  
        $finish;
    end
endmodule

