`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:25:49 PM
// Design Name: 
// Module Name: lab01_test
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


module lab01_test(
        
    );
    logic [12:0] in, rounded;
    logic [16:0] out;
    assign in = 13'd0;
    celsius_to_fahren_x10 D1 (in,out);
    round D2 (out, rounded);
    initial begin
    #5;
    in = {9'd100,4'd0};
    #5;
    in = 13'd50;
    #5;
    in = 13'd75;
    #5;
    $stop;
    end
endmodule
