`timescale 1ns / 1ps

module memory_stage(
    input logic clk, reset, 
    input logic [31:0] instr_i, addr_i, wd_i,
    output logic [31:0] rd_o,
    output logic [31:0] writedata_o, dataadr_o,
    output logic memwrite_o
    );
  
  
  import mips_decls_p::*;
  
  // Decode instruction bits   
  logic memwrite_c;
  mips_decls_p::opcode_t     opcode;
  mips_decls_p::funct_t      funct;
  assign opcode = opcode_t'(instr_i[31:26]);
  assign funct  = funct_t'(instr_i[5:0]); // caution: will show garbage function codes for non-R-Type insns
  controller U_C(.opcode(opcode), .funct(funct), .zero(1'b0), 
                  .memwrite(memwrite_c));  
    
    
  dmem dmem(.clk, .we(memwrite_c), .adr(addr_i), .wd(wd_i), .rd(rd_o));
  
  assign writedata_o = wd_i;
  assign dataadr_o = addr_i;
  assign memwrite_o =  memwrite_c;   
       
endmodule
