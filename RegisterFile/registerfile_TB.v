`timescale 1ns/100ps

module registerfile_TB;
    reg Clk, we, resetControl;
    reg [4:0] rs, rt, rd;
    reg [31:0] writeBack;
    wire [31:0] A, B;

    registerfile uut (
        .Clk(Clk),
        .we(we),
        .resetControl(resetControl), // Adicionado rstControl
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .writeBack(writeBack),
        .A(A),
        .B(B)
    );


    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; 
    end

    initial begin
        
        resetControl = 1;
        we = 0;
        rs = 0; rt = 0; rd = 0; writeBack = 0;
        #15; 

        resetControl = 0; 


        we = 1;
        rd = 5'd0; 
        writeBack = 32'hFFFFFFFF;
        #10; 


        we = 0; 
        #10; 

        we = 1; 
        rd = 5'd1; // registrador 1
        writeBack = 32'hAAAAAAAA;
        #10; // valor de writeBack escrito em r1.

        we = 0; 
        rs = 5'd1; // ler r1
        rt = 5'd2; // ler r2 (ainda 0)
        #10; 

        we = 1; 
        rd = 5'd2; // registrador 2
        writeBack = 32'h55555555;
        #10; 

        we = 0; 
        rs = 5'd1; rt = 5'd2; // Mantém a leitura de r1 em A e r2 em B
        #10; 


        $stop;
    end
endmodule