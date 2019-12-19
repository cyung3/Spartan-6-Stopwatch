`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:57:48 10/24/2019 
// Design Name: 
// Module Name:    top_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_module(
    input pause,
    input reset,
    input select,
    input adjust,
    input clk,
	
	output [6:0] disNum,
	output [3:0] select_digit,
	output [5:0] counter_sec,
	output clk_1hz
    );

//wire clk_1hz;
wire clk_2hz;
wire clk_4hz;
wire clk_fst;


clock clock(
	.clk(clk), 
	.clk_1hz(clk_1hz), 
	.clk_2hz(clk_2hz), 
	.clk_4hz(clk_4hz),
	.clk_fst(clk_fst)
	);
   


counter counter(
	.clk(clk), 
	.clk_1hz(clk_1hz), 
	.clk_2hz(clk_2hz), 
	.clk_fst(clk_fst),
	.clk_4hz(clk_4hz),
	.pause_d(pause), 
	.rst_d(reset), 
	.select(select), 
	.adj(adjust), 
	.disNum(disNum), 
	.select_digit(select_digit),
	.counter_sec(counter_sec));



endmodule
