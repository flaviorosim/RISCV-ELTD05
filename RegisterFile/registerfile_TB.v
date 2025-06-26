`timescale 1ns/100ps

module registerfile_TB;
    reg CLK, WE, rstControl;
    reg [4:0] rs, rt, rd;
    reg [31:0] writeBack;
    wire [31:0] A, B;

    registerfile uut (
        .CLK(CLK),
        .WE(WE),
        .rstControl(rstControl), // Adicionado rstControl
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .writeBack(writeBack),
        .A(A),
        .B(B)
    );


    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK; 
    end

    initial begin
        
        rstControl = 1;
        WE = 0;
        rs = 0; rt = 0; rd = 0; writeBack = 0;
        #15; 

        rstControl = 0; 


        WE = 1;
        rd = 5'd0; 
        writeBack = 32'hFFFFFFFF;
        #10; 


        WE = 0; 
        #10; 

        WE = 1; 
        rd = 5'd1; // registrador 1
        writeBack = 32'hAAAAAAAA;
        #10; // valor de writeBack escrito em r1.

        WE = 0; 
        rs = 5'd1; // ler r1
        rt = 5'd2; // ler r2 (ainda 0)
        #10; 

        WE = 1; 
        rd = 5'd2; // registrador 2
        writeBack = 32'h55555555;
        #10; 

        WE = 0; 
        rs = 5'd1; rt = 5'd2; // Mantém a leitura de r1 em A e r2 em B
        #10; 


        $stop;
    end
endmodule