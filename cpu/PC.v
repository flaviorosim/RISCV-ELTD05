module PC(
    input CLK, Reset, zeroFlag, jmpFlag, branchFlag,
    input [31:0] branchOffset, jmpAddress,
    output reg [31:0] addr,
    output reg resetControl
);

    always @(posedge CLK or posedge Reset) begin
        if (Reset) begin
            addr <= 32'h240; // endereço inicial pro nosso grupo
            resetControl <= 0; 
        end
        else if (jmpFlag) begin
            addr <= jmpAddress + 32'h240; 
            resetControl <= 0; 
        end
        else if (branchFlag && !zeroFlag) begin   // B = 1, zero = 0
            addr <= addr + $signed(branchOffset) - 4; 
            resetControl <= 1; 
        end
        else begin
            addr <= addr + 4; 
            resetControl <= 0; 
        end
    end
endmodule
