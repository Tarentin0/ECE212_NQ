`timescale 1ns / 1ps

module pr_e_m(
  input logic clk, reset,
  input logic [31:0] instr_i,
  input logic [31:0] aluresult_i,
  input logic [31:0] rd2_i,
  input logic [4:0] destreg_i,
  output logic [31:0] instr_o,
  output logic [31:0] aluresult_o,
  output logic [31:0] rd2_o,
  output logic [4:0] destreg_o
  );

  always_ff @ (posedge clk)
  if (reset) begin
    instr_o <= '0;
    aluresult_o <= '0;
    rd2_o <= '0;
    destreg_o <= '0;
  end
  else begin
    instr_o <= instr_i;
    aluresult_o <= aluresult_i;
    rd2_o <= rd2_i;
    destreg_o <= destreg_i;
  end
endmodule: pr_e_m
