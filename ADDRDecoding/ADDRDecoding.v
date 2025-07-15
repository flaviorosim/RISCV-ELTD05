module ADDRDecoding(
    input [31:0] addr,
    input WE,
    output reg cs, iWE,
    output reg [31:0] iAddress
);
    reg [31:0] sup;
    reg [31:0] inf;


    initial begin
        sup = 32'h649; 
        inf = 32'h24A; 
        cs = 0;
        iWE = 0;
        iAddress = 0;
    end

    always @(*) begin
        if (addr >= inf && addr <= sup) begin
            cs = 1;
            iWE = WE;
            iAddress = addr - inf;
        end else begin
            cs = 0;
            iWE = 0;
            iAddress = 0;
        end
    end
endmodule
