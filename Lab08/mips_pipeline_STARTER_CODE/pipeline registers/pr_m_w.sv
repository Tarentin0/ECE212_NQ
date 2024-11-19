`timescale 1ns / 1ps

module pr_m_w(
  input logic clk, reset,
  input logic [31:0] instr_i,
  input logic [31:0] aluresult_i,
  input logic [31:0] memresult_i,
  input logic [4:0] destreg_i,
  output logic [31:0] instr_o,
  output logic [31:0] aluresult_o,
  output logic [31:0] memresult_o,
  output logic [4:0] destreg_o
  );

  always_ff @ (posedge clk)
  if (reset) begin
    instr_o <= '0;
    aluresult_o <= '0;
    memresult_o <= '0;
    destreg_o <= '0;
  end
  else begin
    instr_o <= instr_i;
    aluresult_o <= aluresult_i;
    memresult_o <= memresult_i;
    destreg_o <= destreg_i;
  end
endmodule: pr_m_w
