`timescale 1ns / 100ps 
module PC_TB;
    
    reg CLK, Reset, zeroFlag, jmpFlag, branchFlag;
    reg [31:0] branchOffset, jmpAddress;
    wire [31:0] addr;
    wire resetControl;

    PC uut (
        .CLK(CLK),
        .Reset(Reset),
        .zeroFlag(zeroFlag),
        .jmpFlag(jmpFlag),
        .branchFlag(branchFlag),
        .branchOffset(branchOffset),
        .jmpAddress(jmpAddress),
        .addr(addr),
        .resetControl(resetControl)
    );

    // Geração de clock
    initial CLK = 0;
    always #5 CLK = ~CLK; 

    // Teste inicial
    initial begin
   

        Reset = 0;
        zeroFlag = 0;
        jmpFlag = 0;
        branchFlag = 0;
        branchOffset = 32'h00000008;
        jmpAddress = 32'h00000ABC;

        
        Reset = 1; #10; 
        Reset = 0; #10; 

        #10;
        zeroFlag = 0;
        jmpFlag = 0;
        branchFlag = 0;

        
        jmpFlag = 1;
        jmpAddress = 32'h00000FFF;
        #10;
        jmpFlag = 0;

        
        branchFlag = 1;
        zeroFlag = 1;
        branchOffset = 32'hFFFFFFF8; 
        #10;
        branchFlag = 0;
        zeroFlag = 0;

        
        branchFlag = 1;
        zeroFlag = 0;
        branchOffset = 32'h00000010; 
        #10;
        branchFlag = 0;

        
        #50;
        $stop;
    end
endmodule
