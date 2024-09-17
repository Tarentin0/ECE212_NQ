`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 01:28:54 PM
// Design Name: 
// Module Name: full_adder
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


module full_adder(
input logic a, b, cin,
output logic s, cout
    );
logic w0, w1, w2;
assign w0 = a ^ b;
assign w1 = a & b;
assign w2 = w0 & cin;
assign s = cin ^ w0;
assign cout = w1 | w2;
endmodule
