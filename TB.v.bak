`timescale 1ns / 1ps

module TB;

    reg CLK, Reset;

    reg [31:0] Data_BUS_READ, Prog_BUS_READ;
    wire [31:0] ADDR, Data_BUS_WRITE, ADDR_Prog;
    wire CS, WE, CS_P;

    cpu dut (
        .CLK(CLK),
        .Reset(Reset),
        .Data_BUS_READ(Data_BUS_READ),
        .Prog_BUS_READ(Prog_BUS_READ),
        .ADDR(ADDR),
        .Data_BUS_WRITE(Data_BUS_WRITE),
        .ADDR_Prog(ADDR_Prog),
        .CS(CS),
        .WE(WE),
        .CS_P(CS_P)
    );

    // Inicialização dos sinais e simulação
    initial begin
        $init_signal_spy("dut/CLK_SYS", "CLK_SYS", 1);
        $init_signal_spy("dut/CLK_MUL", "CLK_MUL", 1);
        $init_signal_spy("dut/writeBack", "writeBack", 1);
        $init_signal_spy("dut/dataOut_PC", "dataOut_PC", 1);
        $init_signal_spy("dut/ADDR", "ADDR", 1);
        $init_signal_spy("dut/Data_BUS_WRITE", "Data_BUS_WRITE", 1);
        $init_signal_spy("dut/WE", "WE", 1);
        $init_signal_spy("dut/CS", "CS", 1);

        CLK = 0;
        Reset = 1;            // inicializa com o reset ativo
        Data_BUS_READ = 32'd0;
        Prog_BUS_READ = 32'd0;

        #10 Reset = 0;        // Desativa reset

        #200000 $stop;
    end

    always #5 CLK = ~CLK;

endmodule
