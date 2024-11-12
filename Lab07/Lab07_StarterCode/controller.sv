module controller(input  logic       clk, reset,
                  input mips_decls_p::opcode_t opcode,
                  input mips_decls_p::funct_t funct,
                  input  logic       zero,
                  output logic       pcen, memwrite, irwrite, regwrite,
                  output logic       alusrca, iord, memtoreg, regdst,
                  output logic [1:0] alusrcb, pcsrc,
                  output logic [2:0] alucontrol);

  logic [1:0] aluop;
  logic       branch, pcwrite;
    maindec D0 (clk, reset, opcode, pcwrite, memwrite, irwrite, regwrite, alusrca, branch, iord, memtoreg, regdst, alusrcb, aluop);
    aludec D1 (funct, aluop, alucontrol);
    assign pcsrc = zero & branch;
    assign pcen = pcsrc | pcwrite;





 
endmodule
