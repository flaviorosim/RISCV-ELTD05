`timescale 1ns/1ps

module TB;

  // Clock e Reset
  reg CLK = 0;
  reg Reset = 1;

  // Sinais principais da CPU
  wire [31:0] ADDR, Data_BUS_WRITE, ADDR_Prog;
  wire [31:0] Data_BUS_READ, Prog_BUS_READ;
  wire CS, WE, CS_P;

  // Sinais de depuração para simulação e SignalTap
  wire [31:0] debug_PC;
  wire [31:0] debug_WRITE_DATA;
  wire [31:0] debug_WRITE_ADDR;
  wire        debug_WE;
  wire        debug_CS;

  // Clock de 50 MHz (20 ns de período)
  always #10 CLK = ~CLK;

  // Instanciação da CPU
  cpu uut (
    .CLK(CLK),
    .Reset(Reset),
    .Data_BUS_READ(Data_BUS_READ),
    .Prog_BUS_READ(Prog_BUS_READ),
    .ADDR(ADDR),
    .Data_BUS_WRITE(Data_BUS_WRITE),
    .ADDR_Prog(ADDR_Prog),
    .CS(CS),
    .WE(WE),
    .CS_P(CS_P),

    // Sinais adicionais para depuração
    .debug_PC(debug_PC),
    .debug_WRITE_DATA(debug_WRITE_DATA),
    .debug_WRITE_ADDR(debug_WRITE_ADDR),
    .debug_WE(debug_WE),
    .debug_CS(debug_CS)
  );

  // Exibição dos principais sinais de interesse
  initial begin
    $display("Time\tADDR\t\tWE\tCS\tData_BUS_WRITE\t\tADDR_Prog\tPC");
    $monitor("%0t\t%h\t%b\t%b\t%h\t%h\t%h",
      $time,
      debug_WRITE_ADDR,
      debug_WE,
      debug_CS,
      debug_WRITE_DATA,
      ADDR_Prog,
      debug_PC
    );
  end

  // Sequência de Reset e tempo total de simulação
  initial begin
    #20;
    Reset = 0;

    #200000; // 200 us (ajuste conforme necessário)
    $finish;
  end

endmodule
