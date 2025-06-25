//Recomendações para gustavo e flavio do futuro:
//O multiplicador precisa operar em clock separado (CLK_MUL) vindo da PLL.
//Não misture CLK_MUL com CLK_SYS da MIPS.


module Multiplicador (Multiplicando, Multiplicador, Produto, Idle, Done, Clk, Rst, St);

	input [15:0] Multiplicando;
	input [15:0] Multiplicador;
	input Clk;
	input St;
	input Rst;
	output Idle;
	output Done;
	output [31:0] Produto;

	wire Load, Sh, Ad, K, M;
	wire [15:0] OperandoA;
	wire [15:0] OperandoB;
	wire [16:0] Soma;
	wire [31:0] Produto;
	wire [32:0] Saidas;
	
	
	assign M = Saidas[0];
	
	ACC acc (
		.Load(Load),
		.Sh(Sh),
		.Ad(Ad),
		.Clk(Clk),
		.Rst(Rst),
		.Entradas({Soma, Multiplicador}),
		.Saidas(Saidas)
	);

	assign Produto = Saidas[31:0];

	Counter counter (
		.Clk(Clk),
		.Load(Load),
		.K(K)
	);


	CONTROL control (
		.St(St),
		.Clk(Clk),
		.M(M),
		.K(K),
		.Load(Load),
		.Sh(Sh),
		.Ad(Ad),
		.Done(Done),
		.Idle(Idle)
	);

	assign OperandoB = Saidas[31:16];

	Adder adder (
		.OperandoA(Multiplicando),
		.OperandoB(OperandoB),
		.Soma(Soma)
	);

endmodule
