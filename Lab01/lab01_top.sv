`timescale 1ns / 1ps
//-----------------------------------------------------------------------------
// Module Name   : lab03_top - top-level module for temp. display
// Project       : ECE 212 - Digital Circuits II
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Jan 2022
// Modified      : Sept 2024 <biernacl@lafayette.edu>
//-----------------------------------------------------------------------------
// Description   : displays temperature in either Celsuis or Fahrenheit
// using the Nexys A7 temperature sensor
//-----------------------------------------------------------------------------



module lab01_top(
    input logic clk, rst, 
    input logic [ 15:0] SW,
    output logic [15:0] LED,
    output logic [7:0] AN,
    output logic [6:0] SEG,
    output logic DP,
    inout  TMP_SCL,
    inout  TMP_SDA
    );
    
    
    // Declare and connect input signals 
    logic [12:0] temp_manual, temp_sensor, temp_final;
    logic select_temp, select_cf;
    assign temp_manual = SW[12:0];
    assign select_temp = SW[15];
    assign select_cf   = SW[14]; 
    assign LED[15:0]   = SW[15:0]; 
    
    
    // Instantiate the VHDL temperature sensor controller
    logic tmp_rdy, temp_err;
    TempSensorCtl U_TSCTL (.TMP_SCL(TMP_SCL), .TMP_SDA(TMP_SDA), .TEMP_O(temp_sensor),
                            .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk), .SRST_I(rst)
    );
    
    
    // Instantiate the module configuration for lab 1 (Figure 2) here 
    logic [12:0] w0;
    logic [16:0] w1, w2, w3;
    celsius_to_fahren_x10 D0 (w0, w1);
    mpy_10 D1 (w0, w2);
    always_comb begin
        if (SW[15])
            w0 = temp_manual;
        else
            w0 = temp_sensor;
            
        if (SW[14])
            w3 = w1;
        else
            w3 = w2;
    end
    round D3 (w3, temp_final);
            
    
    
    
    // Connect result to temperture seven-segment display
    temperature_display U_TDISP(.temp(temp_final), .select_cf(select_cf), .clk(clk),
                                .seg_n(SEG), .an(AN));  


endmodule
