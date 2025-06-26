module registerfile (
    input CLK, WE, rstControl,
    input [4:0] rs, rt, rd,
    input [31:0] writeBack,
    output reg [31:0] A, B
);    
    reg [31:0] register [31:0]; 
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1) 
            register[i] <= 32'h0;
    end

    always @(posedge CLK) begin
        if (rstControl) begin
            A <= 32'h0;
            B <= 32'h0;
        end else begin
            if (rs == 0) 
                A <= 32'h0; 
            else 
                A <= register[rs];

            if (rt == 0) 
                B <= 32'h0; 
            else 
                B <= register[rt];
				if (WE && rd != 0) 
                register[rd] <= writeBack; 
        end
    end
	 
	
	 
endmodule
