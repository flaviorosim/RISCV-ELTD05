`timescale 1ns / 1ps

module InstMem_TB;

  reg [9:0] address;
  reg clock;
  wire [31:0] q;

  InstMem dut (
    .address(address),
    .clock(clock),
    .q(q)
  );

  always #10 clock = ~clock;

  initial begin
    clock = 0;
    address = 0;

    $display("Começando teste kekeke");
    $display("Tempo(ns)\tEndereço\tInstrucao (hex)");

    #15; // aguarda meio ciclo para alinhar leitura

    // Lê os primeiros 16 endereços da memória
    repeat (16) begin
      @(posedge clock);
      $display("%8t\t%4d\t\t%h", $time, address, q);
      address = address + 1;
    end

    $stop;
  end

endmodule
