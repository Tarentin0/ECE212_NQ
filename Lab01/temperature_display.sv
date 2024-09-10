`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette College
// Create Date: 02/26/2024 
// Design Name: 
// Module Name: calculator_display
// Project Name:  ECE 211 Digital Circuits 1
//-----------------------------------------------------------------------------
// Author        : Lauren Biernacki <biernacl@lafayette.edu>
// Created       : Feb 2024
//-----------------------------------------------------------------------------
// Description   : Takes inputs a, b, and y to display on the seven-segement 
//                 display in the format ``a - b = y''. 
//                 The input operation determines wether a minus sign or the 
//                 letter 'p' is displayed. Additional inputs can be used to 
//                 display the sign of the result (i.e., ``- y'') or display
//                 ``Err'' in the case of an overflow.
//-----------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////


module temperature_display(
    input logic [12:0] temp,
    input logic select_cf, 
    input logic clk,
    output logic [6:0] seg_n,  //connect to board seg pin
    output logic [7:0] an      //connect to board en pin
    );
    
    // "tens" are really ones, "ones" are really tenths
    logic [3:0] hund1, tens1, ones1, tenths1;
    dbl_dabble_ext U_DBLX (.b(temp), .thousands(hud1), .hundreds(tens1),
        .tens(ones1), .ones(tenths1)
        );
    
    
    logic [6:0] seg_hud, seg_ten, seg_one, seg_tenths;
    adv_seven_seg_n D0(.data(hud1), .segs_n(seg_hud));
    adv_seven_seg_n D1(.data(tens1), .segs_n(seg_ten));
    adv_seven_seg_n D2(.data(ones1), .segs_n(seg_one));
    adv_seven_seg_n D3(.data(tenths1), .segs_n(seg_tenths));

        

    localparam BLANK = 7'b1000000;
    localparam DP    = 7'b0100000;
    localparam DASH  = 7'b0010000;
    localparam FAHR  = 7'b0001110;
    localparam CENT  = 7'b1000110;
    
    logic [6:0] disp_type = select_cf ? FAHR : CENT; 

    disp_mux_seven_seg D4(.clk(clk), .reset(1'b0), 
       .seg7(7'b0000000),
	   .seg6(seg_hud), 		    /* a            */ 
	   .seg5(seg_ten), 	/* add/subtract */ 
	   .seg4(seg_one), 			/* b            */ 
       .seg3(seg_tenths), 		/* equals       */ 
	   .seg2(disp_type),   /* sign  or 'E' */ 
	   .seg1(7'b0000000), 	/* y     or 'r' */ 
	   .seg0(7'b0000000),	/* -     or 'r' */ 
       .seg_dis(8'b10000011), .seg_n(seg_n), .an(an)
    );
    
    
endmodule
