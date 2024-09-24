`timescale 1ns / 1ps


module mux(
    input logic d0, d1, 
    input logic  select,
    output logic y
    );
    
    always_comb begin
        if(select) 
            y = d1;
        else
            y = d0;
    end

endmodule
