module ADDRDecoding_Prog(
    input [31:0] addr,
    output reg CS_P,
	 output reg [31:0] iAddressInst

);

    localparam INF = 32'h240;
    localparam SUP = 32'h123F; 
	 
    initial begin
        CS_P = 0; 
    end

    always @(*) begin
        if (addr >= INF && addr <= SUP) begin
            CS_P = 1;
				iAddressInst = addr - INF; 
		  end
        else begin
            CS_P = 0; 
				iAddressInst = 0;
		  end
    end

endmodule
	