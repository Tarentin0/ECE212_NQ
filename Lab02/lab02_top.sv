`timescale 1ns / 1ps


module lab02_top(
    input logic clk,
    input logic  [7:0] in1, in2,
    output logic [7:0] out 
    );
    
    
    logic [7:0] d1, d2, d3;
    logic w0, w1;
    assign w1 = 0;
    // Connect your adder implementation here
    carry_lookahead_8b D0 (w1, d1, d2, w0, d3);
    always_ff @(posedge clk) begin
        d1 <= in1;
        d2 <= in2; 
        out <= d3;
    end
    
    
    
endmodule
