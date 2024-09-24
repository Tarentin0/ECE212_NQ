`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 02:06:12 PM
// Design Name: 
// Module Name: Lab03_tb
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


module Lab03_tb();
logic [3:0] A, B, q, rem;
div_4b D0 (A, B, q, rem);
initial begin
A = 4'd2;
B = 4'd1;
#10;
A = 4'd7;
B = 4'd3;
#10;
A = 4'd15;
B = 4'd3;
#10;
A = 4'd1;
B = 4'd3;
#10;
A = 4'd13;
B = 4'd7;
#10;
$stop;
end
endmodule
