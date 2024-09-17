`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 02:09:09 PM
// Design Name: 
// Module Name: carry_lookahead_8b
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


module carry_lookahead_8b(
input logic Cin, [7:0] A, B,
output logic Cout, [7:0] S
    );
    logic [7:0] G, P, carry;
    logic w0, w1;
    
    // Propagate and Generate
    assign P = A | B;
    assign G = A & B;
    
    //Block 1
    //Adder Chain
    full_adder D0 (A[0], B[0], Cin, S[0], carry[0]);
    full_adder D1 (A[1], B[1], carry[0], S[1], carry[1]);
    full_adder D2 (A[2], B[2], carry[1], S[2], carry[2]);
    full_adder D3 (A[3], B[3], carry[2], S[3], w0);
    //Lookahead   
    assign carry[3] = ((Cin)&(P[0]&(P[1]&(P[2])&(P[3]))))|(((((((G[0]) & (P[1]))|(G[1]))&(P[2]))|(G[2]))&(P[3]))|(G[3]));
    
    //Block 2
    //Adder Chain
    full_adder D4 (A[4], B[4], carry[3], S[4], carry[4]);
    full_adder D5 (A[5], B[5], carry[4], S[5], carry[5]);
    full_adder D6 (A[6], B[6], carry[5], S[6], carry[6]);
    full_adder D7 (A[7], B[7], carry[6], S[7], w1);
    //Lookahead
    assign Cout = ((carry[3])&(P[4]&(P[5]&(P[6])&(P[7]))))|(((((((G[4]) & (P[5]))|(G[5]))&(P[6]))|(G[6]))&(P[7]))|(G[7]));

endmodule
