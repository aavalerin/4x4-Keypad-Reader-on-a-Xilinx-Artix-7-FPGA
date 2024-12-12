`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aaron Valerin
// 
// Create Date: 14.10.2024 18:34:50
// Design Name: 
// Module Name: Debouncing
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



module Debouncing(
    input noisy_signal,
    input clk,
    input rst,
    input clk_lento,
    output clean_signal
    );

    wire Q1, Q1_bar, Q2, Q2_bar;
    D_FF f1(clk, rst, clk_lento, noisy_signal, Q1, Q1_bar);
    D_FF f2(clk, rst, clk_lento, Q1, Q2, Q2_bar);

    assign clean_signal =  Q1 & Q2_bar ; 
endmodule
