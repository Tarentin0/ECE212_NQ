//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette College
// Create Date: 01/09/2024 10:11:26 AM
// Design Name: 
// Module Name: disp_mux_seven_seg
// Project Name:  ECE 211 Digital Circuits 1
//-----------------------------------------------------------------------------
// Author        : Lauren Biernacki <biernacl@lafayette.edu>
// Created       : Jan 2024
// Acknowledgment: Faraz Khan <https://simplefpga.blogspot.com/2012/07/seven-segment-led-multiplexing-circuit.html>, July 2012
//-----------------------------------------------------------------------------
// Description   : Time-multiplexing circuit to display multi-digit seven-segment 
//                 display with active-low outputs
//                 Takes four decoder values (seg0-seg3) and to activate each corresponding
//                 digit on the seven-segment display
//                 The refresh rate should be near 1000 Hz to achieve the desired 
//                 visual effect. The refresh rate is determined by the clock period
//                 and the parameter N (i.e., clk_period/(2^N-2))
//-----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////


module disp_mux_seven_seg(
        input logic clk,
        input logic reset,
        input logic [6:0] seg0,     //data for seg LED 0
        input logic [6:0] seg1,     // data for seg LED 1
        input logic [6:0] seg2,     // data for seg LED 2
        input logic [6:0] seg3,     // data for seg LED 3
        input logic [6:0] seg4,     //data for seg LED 4
        input logic [6:0] seg5,     // data for seg LED 5
        input logic [6:0] seg6,     // data for seg LED 6
        input logic [6:0] seg7,     // data for seg LED 7
        input logic [8:0] seg_dis, //8-bit value to disable each seg LED(active-low) 
        output logic [6:0] seg_n,  //connect to board seg pin
        output logic [7:0] an      //connect to board en pin
    );
    
    localparam N = 19; // Refresh rate of ~800Hz for a 100MHz clock
    
    // Update counter on clock tick (for time multiplexing)
    logic [N-1:0] q_reg;
    
    always_ff @(posedge clk)
    begin
        if (reset) q_reg <=0;
        else q_reg <= q_reg + 1;
    end
 
    // Multiplex which seg LED is displayed
    always_comb
    begin
        case(q_reg[N-1:N-3])
            3'b000: begin
                seg_n = seg0;
                an = 8'b11111110 | seg_dis;
            end
            3'b001: begin
                seg_n = seg1;
                an = 8'b11111101 | seg_dis;
            end
            3'b010: begin
                seg_n = seg2;
                an = 8'b11111011 | seg_dis;
            end
            3'b011: begin
                seg_n = seg3;
                an = 8'b11110111 | seg_dis;
            end
            3'b100: begin
                seg_n = seg4;
                an = 8'b11101111 | seg_dis;
            end
            3'b101: begin
                seg_n = seg5;
                an = 8'b11011111 | seg_dis;
            end
            3'b110: begin
                seg_n = seg6;
                an = 8'b10111111 | seg_dis;
            end
            3'b111: begin
                seg_n = seg7;
                an = 8'b01111111 | seg_dis;
            end
        endcase
    end
    
    
endmodule: disp_mux_seven_seg