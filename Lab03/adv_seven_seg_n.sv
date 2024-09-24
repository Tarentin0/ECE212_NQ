//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette College
// Create Date: 01/09/2024 10:11:26 AM
// Design Name: 
// Module Name: adv_seven_seg_n
// Project Name:  ECE 211 Digital Circuits 1
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Feb 2020
// Revised       : Lauren Biernacki <biernacl@lafayette.edu> Jan 2024
//-----------------------------------------------------------------------------
// Description   : Advanced seven-segment decoder displaying 
//                 hexidecimal values 0-F with active low outputs
//                 Segments are ordered as follows: segs_n[6]=g, segs_n[0]=a
//-----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////


module adv_seven_seg_n(
		 input logic [3:0]  data,
		 output logic [6:0] segs_n  // ordered g(6) - a(0)
		 );

   always_comb
     case (data)  // Seg: gfedcba
       4'd0:  segs_n = 7'b1000000;
       4'd1:  segs_n = 7'b1111001;
       4'd2:  segs_n = 7'b0100100;
       4'd3:  segs_n = 7'b0110000;
       4'd4:  segs_n = 7'b0011001;
       4'd5:  segs_n = 7'b0010010;
       4'd6:  segs_n = 7'b0000010;
       4'd7:  segs_n = 7'b1111000;
       4'd8:  segs_n = 7'b0000000;
       4'd9:  segs_n = 7'b0010000;
       4'd10: segs_n = 7'b0001000;
       4'd11: segs_n = 7'b0000011;
       4'd12: segs_n = 7'b1000110;
       4'd13: segs_n = 7'b0100001;
       4'd14: segs_n = 7'b0000110;
       4'd15: segs_n = 7'b0001110;
       default: segs_n = 7'b1111111;
     endcase
     
endmodule: adv_seven_seg_n
