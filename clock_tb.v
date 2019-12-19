`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:42:43 10/29/2019
// Design Name:   clock
// Module Name:   E:/152A/lab3/clock_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clock_tb;

	// Inputs
	reg clk;

	// Outputs
	wire clk_2hz;
	wire clk_1hz;
	wire clk_fst;
	wire clk_4hz;

	// Instantiate the Unit Under Test (UUT)
	clock uut (
		.clk(clk), 
		.clk_2hz(clk_2hz), 
		.clk_1hz(clk_1hz), 
		.clk_fst(clk_fst), 
		.clk_4hz(clk_4hz)
	);

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always
		#5  clk = !clk; 
      
endmodule

