/*


a) Qual a latência do sistema?

O sistema apresenta um pipeline de 5 estágio, portanto a latência é de 5 pulsos de clock.

b) Qual o throughput do sistema?
8 M * 1 = 8 mips

c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer para o multiplicador e para o sistema? (Indique a FPGA utilizada)
Resposta:


Fmax Multiplicador = 291.12 MHz, para o sistema = 279.14 MHz
F do sistema = 8 MHz

FPGA utilizada: Cyclone IV GX = EP4CGX150DF31I7AD

d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)
Resposta: 


Fmax do sistema = 8,21 MHz

FPGA Cyclone IV GX = EP4CGX150DF31I7AD

e) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com metaestabilidade? Por que?
Resposta: 

Não, já que a PLL inserida é usada para manter os dois clocks em fase, garantindo a sincronização correta.

f) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos de velocidade? Por que?
Resposta: 
Não, um multiplicador shift-add não é eficiente em velocidade para o sistema em questão.
Ele opera em múltiplos ciclos de clock, o que causa gargalos no pipeline e reduz o desempenho geral do sistema.

g) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência de operação maior). Para cada modificação
sugerida, qual a nova latência e throughput do sistema?
Resposta:
Adicionar mais estágios ao pipeline do MIPS. Por exemplo, transformar um pipeline de 5 estágios em um de 7 estágios,
quebrando as operações combinacionais longas em partes menores. Throughput aumenta para ~11 MIPS e a latência aumentaria para 7 ciclos de clock.

Substituição do Multiplicador por blocos de multiplicador dedicados no FPGA, que são combinacionais, podendo aumentar o Throughput para 16 MIPS
e a latência se manteria inalterada.


*/
module cpu(
    input CLK, Reset,
    input [31:0] Data_BUS_READ, Prog_BUS_READ,
    output [31:0] ADDR, Data_BUS_WRITE, ADDR_Prog,
    output CS, WE, CS_P
);

	(*keep=1*)wire [31:0] imag, writeBack, dataOut_Imm, dataOut_IM, dout;
	(*keep=1*)wire [31:0] dataOut_Mux, dataOut_ALU, dataOut_PC, dataOut_Mult, dataOut_Ex, dataOut_D;
	(*keep=1*)wire [24:0] ctrl0, ctrl1;
	(*keep=1*)wire [25:0] ctrl2;
	(*keep=1*)wire CLK_MUL, CLK_SYS;
	(*keep=1*)wire [31:0] wA, wB;
	(*keep=1*)wire reset_control;
	(*keep=1*)wire zeroFlag;
	(*keep=1*)wire CS_WB;
	wire[31:0] op2ALU, dataOut_Extend;
	wire [9:0] iAddress;
	wire iWE;
	
	assign ADDR_Prog = dataOut_PC - 32'h240;
	assign iAddress = dataOut_Ex - 32'h24A;
	assign ADDR = dataOut_Ex;	
   assign CS_WB = ctrl2[25];
	assign WE = ctrl1[3];
	assign Data_BUS_WRITE = wB;
	
	PLL pll (
		.inclk0 (CLK),
		.c0 (CLK_SYS),
		.c1 (CLK_MUL)
	);	
	

	
	InstMem IM(
		.clock(CLK_SYS),
		.address(ADDR_Prog),
		.q(dataOut_IM)
	);
		
	pc PC(
		.Clk(CLK_SYS),
		.Reset(Reset),
		.zeroFlag(zeroFlag),
		.jmpFlag(ctrl0[0]),
		.branchFlag(ctrl1[1]),
		.jmpAddress(dataOut_Extend),
		.branchOffset(dataOut_Imm),
		.addr(dataOut_PC),
		.resetControl(reset_control)
	);
	
	mux MuxProgMem(
		.sel(CS_P),
		.a(Prog_BUS_READ),
		.b(dataOut_IM),
		.out(tempOut)
	);
	wire [31:0] tempOut;

	
	 
	 ADDRDecoding_Prog addrDecoding_Prog(
		.addr(dataOut_PC),
		.CS_P(CS_P)
	 );

	registerfile Register_File(
		.Clk(CLK_SYS),
		.we(ctrl2[9]),
		.rs(ctrl0[24:20]),
		.rt(ctrl0[19:15]),
		.rd(ctrl2[14:10]),
		.writeBack(writeBack),
		.A(wA),
		.B(wB),
		.resetControl(reset_control)
	);
	
	
		
	control Control(
		.in(tempOut),
		.out(ctrl0)
	);
	 
	extend Extend(
		.in(tempOut),
		.out(dataOut_Extend)
	);
	
	register IMM(
		.Clk(CLK_SYS),
		.Reset(reset_control),
		.in(dataOut_Extend),
		.out(dataOut_Imm)
	);
	

	register CTRL1 (
		.Clk(CLK_SYS),
		.Reset(reset_control),
		.in(ctrl0[24:0]),
		.out(ctrl1[24:0])
	);
	 
	 
	Multiplicador multiplicador(
		.Clk(CLK_MUL),
		.St(ctrl1[5]),
		.Multiplicador(wA[15:0]),
		.Multiplicando(wB[15:0]),
		.Produto(dataOut_Mult)
	);
	
	mux MUX1(
		.sel(ctrl1[8]),
		.a(wB),
		.b(dataOut_Imm),
		.out(op2ALU)
	);
	

	  
	alu ALU(
		.sel(ctrl1[7:6]),
		.a(wA),
		.b(op2ALU),
		.out(dataOut_ALU),
		.zeroFlag(zeroFlag)
	);

	mux MuxALU(
		.sel(ctrl1[4]),
		.a(dataOut_Mult),
		.b(dataOut_ALU),
		.out(dataOut_Ex)
	);


	ADDRDecoding ADDR_Decoding (
		.WE(ctrl1[3]),
		.iWE(iWE),
		.iAddress(imag),
		.addr(dataOut_Ex),
		.cs(CS)
	);

	
	datamemory DM (
		.clock(CLK_SYS), 
		.wren(iWE), 
		.address(iAddress),
		.data(wB),
		.q(dout)
	);
	
	register #(26) CTRL2 (
        .Clk(CLK_SYS),
        .Reset(Reset),
        .in({CS,ctrl1[24:0]}),
        .out(ctrl2)
    );
	 
	mux MuxDataMem(
		.sel(CS_WB),
		.a(Data_BUS_READ), 
		.b(dout),
		.out(dataOut_Mux)
	);
	
	mux MuxF(
		.sel(ctrl2[2]),
		.a(dataOut_Mux), 
		.b(dataOut_D),
		.out(writeBack)
	);
	

	register D(
		.Clk(CLK_SYS),
		.Reset(Reset),
		.in(dataOut_Ex),
		.out(dataOut_D)
	);

 
 endmodule 
