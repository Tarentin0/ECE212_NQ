//--------------------------------------------------------------
// maindec.sv - single-cycle MIPS instruction decode
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this file:
//    1. Use enum for opcodes declared in external package
//    2. Rewrite code to show control signals explicitly rather than
//       packed into a binary string (make intent clearer)
//    3. Use enum for control signals declared in external package
//    4. Use blocking assignments for comb. logic
//--------------------------------------------------------------

module maindec (
	input mips_decls_p::opcode_t opcode,
	output logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump,
	output logic [1:0] aluop
	);

	import mips_decls_p::*;
	always_comb begin
        if (opcode == OP_LW) begin
            assign memtoreg = 1;
            assign memwrite = 0;
            assign branch = 0;
            assign alusrc = 1;
            assign regdst = 0;
            assign regwrite = 1;
            assign jump = 0;
            assign aluop = 2'b00;
        end
        else if (opcode == OP_RTYPE) begin
            assign memtoreg = 0;
            assign memwrite = 0;
            assign branch = 0;
            assign alusrc = 0;
            assign regdst = 1;
            assign regwrite = 1;
            assign jump = 0;
            assign aluop = 2'b10;
        end
        else if (opcode == OP_SW) begin
            assign memtoreg = 0;
            assign memwrite = 1;
            assign branch = 0;
            assign alusrc = 1;
            assign regdst = 0;
            assign regwrite = 0;
            assign jump = 0;
            assign aluop = 2'b00;
        end
        else if (opcode == OP_BEQ) begin
            assign memtoreg = 0;
            assign memwrite = 0;
            assign branch = 1;
            assign alusrc = 0;
            assign regdst = 0;
            assign regwrite = 0;
            assign jump = 0;
            assign aluop = 2'b01;
        end
        else if (opcode == OP_J) begin
            assign memtoreg = 0;
            assign memwrite = 0;
            assign branch = 0;
            assign alusrc = 0;
            assign regdst = 0;
            assign regwrite = 0;
            assign jump = 1;
            assign aluop = 2'b11;
        end
        else if (opcode == OP_ADDI) begin
            assign memtoreg = 0;
            assign memwrite = 0;
            assign branch = 0;
            assign alusrc = 1;
            assign regdst = 0;
            assign regwrite = 1;
            assign jump = 0;
            assign aluop = 2'b00;
        end
        else begin 
            assign memtoreg = 0;
            assign memwrite = 0;
            assign branch = 0;
            assign alusrc = 0;
            assign regdst = 0;
            assign regwrite = 0;
            assign jump = 0;
            assign aluop = 2'b00;
        end
    end


endmodule // maindec
