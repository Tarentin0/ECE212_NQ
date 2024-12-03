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

module top_pipeline(
    input logic         clk, reset,
    output logic [31:0] writedata, dataadr,
    output logic        memwrite
    );

logic [4:0]    destreg_e, destreg_m, destreg_w;
logic [31:0]   branchaddr, jumpaddr, pcplus4_f, pcplus4_d,
                 instr_f, instr_d, instr_e, instr_m, instr_w,
                 rd1_d, rd2_d, rd1_e, rd2_e, rd2_m, extimm_d, extimm_e,
                 aluresult_e, aluresult_m, aluresult_w, memresult_m, memresult_w,
                 result_w, rs_d, rt_d, ALU_a, ALU_b;
logic [1:0] forward_a_e, forward_b_e;
logic flush_e, forward_a_d, forward_b_d, stall_f, stall_d, isZero_d;


assign isZero_d = rs_d == rt_d;

mux2 #(32) D8(rd1_d, aluresult_m, forward_a_d, rs_d);
mux2 #(32) D7(rd2_d, aluresult_m, forward_b_d, rt_d);
mux3 #(32) D6(rd1_e, result_w, aluresult_m, forward_a_e, ALU_a);
mux3 #(32) D5(rd2_e, result_w, aluresult_m, forward_b_e, ALU_b);

hazard D9 (regwrite_w, regwrite_m, memtoreg_m, branch_d, pcsrc_d, jump_d, regwrite_e, memtoreg_e, destreg_e, destreg_w, destreg_m, rd1_e, rd2_e, rd1_d, rd2_d, forward_a_e, forward_b_e, flush_e, forward_a_d, forward_b_d, stall_f, stall_d);

  import mips_decls_p::*;
logic reset1, reset2, dataNop, controlNop;
assign reset1 = dataNop || reset;
assign reset2 = reset || controlNop;
  // Instantiate necessary datapath signals
  
  
   
  // Instantiate necessary control signals
  logic         pcsrc_d, jump_d, iszero_e;
  logic [4:0] rt,rd;
  
  always_comb begin
  
    if (((rt == destreg_e) && destreg_e != 0) || ((rt == destreg_m) && destreg_m != 0) || ((rd == destreg_e) && destreg_e != 0) || ((rd == destreg_m) && destreg_m != 0)) begin
        dataNop = 1'b1;
        controlNop = 1'b0;
    end 
    else if (instr_d[31:26] == OP_J || instr_d[31:26] == OP_BEQ) begin
        controlNop = 1'b1;
        dataNop = 1'b0;
    end
    else begin
        dataNop = 1'b0;
        controlNop = 1'b0;
    end
    
    if (instr_d[31:26] == OP_RTYPE || instr_d[31:26] == OP_SW) begin
        rt = instr_d[25:21];
        rd = instr_d[20:16];
        end
    else begin
        rt = instr_d[25:21];
        rd = 5'b11111;
    end
  end
 
 
  //--------------------------------------------------------------
  //   FETCH Stage
  //--------------------------------------------------------------
  fetch_stage   FETCH(.clk(clk), .reset(reset),
  //(~dataNop&~controlNop&~pcsrc_d)|(controlNop&~dataNop&pcsrc_d)|jump_d
                            .pcen_c(!flush_e), .pcsrc_c(pcsrc_d), .jump_c(jump_d),       // External control signals used by stage 
                            .pcbranchaddr_i(branchaddr), .pcjumpaddr_i(jumpaddr),    // Inputs to stage  
                            .instr_o(instr_f), .pcplus4_o(pcplus4_f));               // Outputs of stage                 
                    
  pr_f_d        FD_PIPEREG(.clk(clk), .reset(reset2), .redo(stall_f), 
                            .instr_i(instr_f), .pcplus4_i(pcplus4_f),                // Pipeline register
                            .instr_o(instr_d), .pcplus4_o(pcplus4_d));
  
  
  //--------------------------------------------------------------
  //   DECODE Stage
  //--------------------------------------------------------------            
  decode_stage  DECODE(.clk(clk), .reset(reset), .instr_i(instr_d), 
                            .regwrite_c(regwrite_w),                                                // External control signals used by stage 
                            .pcplus4_i(pcplus4_d), .wadr3_i(destreg_w), .wd3_i(result_w),           // Inputs to stage              
                            .pcjumpaddr_o(jumpaddr), .pcbranchaddr_o(branchaddr),                   // Outputs of stage
                            .rd1_o(rd1_d), .rd2_o(rd2_d), .signextimm_o(extimm_d),
                            .pcsrc_o(pcsrc_d), .jump_o(jump_d), .branch_d(branch_d)); 
                                           
  pr_d_e        DE_PIPEREG(.clk(clk), .reset(stall_f), 
                            .instr_i(instr_d), .rd1_i(rd1_d), .rd2_i(rd2_d), .signimm_i(extimm_d),  // Pipeline register
                            .instr_o(instr_e), .rd1_o(rd1_e), .rd2_o(rd2_e), .signimm_o(extimm_e));
                            
                            
  //--------------------------------------------------------------
  //   EXECUTE Stage
  //--------------------------------------------------------------
  execute_stage EXECUTE(.clk(clk), .reset(reset), .instr_i(instr_e),                                     
                            .rd1_i(ALU_a), .rd2_i(ALU_b), .signextimm_i(extimm_e),                  // Inputs to stage 
                            .aluresult_o(aluresult_e), .destreg_o(destreg_e),                       // Outputs of stage
                            .iszero_o(iszero_e), .memtoreg_e(memtoreg_e));                                                   // Is Zero

  pr_e_m        EM_PIPEREG(.clk(clk), .reset(reset), 
                            .instr_i(instr_e), .aluresult_i(aluresult_e), .rd2_i(ALU_b), .destreg_i(destreg_e),  // Pipeline register
                            .instr_o(instr_m), .aluresult_o(aluresult_m), .rd2_o(rd2_m), .destreg_o(destreg_m));
                            
                            
  //--------------------------------------------------------------
  //   MEMORY Stage
  //--------------------------------------------------------------
  memory_stage  MEMORY(.clk(clk), .reset(reset), .instr_i(instr_m), 
                            .addr_i(aluresult_m), .wd_i(rd2_m),                                   // Inputs to stage
                            .rd_o(memresult_m), .memtoreg_m(memtoreg_m),                                                   // Outputs of stage
                            .writedata_o(writedata), .dataadr_o(dataadr), .memwrite_o(memwrite)); // Testbench output signals
    
  pr_m_w        MW_PIPEREG(.clk(clk), .reset(reset),
                            .instr_i(instr_m), .aluresult_i(aluresult_m), .memresult_i(memresult_m), .destreg_i(destreg_m), // Pipeline register
                            .instr_o(instr_w), .aluresult_o(aluresult_w), .memresult_o(memresult_w), .destreg_o(destreg_w));
                        
                            
  //--------------------------------------------------------------
  //   WRITEBACK Stage
  //--------------------------------------------------------------                           
  writeback_stage  WRITEBACK(.clk(clk), .reset(reset), .instr_i(instr_w),        
                            .aluresult_i(aluresult_w), .memresult_i(memresult_w), .memtoreg_w(memtoreg_w),   // Inputs to stage
                            .result_o(result_w), .regwrite_o(regwrite_w));          // Outputs to stage
    



endmodule
