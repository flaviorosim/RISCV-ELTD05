module control (
    input [31:0] in,
    output [24:0] out
);
    reg [5:0] opcode, funct;
    reg [4:0] rs, rt, rd;
    reg WR_regfile, mux_immediate_or_regB;
    reg [1:0] ALU_sel;
    reg mul_Start, mux2_ALU;
    reg WR_mem, CS_WB_2;
    reg branchFlag, jmpFlag;

    assign out = {
        rs,
        rt,
        rd,
        WR_regfile,
        mux_immediate_or_regB,
        ALU_sel,
        mul_Start,
        mux2_ALU,
        WR_mem,
        CS_WB_2,
        branchFlag,
        jmpFlag
    };

    always @(*) begin
        opcode = in[31:26]; //6 bits mais significativos
        funct  = in[5:0];
        rs = in[25:21];
        rt = in[20:16];
        rd = in[15:11];

        // Default (NOP-like)
        WR_regfile = 0;
        WR_mem = 0;
        mux_immediate_or_regB = 0;
        mux2_ALU = 1;
        mul_Start = 0;
        CS_WB_2 = 0;
        jmpFlag = 0;
        branchFlag = 0;
        ALU_sel = 2'b00;

        case (opcode)
            6'd34: begin // lw
                WR_regfile = 1;
                WR_mem = 0;
                mux_immediate_or_regB = 1;
                mux2_ALU = 1;
                mul_Start = 0;
                CS_WB_2 = 0;
                ALU_sel = 2'b00;
                rd = rt;
            end

            6'd35: begin // sw
                WR_regfile = 0;
                WR_mem = 1;
                mux_immediate_or_regB = 1;
                mux2_ALU = 1;
                mul_Start = 0;
                CS_WB_2 = 0;
                ALU_sel = 2'b00;
					 rd = rs;
            end

            6'd36: begin // bne
                WR_regfile = 0;
                WR_mem = 0;
                mux_immediate_or_regB = 0;
                mux2_ALU = 1;
                mul_Start = 0;
                CS_WB_2 = 0;
                ALU_sel = 2'b01; // SUB
                branchFlag = 1;
					 rd = 5'b0;
            end

            6'd37: begin // addi
                WR_regfile = 1;
                WR_mem = 0;
                mux_immediate_or_regB = 1;
                mux2_ALU = 1;
                mul_Start = 0;
                CS_WB_2 = 1;
                ALU_sel = 2'b00; 
                rd = rt;
            end

            6'd38: begin // ori
                WR_regfile = 1;
                WR_mem = 0;
                mux_immediate_or_regB = 1;
                mux2_ALU = 1;
                mul_Start = 0;
                CS_WB_2 = 1;
                ALU_sel = 2'b11; // OR
                rd = rt;
            end

            6'd2: begin // jmp
					 jmpFlag = 1; 
            end

            6'd12: begin 
                case (funct)
                    6'd32: begin // add
                        WR_regfile = 1;
                        mux_immediate_or_regB = 0;
                        mux2_ALU = 1;
								mul_Start = 0;
                        CS_WB_2 = 1;
                        ALU_sel = 2'b00;
								rd = rd;
								
                    end

                    6'd34: begin // sub
                        WR_regfile = 1;
                        mux_immediate_or_regB = 0;
                        mux2_ALU = 1;
								mul_Start = 0;
                        CS_WB_2 = 0;
                        ALU_sel = 2'b01;
								rd = rd;
                    end

                    6'd50: begin // mul
                        WR_regfile = 1;
                        mux_immediate_or_regB = 0;
                        mux2_ALU = 0;
                        mul_Start = 1;
                        CS_WB_2 = 1;
                        ALU_sel = 2'b00;
								rd = rd;
                    end
						  6'd36: begin // and
                        WR_regfile = 1;
                        mux_immediate_or_regB = 0;
                        mux2_ALU = 0;
                        mul_Start = 1;
                        CS_WB_2 = 0;
                        ALU_sel = 2'b10;
								rd = rd;
                    end
						  6'd37: begin // or
                        WR_regfile = 1;
                        mux_immediate_or_regB = 0;
                        mux2_ALU = 0;
                        mul_Start = 1;
                        CS_WB_2 = 0;
                        ALU_sel = 2'b11;
								rd = rd;
                    end
                    
                endcase
            end
 
        endcase
		  
    end
endmodule
