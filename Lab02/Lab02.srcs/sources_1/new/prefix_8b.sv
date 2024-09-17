`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 02:40:11 PM
// Design Name: 
// Module Name: prefix_8b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module prefix_8b(
input logic Cin, [7:0] A, B,
output logic Cout, [7:0] S
    );
    logic [7:0] G, P;
    
    // Propagate and Generate
    assign P = A | B;
    assign G = A & B;
    
    //Top Row
    logic G0_1, G21, G43, G65, P0_1, P21, P43, P65;
    //Generate
    assign G0_1 = G[0] | (P[0]&Cin);
    assign G21 = G[2] | (P[2] & G[1]);
    assign G43 = G[4] | (P[4] & G[3]);
    assign G65 = G[6] | (P[6] & G[5]);
    //Propagate
    assign P0_1 = P[0] & 0;
    assign P21 = P[2] & P[1];
    assign P43 = P[4] & P[3];
    assign P65 = P[6] & P[5];
    
    //Second Row
    logic G1_1, G2_1, G53, G63, P63, P53;
    //Generate
    assign G1_1 = G[1] | (P[1]&G0_1);
    assign G2_1 = G21 | (P21 & G1_1);
    assign G53 = G[5] | (P[5] & G43);
    assign G63 = G65 | (P65 & G43);
    //Propagate
    assign P63 = P65 & P43;
    assign P53 = P[5] & P43;
    
    //Third Row
    logic G6_1, G5_1, G4_1, G3_1;
    //Generate
    assign G6_1 = G63 | (P63 & G2_1);
    assign G5_1 = G53 | (P53 & G2_1);
    assign G4_1 = G43 | (P43 & G2_1);
    assign G3_1 = G[3] | (P[3] & G2_1);
    
    //Last Row
    assign Cout = G[7] | (P[7] & G6_1);
    
    //Final digits:
    assign S[0] = A[0] ^ B[0] ^ Cin;
    assign S[1] = A[1] ^ B[1] ^ G0_1;
    assign S[2] = A[2] ^ B[2] ^ G1_1;
    assign S[3] = A[3] ^ B[3] ^ G2_1;
    assign S[4] = A[4] ^ B[4] ^ G3_1;
    assign S[5] = A[5] ^ B[5] ^ G4_1;
    assign S[6] = A[6] ^ B[6] ^ G5_1;
    assign S[7] = A[7] ^ B[7] ^ G6_1;

endmodule
