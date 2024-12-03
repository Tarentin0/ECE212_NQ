`timescale 1ns / 1ps

module execute_stage(
    input logic clk, reset, 
    input logic [31:0] instr_i,
    input logic [31:0] rd1_i, rd2_i, signextimm_i, 
    output logic [31:0] aluresult_o, 
    output logic [4:0] destreg_o,
    output logic iszero_o, regwrite_e, memtoreg_e
    );
  
  import mips_decls_p::*;
       
  // Decode instruction bits
  logic regdst_c, alusrc_c;
  logic [2:0] aluctrl_c;
  logic [4:0] rt, rd;
  assign rt = instr_i[20:16];
  assign rd = instr_i[15:11];
  mips_decls_p::opcode_t     opcode;
  mips_decls_p::funct_t      funct;
  assign opcode   = opcode_t'(instr_i[31:26]);
  assign funct    = funct_t'(instr_i[5:0]); // caution: will show garbage function codes for non-R-Type insns
  controller U_C(.opcode(opcode), .funct(funct), .zero(1'b0), 
                  .alusrc(alusrc_c), .regdst(regdst_c), .alucontrol(aluctrl_c), .regwrite(regwrite_e), .memtoreg(memtoreg_e));  



  // Do ALU logic
  logic [31:0] srcb;
  mux2 #(32)  U_SRCBMUX(.d0(rd2_i), .d1(signextimm_i), .s(alusrc_c), .y(srcb));

  alu U_ALU(.a(rd1_i), .b(srcb), .f(aluctrl_c), .y(aluresult_o), .zero(iszero_o));
  
  // Select destination regiter
  mux2 #(5)   U_WRMUX(.d0(rt), .d1(rd), .s(regdst_c), .y(destreg_o));    
    
    
endmodule