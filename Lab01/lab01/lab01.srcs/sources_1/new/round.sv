`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:16:13 PM
// Design Name: 
// Module Name: round
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


module round(
        input [16:0] a,
        output [12:0] b
    );
    logic [12:0] c;
    always_comb begin
    if (a[3]) begin
    c = a[16:4]+1;
    end
    else begin
    c = a[16:4];
    end
    end
    assign b = c;
    
endmodule
