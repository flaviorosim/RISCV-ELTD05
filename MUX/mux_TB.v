`timescale 1ns/100ps

module mux_TB;

   
    reg [31:0]a;         
    reg [31:0]b;       
    reg sel;       
    wire [31:0]out;      

    mux DUT (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin

        a = 32'hF320; b = 0; sel = 0;
        #10; 
		  sel = 1;
		  
        #10;
			
		  a = 32'h8001; b = 32'hFFFFFFFF; sel = 0;
        #10;
		  sel = 1;
		  #20
			
        $finish;
    end

endmodule
