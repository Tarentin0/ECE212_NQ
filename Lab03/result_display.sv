`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2024 04:58:17 PM
// Design Name: 
// Module Name: result_display
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


module result_display(
    input logic [3:0] quotient,
    input logic [3:0] remainder, 
    input logic clk,
    output logic [6:0] seg_n,  //connect to board seg pin
    output logic [7:0] an      //connect to board en pin
    );
    
    
   
    logic [3:0] r_hund, r_ten, r_one;
    dbl_dabble_ext U_DBLX (.b(remainder), .thousands(), .hundreds(r_hund),
        .tens(r_ten), .ones(r_one)
        );
    
    logic [3:0] q_hund, q_ten, q_one;
    dbl_dabble_ext U_DBLX2 (.b(quotient), .thousands(), .hundreds(q_hund),
        .tens(q_ten), .ones(q_one)
        );
    
    
    
    
    logic [6:0] seg_rten, seg_rone, seg_qten, seg_qone;
    adv_seven_seg_n D0(.data(r_ten), .segs_n(seg_rten));
    adv_seven_seg_n D1(.data(r_one), .segs_n(seg_rone));
    adv_seven_seg_n D2(.data(q_ten), .segs_n(seg_qten));
    adv_seven_seg_n D3(.data(q_one), .segs_n(seg_qone));

        

    localparam R = 7'b0101111;

    

    disp_mux_seven_seg D4(.clk(clk), .reset(1'b0), 
       .seg7(7'b0000000),
	   .seg6(7'b0000000), 		    /* a            */ 
	   .seg5(seg_qten), 	/* add/subtract */ 
	   .seg4(seg_qone), 			/* b            */ 
       .seg3(R), 		/* equals       */ 
	   .seg2(seg_rten),   /* sign  or 'E' */ 
	   .seg1(seg_rone), 	/* y     or 'r' */ 
	   .seg0(7'b0000000),	/* -     or 'r' */ 
       .seg_dis(8'b11000001), .seg_n(seg_n), .an(an)
    );
    
    
    
endmodule
