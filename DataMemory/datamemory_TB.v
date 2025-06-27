`timescale 1ns/1ps

module datamemory_TB;

  reg clk;
  reg [9:0] address;
  reg [31:0] data;
  reg wren;

  wire [31:0] q;

  datamemory uut (
    .address(address),
    .clock(clk),
    .data(data),
    .wren(wren),
    .q(q)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    address = 0;
    data = 0;
    wren = 0;

    #10;

    // Escreve valor na posição 10
    address = 10;
    data = 32'hDEADBEEF;
    wren = 1;
    #10;

    // Escreve valor na posição 20
    address = 20;
    data = 32'hCAFEBABE;
    #10;

    wren = 0;

    // Lê posição 10
    address = 10;
    #10;
    $display("Leitura da posição 10: %h (esperado: DEADBEEF)", q);

    // Lê posição 20
    address = 20;
    #10;
    $display("Leitura da posição 20: %h (esperado: CAFEBABE)", q);

    // Lê posição não escrita (ex: 0)
    address = 0;
    #10;
    $display("Leitura da posição 0 (esperado: do Data.hex): %h", q);

    $stop;
  end

endmodule
