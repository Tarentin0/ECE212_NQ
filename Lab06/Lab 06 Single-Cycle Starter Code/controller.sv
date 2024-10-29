module controller(
    input mips_decls_p::opcode_t opcode,
    input mips_decls_p::funct_t funct,
    input logic        zero,
    output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [2:0] alucontrol
    );
    logic [1:0] aluop;
    logic branch;
    maindec D0 (opcode,memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump,aluop);
    aludec D1 (funct, aluop, alucontrol);
    assign pcsrc = zero & branch;



endmodule
