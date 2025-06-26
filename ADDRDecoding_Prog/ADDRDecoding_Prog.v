module ADDRDecoding_Prog(
    input [31:0] addr,
    output reg CS_P,
    output reg [9:0] iAddressInst  // mudei aqui índice de 0 a 1023
);

    // nosso grupo:
    // base 2 * 0x120 = 0x240
    // 1K de palavras: 0x240 + 0xFFF = 0x23FF
    // bytes = 0x1000
    localparam BASE = 32'h00000240;
    localparam TOP  = BASE + 4096 - 1; // 0x33F

    always @(*) begin
        if (addr >= BASE && addr <= TOP) begin
            CS_P = 1;
	    iAddressInst = (addr - BASE) >> 2; // deslocamento
        end else begin
            CS_P = 0;
            iAddressInst = 0;
        end
    end

endmodule
