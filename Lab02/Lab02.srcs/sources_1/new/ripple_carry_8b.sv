`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 01:35:03 PM
// Design Name: 
// Module Name: ripple_carry_8b
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


module ripple_carry_8b(
input logic cin, [7:0] A, B,
output logic cout, [7:0] S
    );
    logic [6:0] carry;
    full_adder D0 (A[0], B[0], cin, S[0], carry[0]);
    full_adder D1 (A[1], B[1], carry[0], S[1], carry[1]);
    full_adder D2 (A[2], B[2], carry[1], S[2], carry[2]);
    full_adder D3 (A[3], B[3], carry[2], S[3], carry[3]);
    full_adder D4 (A[4], B[4], carry[3], S[4], carry[4]);
    full_adder D5 (A[5], B[5], carry[4], S[5], carry[5]);
    full_adder D6 (A[6], B[6], carry[5], S[6], carry[6]);
    full_adder D7 (A[7], B[7], carry[6], S[7], cout);
endmodule
