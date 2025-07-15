module registerfile (
    input Clk, we, resetControl,
    input [4:0] rs, rt, rd,
    input [31:0] writeBack,
    output reg [31:0] A, B
);    
    reg [31:0] register [31:0]; 
    integer j;

    initial begin
        for (j = 0; j < 32; j = j + 1) 
            register[j] <= 32'h0;
    end

    always @(posedge Clk) begin
        
        if (resetControl) begin
            A <= 32'h0;
            B <= 32'h0;
        end else begin
            // Leitura
            if (rs == 0) 
                A <= 32'h0; 
            else 
                A <= register[rs];

            if (rt == 0) 
                B <= 32'h0; 
            else 
                B <= register[rt];
				if (we && rd != 0) 
                register[rd] <= writeBack; 
        end
    end
	 
endmodule
