`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 01:42:06 PM
// Design Name: 
// Module Name: Lab02_tb
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


module Lab02_tb( );
    logic cin, cout;
    logic [7:0] A, B, S1, S2, S3;
    ripple_carry_8b D0(cin, A, B, cout, S1);
    carry_lookahead_8b D1(cin, A, B, cout, S2);
    prefix_8b D2(cin, A, B, cout, S3);
    
    initial begin
    A = 8'd34;
    B = 8'd62;
    cin = 0;
    #10
    A = 8'd1;
    B = 8'd4;
    cin = 1;
    #10
    $stop;
    end
endmodule
