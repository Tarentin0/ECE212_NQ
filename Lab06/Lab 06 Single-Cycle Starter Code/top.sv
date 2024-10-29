//--------------------------------------------------------------------
// top.v - top-level MIPS single cycle with instruction and data memories
// David_Harris@hmc.edu 9 November 2005
// Updated to SystemVerilog and modfied for clarity
// John Nestor, May 2018
// Key changes to this module:
//   1. Modfied dmem to use byte addressing rather than word addressing
//      for consistency
//--------------------------------------------------------------------

module top(
    input logic         clk, reset,
    output logic [31:0] w5, w8,
    output logic        mw
    );

    import mips_decls_p::*;

    // instantiate instruction memory
    logic [31:0]   pc, instr;
    imem imem(.adr(pc), .rd(instr));


    // decompose instruction bits
    opcode_t opcode;
    assign opcode = opcode_t'(instr[31:26]);
    funct_t funct;
    assign funct = funct_t'(instr[5:0]); // caution: will show garbage function codes for non-R-Type insns


    // instantiate datapath and control components
    logic [31:0] d, w0, w1, w2, w3, ja, w4, w6, w7, w9, w10, w11;
    logic z, mtr, oc, as, rdst, rw, j;
    logic [2:0] alucontrol;
    controller D4 (opcode, funct, z, mtr, mw, pcsrc, as, rdst, rw, j, alucontrol);
    flopr #(32) D0 (clk, reset, d, pc);
    adder D1 (pc, 32'd4, w1);
    adder D2 (w1, w0, w2);
    mux2 #(32) D3 (w1, w2, pcsrc, w3);
    mux2 #(32) D5 (w3, ja, j, d);
    assign ja = {w1[31:28], instr[25:0], 2'b00};
    signext D6 (instr[15:0], w4);
    assign w0 = {w4[29:0], 2'b00};
    mux2 #(32) D7 (w5, w4, as, w6);
    alu D8 (w7, w6, alucontrol, w8, z);
    mux2 #(32) D9 (w8, w9, mtr, w10);
    mux2 #(32) D10 (instr[20:16], instr[15:11], rdst, w11);
    regfile D11 (clk, rw, instr[25:21], instr[20:16], w11, w10, w7, w5);
    
    
    
    



    // instantiate data memory
    dmem dmem(.clk, .we(mw), .adr(w8), .wd(w5), .rd(w9));


endmodule
