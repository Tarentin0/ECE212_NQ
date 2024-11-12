//--------------------------------------------------------------------
// top.v - top-level MIPS multi cycle with instruction and data memories
// David_Harris@hmc.edu 9 November 2005
// Updated to SystemVerilog and modfied for clarity
// John Nestor, May 2018
// Lauren Biernacki, November 2024
// Key changes to this module:
//   1. Modfied dmem to use byte addressing rather than word addressing
//      for consistency
//   2. Added datapath implementation
//--------------------------------------------------------------------

module top_multi(
    input logic         clk, reset,
    output logic [31:0] writedata, dataadr,
    output logic        memwrite
    );

    import mips_decls_p::*;

    // instantiate unified memory (with memfile.dat)
    logic [31:0]  readdata;
    mem mem(.clk(clk), .we(memwrite), .a(dataadr), .wd(writedata), .rd(readdata));

    //instantiate controller
    logic zero, pcen, irwrite, regwrite, alusrca, iord, memtoreg, regdst;
    logic [1:0] alusrcb, pcsrc;
    logic [2:0] alucontrol;
    controller C(.clk, .reset, .opcode, .funct, .zero,
                .pcen, .memwrite, .irwrite, .regwrite,
                .alusrca, .iord, .memtoreg, .regdst, 
                .alusrcb, .pcsrc, .alucontrol);


    // decompose instruction bits
    logic [31:0] instr;
    opcode_t     opcode;
    funct_t      funct;
    logic [4:0]  rs, rt, rd;  // register fields
    logic [15:0] immed;  // i-type immediate field
    logic [25:0] jmpimmed;  // j-type pseudo-address
    assign rs =  instr[25:21];
    assign rt =  instr[20:16];
    assign rd =  instr[15:11];
    assign immed    = instr[15:0];
    assign jmpimmed = instr[25:0];  
    assign opcode   = opcode_t'(instr[31:26]);
    assign funct    = funct_t'(instr[5:0]); // caution: will show garbage function codes for non-R-Type insns

   // internal datapath signals
   logic [4:0]   writereg;
   logic [31:0]  pcnext, pc;
   logic [31:0]  data, srca, srcb;
   logic [31:0]	 a, b;
   logic [31:0]	 aluresult, aluout;
   logic [31:0]	 signimm;    // the sign-extended immediate
   logic [31:0]	 signimmsh;	 // the sign-extended immediate shifted left by 2
   logic [31:0]	 regresult, rd1, rd2;
   logic [31:0]	 pcjump;     // target address of jump
   assign writedata = rd2;

   // instantiate datapath and control components
   flopenr #(32) PCR (.clk(clk), .reset(reset), .en(pcen), .d(pcnext), .q(pc));

   mux2 #(32)    ADRMUX (.d0(pc), .d1(aluout), .s(iord), .y(dataadr));

   flopenr #(32) IREG (.clk(clk), .reset(reset), .en(irwrite), .d(readdata), .q(instr));

   flopr #(32)   MDREG (.clk(clk), .reset(reset), .d(readdata), .q(data));

   mux2 #(5)     WRMUX (.d0(rt), .d1(rd), .s(regdst), .y(writereg));

   mux2 #(32)    RESMUX (.d0(aluout), .d1(data), .s(memtoreg), .y(regresult));

   regfile       RF (.clk(clk), .we3(regwrite), .ra1(rs), .ra2(rt), .wa3(writereg), .wd3(regresult), .rd1(rd1), .rd2(rd2));

   flopr #(32)   AREG (.clk(clk), .reset(reset), .d(rd1), .q(a));

   flopr #(32)   BREG (.clk(clk), .reset(reset), .d(rd2), .q(b));

   signext       SE (.a(immed), .y(signimm));

   sl2           IMMSH (.a(signimm), .y(signimmsh));

   assign pcjump = {pc[31:28], jmpimmed, 2'b00};  
   
   mux2  #(32)   SRCAMUX (.d0(pc), .d1(a), .s(alusrca), .y(srca));

   mux4 #(32)    SRCBMUX (.d0(b), .d1(32'h4), .d2(signimm), .d3(signimmsh), .s(alusrcb), .y(srcb));

   alu           ALU (.a(srca), .b(srcb), .f(alucontrol), .y(aluresult), .zero(zero));
   
   flopr #(32)   ALUREG (.clk(clk), .reset(reset), .d(aluresult), .q(aluout));

   mux3  #(32)   PCMUX (.d0(aluresult), .d1(aluout), .d3(pcjump), .s(pcsrc), .y(pcnext));

endmodule
