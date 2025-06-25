module CONTROL (
	input Clk, K, St, M,
	output reg Idle, Done, Load, Sh, Ad
);

	reg [1:0] state;


	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3; 
	


	always @(*) begin
		Load = 0; Sh = 0; Ad = 0; Idle = 0; Done = 0;
		case (state)
			S0: begin
				Idle = 1;
				if(St) Load = 1;
			end
			
			S1: begin
				if(M) Ad = 1;
				else  Ad = 0;
			end
			
			S2: Sh = 1;
				
			S3: Done = 1;
	
		endcase
	end


	always @(posedge Clk) begin
			case (state)
				S0: begin
					if(St) state <= S1;
					else state <= S0;
				end
				
				S1: state <= S2;
				
				S2: begin
					if(K) state <= S3;
					else state <= S1;
				end
				
				S3: state <= S0;
				
				default: state <= S0;
				
			endcase
	end

endmodule
