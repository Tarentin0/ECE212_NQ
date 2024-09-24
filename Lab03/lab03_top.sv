`timescale 1ns / 1ps


module lab03_top(
    input logic clk, 
    input logic  [15:0] SW,
    output logic [15:0] LED,
    output logic [7:0] AN,
    output logic [6:0] SEG
    );
    
    

    assign LED[15:0]   = SW[15:0]; 
    logic [3:0]q, rem;
    
    div_4b D0 (SW[7:4], SW[3:0], q, rem);
    result_display U_TDISP(.quotient(q), .remainder(rem), .clk(clk), .seg_n(SEG), .an(AN));  

endmodule
