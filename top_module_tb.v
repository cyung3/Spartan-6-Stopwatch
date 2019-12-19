`timescale 1us / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:48:17 10/29/2019
// Design Name:   top_module
// Module Name:   E:/152A/lab3/top_module_tb.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module top_module_tb;

	// Inputs
	reg pause;
	reg reset;
	reg select;
	reg adjust;
	reg clk;

	// Outputs
	wire [6:0] disNum;
	wire [3:0] select_digit;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.pause(pause), 
		.reset(reset), 
		.select(select), 
		.adjust(adjust), 
		.clk(clk), 
		.disNum(disNum), 
		.select_digit(select_digit)
	);

	initial begin
		// Initialize Inputs
		pause = 0;
		reset = 0;
		select = 0;
		adjust = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always
		#5  clk = !clk; 
      
endmodule

