`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:07:49 PM
// Design Name: 
// Module Name: mpy_10
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


module mpy_10 ( input logic [12:0] a,
output logic [16:0] y );
assign y = (a << 3) + (a << 1);
endmodule

