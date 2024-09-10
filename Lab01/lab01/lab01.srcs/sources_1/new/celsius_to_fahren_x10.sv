`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:08:52 PM
// Design Name: 
// Module Name: celsius_to_fahren_x10
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


module celsius_to_fahren_x10(
        input [12:0] a,
        output [16:0] b
    );
    assign b = (a<<4) + (a<<1) + {13'd320, 4'b0000};
    
endmodule
