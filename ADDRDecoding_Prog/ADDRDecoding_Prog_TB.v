`timescale 1ns/1ps

module ADDRDecoding_Prog_TB;

    // Inputs
    reg [31:0] addr;

    // Outputs
    wire CS_P;

    // Instantiate the Unit Under Test (UUT)
    ADDRDecoding_Prog uut (
        .addr(addr), 
        .CS_P(CS_P)
    );

    // Test Cases
    initial begin
        addr = 32'hF0;
        #10;

        addr = 32'h240;
        #10;

        addr = 32'h300;
        #10;

        addr = 32'h63F;
        #10;

        addr = 32'h1A14;
        #10;

        $finish;
    end
endmodule
