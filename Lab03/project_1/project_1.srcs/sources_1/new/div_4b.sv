`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 01:57:07 PM
// Design Name: 
// Module Name: div_4b
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


module div_4b(
input logic [3:0] A, B,
output logic [3:0]q, rem 
    );
    logic [3:0] w0,w1,w2,w3;
    div_rnd_structural D0 ({3'b000, A[3]}, B, q[3], w0); 
    div_rnd_structural D1 ({w0[2:0], A[2]}, B, q[2], w1);
    div_rnd_behavioral D2 ({w1[2:0], A[1]}, B, q[1], w2);
    div_rnd_behavioral D3 ({w2[2:0], A[0]}, B, q[0], rem);

endmodule
