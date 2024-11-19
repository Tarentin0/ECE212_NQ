module pr_d_e(input logic clk, reset,
  input logic [31:0] instr_i,
  input logic [31:0] rd1_i, rd2_i,
  input logic [31:0] signimm_i,
  output logic [31:0] instr_o,
  output logic [31:0] rd1_o, rd2_o,
  output logic [31:0] signimm_o
  );

  always_ff @ (posedge clk)
  if (reset) begin
    instr_o <= 32'd0;
    rd1_o <= 0;
    rd2_o <= 0;
    signimm_o <= '0;
  end
  else begin
    instr_o <= instr_i;
    rd1_o <= rd1_i;
    rd2_o <= rd2_i;
    signimm_o <= signimm_i;
  end
endmodule: pr_d_e
