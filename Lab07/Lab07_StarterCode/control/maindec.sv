//-------------------------------------------------------
// maindec.sv - Multicyle MIPS contoroller FSM
// David_Harris@hmc.edu 8 November 2005
// Update to SystemVerilog 17 Nov 2010 DMH
// Refactord and updated by John Nestor
// Key changes to this module:
//  1. replace state code parameters with enum
//     (simulator will display symboic state names)
//  2. import opcodes from mips_decls_p package
//  3. set control signals individually in state machine
//     instead of as a bitvector (easier to understand
//     and follows state diagram in Fig. 7.42)
//------------------------------------------------

module maindec(input  logic       clk, reset, 
               input  mips_decls_p::opcode_t  opcode, 
               output logic       pcwrite, memwrite, irwrite, regwrite,
               output logic       alusrca, branch, iord, memtoreg, regdst,
               output logic [1:0] alusrcb,
               output logic [1:0] aluop);

   import mips_decls_p::*;
   
  // state register
  state_t state, next;
  always_ff @(posedge clk or posedge reset)	begin		
    if(reset) state <= FETCH;
    else state <= next;
  end





  // ADD CODE HERE
 always_comb begin
     if (state == FETCH) begin
        branch <= 1'b0;
        pcwrite <= 1'b1;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b1;
        regwrite <= 1'b0;
        alusrca <= 1'b0;
        alusrcb <= 2'b01;
        aluop <= 2'b00;
        regdst <= 0;
        memtoreg <= 0;
        next <= DECODE;
     end
     if (state == DECODE) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b0;
        alusrca <= 1'b0;
        alusrcb <= 2'b11;
        aluop <= 2'b00;
        regdst <= 0;
        memtoreg <= 0;
        if (opcode == OP_LW || opcode == OP_SW) begin
            next <= MEMADR;
        end
        else if (opcode == OP_RTYPE) begin 
            next <= RTYPEEX;
        end
        else if (opcode == OP_BEQ) begin
            next <= BEQEX;
        end
        else if (opcode == OP_ADDI) begin
            next <= ADDIEX;
        end
     end
     if (state == MEMADR) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b0;
        alusrca <= 1'b1;
        alusrcb <= 2'b10;
        aluop <= 2'b00;
        regdst <= 0;
        memtoreg <= 0;
        if (opcode == OP_LW) begin
            next <= MEMRD;
        end
        else begin 
            next <= MEMWR;
        end
     end
     if (state == MEMRD) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b1;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b0;
        alusrca <= 1'b0;
        alusrcb <= 2'b00;
        aluop <= 2'b00;
        regdst <= 0;
        memtoreg <= 0;
        next <= MEMWB;
     end
     if (state == MEMWB) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b1;
        alusrca <= 1'b0;
        alusrcb <= 2'b00;
        aluop <= 2'b00;
        regdst <= 0;
        memtoreg <= 1;
        next <= FETCH;
     end
     if (state == MEMWR) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b1;
        memwrite <= 1'b1;
        irwrite <= 1'b0;
        regwrite <= 1'b0;
        alusrca <= 1'b0;
        alusrcb <= 2'b00;
        aluop <= 2'b00;
        regdst <= 0;
        memtoreg <= 0;
        next <= FETCH;
     end
     if (state == RTYPEEX) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b0;
        alusrca <= 1'b1;
        alusrcb <= 2'b00;
        aluop <= 2'b10;
        regdst <= 0;
        memtoreg <= 0;
        next <= RTYPEWB;
     end
     if (state == RTYPEWB) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b1;
        alusrca <= 1'b0;
        alusrcb <= 2'b00;
        aluop <= 2'b00;
        regdst <= 1;
        memtoreg <= 0;
        next <= FETCH;
     end
     if (state == BEQEX) begin
        branch <= 1'b1;
        pcwrite <= 1'b0;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b0;
        alusrca <= 1'b1;
        alusrcb <= 2'b00;
        aluop <= 2'b01;
        regdst <= 0;
        memtoreg <= 0;
        next <= FETCH;
     end
     if (state == ADDIEX) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b0;
        alusrca <= 1'b1;
        alusrcb <= 2'b10;
        aluop <= 2'b00;
        regdst <= 0;
        memtoreg <= 0;
        next <= ADDIWB;
     end
     if (state == ADDIWB) begin
        branch <= 1'b0;
        pcwrite <= 1'b0;
        iord <= 1'b0;
        memwrite <= 1'b0;
        irwrite <= 1'b0;
        regwrite <= 1'b1;
        alusrca <= 1'b0;
        alusrcb <= 2'b00;
        aluop <= 2'b00;
        regdst <= 0;
        memtoreg <= 0;
        next <= FETCH;
     end
     
 end


 

endmodule
