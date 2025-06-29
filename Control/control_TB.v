`timescale 1ns / 100ps

module control_TB;   
   reg [31:0] in;
   wire [24:0] out;

   control uut (
     .in(in),
     .out(out)
   );

   initial begin
     in = 32'b0;
     
   
     #10 in = 32'h344352A0; // Instrução de ADD
     #10 $display("Entrada: in = %h", in); // Exibir entrada
     #10 $display("Esperado: out = 0001000011010101000010000"); // Saída esperada
     #10 $display("Gerado: out = %b", out); // Saída gerada

     // Finalizar simulação
     #10 $finish;
   end

   initial begin
     $monitor("in = %h, out = %b", in, out);
   end
endmodule
