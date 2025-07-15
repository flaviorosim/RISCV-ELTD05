`timescale 1ns/100ps
module ADDRDecoding_TB;
    reg [31:0] addr;
    reg WE;
    wire cs, iWE;
    wire [31:0] iAddress;

    ADDRDecoding uut (
        .addr(addr),
        .WE(WE),
        .cs(cs),
        .iWE(iWE),
        .iAddress(iAddress)
    );

    initial begin
        addr = 0;
        WE = 0;

        #10 addr = 32'h041; WE = 1; #10;
		  
        #10 addr = 32'h24A; WE = 1; #10;
		  
        #10 addr = 32'h3A3; WE = 1; #10;
		  
		  
        #10 addr = 32'h649; WE = 1; #10;

        #10 addr = 32'h90F; WE = 1; #10;

       
        $finish;
    end
endmodule

