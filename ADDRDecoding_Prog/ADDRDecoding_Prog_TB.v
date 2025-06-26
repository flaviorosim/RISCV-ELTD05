`timescale 1ns/100ps

module ADDRDecoding_Prog_TB;

    reg [31:0] addr;
    wire CS_P;
	 wire [31:0] iAddressInst;

    ADDRDecoding_Prog uut (
        .addr(addr), 
        .CS_P(CS_P),
		  .iAddressInst(iAddressInst)
    );

    initial begin
        addr = 32'h230;
        #10;

        addr = 32'h240; // limite inferior
        #10;

        addr = 32'h123F; // limite superior
        #10;

        addr = 32'h2F0F;
        #10;

        $finish;
    end
endmodule
