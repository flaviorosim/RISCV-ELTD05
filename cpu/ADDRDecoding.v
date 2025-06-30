module ADDRDecoding(
    input [31:0] addr,
    input WE,
    output reg CS, iWE,
    output reg [31:0] iAddress
);
    localparam INF = 32'h24A;
	 localparam SUP = 32'h1249;


 
    initial begin
        CS = 0;
        iWE = 0;
        iAddress = 0;
    end

    always @(*) begin
        // Verifica se o endereço está no intervalo permitido
        if (addr >= INF && addr <= SUP) begin
            CS = 1;
            iWE = WE; 
            iAddress = addr - INF; 
        end else begin
            CS = 0;
            iWE = 0;
            iAddress = 0; 
        end
    end
endmodule
