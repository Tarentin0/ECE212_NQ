`timescale 1ns / 1ps

module decode_stage(
    input logic clk, reset, 
    input logic regwrite_c,
    input logic [31:0] instr_i, pcplus4_i,
    input logic [31:0] wd3_i,
    input logic [4:0] wadr3_i, 
    output logic [31:0] pcjumpaddr_o, pcbranchaddr_o, rd1_o, rd2_o, signextimm_o,
    output logic pcsrc_o, jump_o
    );
    
  import mips_decls_p::*;
    
  // Early check if branch is taken!
  logic iszero_c; 
  assign iszero_c = (rd1_o == rd2_o);
  
  
  // Decode instruction bits
  logic [4:0] rs, rt, rd;
  logic [15:0] imm;  // i-type immediate field
  logic [25:0] addr;  // j-type pseudo-address
  assign rs = instr_i[25:21];
  assign rt = instr_i[20:16];
  assign rd = instr_i[15:11];
  assign imm = instr_i[15:0];
  assign addr = instr_i[25:0];
  logic memtoreg_c;
  opcode_t     opcode;
  funct_t      funct;
  assign opcode = opcode_t'(instr_i[31:26]);
  assign funct  = funct_t'(instr_i[5:0]); // caution: will show garbage function codes for non-R-Type insns
  controller U_C(.opcode(opcode), .funct(funct), .zero(iszero_c), 
                  .pcsrc(pcsrc_o), .jump(jump_o));    
 
   
  // Compute Jump Address
  assign pcjumpaddr_o = { pcplus4_i[31:28], addr, 2'b00 };  
 
  // Comute Branch Address
  logic [31:0] signimmsh;
  signext     U_SE_D(.a(imm), .y(signextimm_o));

  sl2         U_IMMSH_D(.a(signextimm_o), .y(signimmsh));

  adder       U_PCADD_D(.a(pcplus4_i), .b(signimmsh), .y(pcbranchaddr_o));


  // Access Register File
  regfile     U_RF_D(.clk(clk), .we3(regwrite_c), .ra1(rs), .ra2(rt),
                     .wa3(wadr3_i), .wd3(wd3_i),
                     .rd1(rd1_o), .rd2(rd2_o));

    
endmodule