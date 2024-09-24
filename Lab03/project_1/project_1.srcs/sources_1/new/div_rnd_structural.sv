`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 01:25:04 PM
// Design Name: 
// Module Name: div_rnd_structural
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


module div_rnd_structural(
        input logic [3:0] rem, div,
        output logic quote,[3:0] rem2
    );
    logic [3:0] results,cins;
    full_adder D0 (rem[0],!div[0],1,results[0],cins[0]);
    full_adder D1 (rem[1],!div[1],cins[0],results[1],cins[1]);
    full_adder D2 (rem[2],!div[2],cins[1],results[2],cins[2]);
    full_adder D3 (rem[3],!div[3],cins[2],results[3],cins[3]);
    mux D4 (results[0],rem[0],results[3],rem2[0]);
    mux D5 (results[1],rem[1],results[3],rem2[1]);
    mux D6 (results[2],rem[2],results[3],rem2[2]);
    mux D7 (results[3], rem[3], results[3], rem2[3]);
    assign quote = !results[3];
endmodule
