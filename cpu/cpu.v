// a) Qual a latência do sistema?

// b) Qual o throughput do sistema?

// c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analyzer para o multiplicador e para o sistema?
// Frequência máxima operacional (f_max):

// d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)

// e) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com metaestabilidade? Por quê?

// f) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos de velocidade? Por quê?

// g) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência de operação maior). Para cada modificação sugerida, qual a nova latência e throughput do sistema?



module cpu(
    input CLK, Reset,
    input [31:0] Data_BUS_READ, Prog_BUS_READ,
    output [31:0] ADDR, Data_BUS_WRITE, ADDR_Prog,
    output CS, WE, CS_P
);

    (*keep=1*)wire [31:0] addressCorrection_mem1, dataOut_Imm;
    (*keep=1*)wire [31:0] dataOut_RF1, dataOut_RF2;
    (*keep=1*)wire [31:0] writeBack, register_A, register_B;
    (*keep=1*)wire [31:0] dataOut_DM;
    (*keep=1*)wire [31:0] dataOut_ALU, dataOut_Mult, dataOut_Ex, dataOut_D;
    (*keep=1*)wire [24:0] ctrl0, ctrl1;
	 (*keep=1*)wire [25:0] ctrl2;
	 (*keep=1*)wire [31:0] dataOut_IM;
	 (*keep=1*)wire [31:0] iAddressInst;
    (*keep=1*)wire [31:0] dataOut_PC;
    (*keep=1*)wire CLK_MUL, CLK_SYS;
    (*keep=1*)wire dataOut_M;
    (*keep=1*)wire [31:0] fioA, fioB;
    (*keep=1*)wire resetControl;
    (*keep=1*)wire zeroFlag;
	 (*keep=1*)wire [31:0] dout;
    (*keep=1*)wire pc_jmpFlag;
    (*keep=1*)wire pc_branchFlag;
	 (*keep=1*)wire CS_WB;
	 	  
    assign CS_WB = ctrl2[25]; 

	
	
	PLL pll (
		.inclk0 (CLK),
		.c0 (CLK_MUL),
		.c1 (CLK_SYS)
	);	
	
	assign ADDR = dataOut_Ex;
	assign WE = ctrl1[3];
	assign ADDR_Prog = dataOut_PC - 32'h9F0; // porque???
	assign iAddress = dataOut_Ex - 32'h6F0;
	assign Data_BUS_WRITE = fioB;

//Instruction Fetch
	
	InstMem IM(
		.clock(CLK_SYS),
		.address(iAddressInst), // verifica ?
		.q(dataOut_IM)
	);
		
	PC pc(
		.CLK(CLK_SYS),
		.Reset(Reset),
		.zeroFlag(zeroFlag),
		.jmpFlag(ctrl0[0]), //a ver
		.branchFlag(ctrl1[1]), // a ver
		.jmpAddress(dataOut_Extend),
		.branchOffset(dataOut_Imm),
		.addr(dataOut_PC),
		.resetControl(resetControl)
	);
	
   wire [31:0] progOut;

	
	mux MuxProgMem(
		.sel(CS_P),
		.a(Prog_BUS_READ),
		.b(dataOut_IM),
		.out(progOut)
	);


	
	 ADDRDecoding_Prog addrDecoding_Prog(
		.addr(dataOut_PC),
		.iAddressInst(iAddressInst), // verifica
		.CS_P(CS_P)
	 );

	 
// Instruction Decode	 

	registerfile RegisterFile(
		.CLK(CLK_SYS),
		.WE(ctrl2[9]),		// confirmar os bits
		.rs(ctrl0[24:20]), // confirmar os bits
		.rt(ctrl0[19:15]), // confirmar os bits
		.rd(ctrl2[14:10]), // confirmar os bits
		.writeBack(writeBack),
		.A(fioA),
		.B(fioB),
		.rstControl(resetControl)
	);
	
	
		
	control Control(
		.in(progOut),
		.out(ctrl0)
	);
	 
	extend Extend(
		.en(en), // enable do control Tem que CRIAR
		.in(progOut),
		.out(dataOut_Extend)
	);
	
	register IMM(
		.CLK(CLK_SYS),
		.Reset(resetControl),
		.in(dataOut_Extend),
		.out(dataOut_Imm)
	);
	
	wire [31:0] dataOut_Extend;

	register CTRL1 (
		.CLK(CLK_SYS),
		.Reset(resetControl),
		.in(ctrl0[24:0]),
		.out(ctrl1[24:0])
	);
	 
	 
//Execute

	Multiplicador multiplicador(
		.Clk(CLK_MUL),
		.St(ctrl1[5]),
		.Multiplicador(fioA[15:0]),
		.Multiplicando(fioB[15:0]),
		.Produto(dataOut_Mult)
	);
	wire[31:0] op2ALU;
	
	mux MuxOp2ALU(
		.sel(ctrl1[8]), // Vai ter que arrumar o bit certo do ctrl
		.a(fioB),
		.b(dataOut_Imm),
		.out(op2ALU)
	);
	

	  
	alu ALU(
		.sel(ctrl1[7:6]), // Vai ter que arrumar os bits certo do ctrl
		.a(fioA),
		.b(op2ALU),
		.out(dataOut_ALU),
		.zeroFlag(zeroFlag)
	);

	mux MuxALU(
		.sel(ctrl1[4]), // Vai ter que arrumar o bit certo do ctrl da multiplicação(arrumar a e b dependendo se o bit em 1 significar mult)
		.a(dataOut_Mult),
		.b(dataOut_ALU),
		.out(dataOut_Ex)
	);

//Memory 
	 wire iWE;
	 wire [9:0] iAddress;
	ADDRDecoding AddrDecoding (
		.WE(ctrl1[3]),
		.iWE(iWE),
		.iAddress(iAddress),
		.addr(dataOut_Ex),
		.CS(CS)
	);

	
	datamemory Data_Memory (
		.clock(CLK_SYS), 
		.wren(iWE),  
		.address(iAddress),
		.data(fioB),
		.q(dout) 
	);
	
	register D(
		.CLK(CLK_SYS),
		.Reset(Reset),
		.in(dataOut_Ex),
		.out(dataOut_D)
	);

	
   register #(26) CTRL2 (
        .Clk(CLK_SYS),
        .Reset(Reset),
        .in({CS,ctrl1[24:0]}),
        .out(ctrl2)
    );
	
// WriteBack

	 
	mux MuxDataMem(
		.sel(CS_WB),
		.a(Data_BUS_READ), 
		.b(dout), 
		.out(dataOut_DM)
	);
	
	mux MuxF(
		.sel(ctrl2[2]), // verificar bit e logica (1 e 0)
		.a(dataOut_DM), 
		.b(dataOut_D), 
		.out(writeBack)
	);
	


 endmodule 