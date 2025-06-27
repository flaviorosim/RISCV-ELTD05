module ALU(a,b,sel,out);
	input [31:0] a;
	input [31:0] b;
	input [1:0] sel;
	output reg [31:0] out;
	output zeroFlag;
	
	wire reg flag
	
	if (out == 32'b0) begin
		 flag = 1;
	end else begin
		 flag = 0;
	end
	
	assign zeroFlag = flag;
	
	always @(a, b, sel)
	begin
		case(sel)
			2'b00: out <= a+b;	
			2'b01: out <= a-b;	
			2'b10: out <= a&b;	
			2'b11: out <= a|b;	
		endcase

	end
 
endmodule