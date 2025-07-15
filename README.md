# RISCV-ELTD05

MIPS RISC CPU com Pipeline de 5 Estágios
Este projeto consiste na implementação de uma CPU RISC com arquitetura pipeline de 5 estágios, baseada nas CPUs MIPS, utilizando Verilog HDL para síntese em FPGAs da família Altera Cyclone IV GX. O projeto foi desenvolvido como parte de um trabalho de graduação, com um conjunto de instruções (ISA) modificado e requisitos específicos de implementação e teste.

# Características Principais

Arquitetura: CPU RISC pipelined de 5 estágios (Instruction Fetch, Instruction Decode, Execute, Memory, Write Back).


Word Size: 32 bits (Big Endian).


Instruções: Todas as instruções são de 4 bytes.


Registradores: 32 registradores de uso geral (r0 a r31), com r0 hard-wired em 0.


Memória de Programa: 1kWord, alocada a partir de 240h.


Memória de Dados: 1kWord, alocada a partir de 24Ah.


Multiplicador Dedicado: O sistema inclui um módulo multiplicador de 16 bits que opera com um clock diferente (CLK_MUL) do clock do sistema (CLK_SYS), mantendo um throughput de 1 instrução/ciclo de clock do sistema.



PLL: Utiliza o IP ALTPLL do Quartus para gerar os clocks CLK_SYS e CLK_MUL.





