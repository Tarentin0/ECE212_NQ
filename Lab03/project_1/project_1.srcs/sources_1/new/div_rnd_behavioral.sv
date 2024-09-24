`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 01:49:08 PM
// Design Name: 
// Module Name: div_rnd_behavioral
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


module div_rnd_behavioral(
input logic [3:0] rem, div,
output logic quote,[3:0] rem2
    );
    logic [3:0]d;
    assign d = rem - div;
    always_comb begin
        if (d[3] == 1) 
            begin
            quote = 0;
            rem2 = rem;
            end
        else
            begin
            quote = 1;
            rem2 = d;
            end
            
    end
endmodule
