`timescale 1ns / 1ps

module fetch_stage(
    input logic clk, reset, 
    input logic pcen_c, pcsrc_c, jump_c,
    input logic  [31:0] pcbranchaddr_i, pcjumpaddr_i,
    output logic [31:0] instr_o, 
    output logic [31:0] pcplus4_o
    );  
    
    // PC Register and PC+4 Loop
    logic [31:0] pc, pcnext, pcnext_br;

    flopenr #(32) PC_REG(.clk(clk), .reset(reset), .en(pcen_c), .d(pcnext), .q(pc)); 

    adder PC_ADD(.a(pc), .b(32'h4), .y(pcplus4_o));

    mux2 #(32) PCMUX_SRC(.d0(pcplus4_o), .d1(pcbranchaddr_i), .s(pcsrc_c), .y(pcnext_br));

    mux2 #(32)  PCMUX_J(.d0(pcnext_br), .d1(pcjumpaddr_i), .s(jump_c), .y(pcnext));

    // Read from instruction memory
    imem imem(.adr(pc), .rd(instr_o));
    
endmodule