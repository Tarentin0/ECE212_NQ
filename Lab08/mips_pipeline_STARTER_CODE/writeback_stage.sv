`timescale 1ns / 1ps

module writeback_stage(
    input logic clk, reset, 
    input logic [31:0] instr_i, aluresult_i, memresult_i,
    output logic [31:0] result_o,
    output logic regwrite_o, memtoreg_w
    );

  import mips_decls_p::*;

  // Decode instruction bits   
  logic memtoreg_c;
  assign memtoreg_w = memtoreg_c;
  mips_decls_p::opcode_t     opcode;
  mips_decls_p::funct_t      funct;
  assign opcode = opcode_t'(instr_i[31:26]);
  assign funct  = funct_t'(instr_i[5:0]); // caution: will show garbage function codes for non-R-Type insns
  controller U_C(.opcode(opcode), .funct(funct), .zero(1'b0), 
                  .memtoreg(memtoreg_c), .regwrite(regwrite_o));  
                    
    mux2 #(32)  U_RESMUX(.d0(aluresult_i), .d1(memresult_i),.s(memtoreg_c), .y(result_o));
   
    
endmodule
