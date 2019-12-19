
//TODO: 
//debug counter(s)
//debug select_digit

module count_digit(
	input clk,
	input incr,
	input [3:0] max_val,
	input select,
	input reset,
	input pause,
	input adjust,
	output reg [3:0] value,
	output reg incr_next);

	initial begin 
		value = 0;
		incr_next = 0;
	end
	
	always@(posedge clk)
	begin
		if (reset)
			value <= 0;
		else if (incr) begin
			if (value == max_val)
				incr_next <= 1;
			else
				incr_next <= 0;
			value <= (value + 1) % (max_val + 1);
		end
		else
			incr_next <= 0;
	end		

endmodule





module counter(
	clk, clk_1hz, clk_2hz, clk_fst, clk_4hz,
	pause_d, rst_d, select, adj, disNum, select_digit, 
	counter_sec);
  
   input clk;
   input clk_1hz;
   input clk_2hz;
   input clk_fst;
   input clk_4hz;
   input pause_d;
   input rst_d;
   input select;
   input adj;
   

   output reg [3:0] select_digit;
   output reg [6:0] disNum;
   
   wire [3:0] 	counterm10;
   wire [3:0] 	counterm1;
   wire [3:0] 	counters10;
   wire [3:0] 	counters1;
   
   wire s1_incr;
   wire s10_incr;
   wire m1_incr;
   wire m1_interm;
   wire m10_incr;
   wire m10_of;
   
   
   output reg [5:0]   counter_sec;
   reg [5:0]   counter_min;

   reg          freeze;
   reg [1:0]	digit;
   
   function [6:0] numToLED;
      input [3:0] num;
      begin
	 case(num)
	   4'd0: numToLED = 7'h3F; //7'b1111110;
	   4'd1: numToLED = 7'h06; //7'b0110000;
	   4'd2: numToLED = 7'h5B; //7'b1101101;
	   4'd3: numToLED = 7'h4F; //7'b1111001;
	   4'd4: numToLED = 7'h66; //7'b0110011;
	   4'd5: numToLED = 7'h6D; //7'b1011011;
	   4'd6: numToLED = 7'h7D; //7'b1011111;
	   4'd7: numToLED = 7'h07; //7'b1110000;
	   4'd8: numToLED = 7'h7F; //7'b1111111;
	   4'd9: numToLED = 7'h6F; //7'b1111011;
	 endcase // case (num)
      end
   endfunction // numToLED
  
  initial begin
	freeze = 0;
	digit = 2'b00;
	counter_sec = 0;
	counter_min = 0;

	select_digit = 4'b1110;
  end

	assign s1_incr = (adj & select)? clk_2hz : clk_1hz & ~freeze;

	count_digit s1(
		.clk(clk),
		.incr(s1_incr),
		.max_val(4'b1001),
		.select(select),
		.reset(rst_d),
		.pause(pause_d),
		.adjust(adj),
		.value(counters1),
		.incr_next(s10_incr)
	);
	
	count_digit s10(
		.clk(clk),
		.incr(s10_incr),
		.max_val(4'b0101),
		.select(select),
		.reset(rst_d),
		.pause(pause_d),
		.adjust(adj),
		.value(counters10),
		.incr_next(m1_incr)
	);
	
	assign m1_interm = (adj & ~select)? clk_2hz : m1_incr;
	
	count_digit m1(
		.clk(clk),
		.incr(m1_interm),
		.max_val(4'b1001),
		.select(select),
		.reset(rst_d),
		.pause(pause_d),
		.adjust(adj),
		.value(counterm1),
		.incr_next(m10_incr)
	);
	
	count_digit m10(
		.clk(clk),
		.incr(m10_incr),
		.max_val(4'b0101),
		.select(select),
		.reset(rst_d),
		.pause(pause_d),
		.adjust(adj),
		.value(counterm10),
		.incr_next(m10_of)
	);
	
	always@(posedge clk)
	begin
		if (adj || 
			pause_d || 
			(counterm10 == 5 && counterm1 == 9 && counters10 == 5 && counters1 == 9))
			freeze <= 1;
		else if (rst_d)
			freeze <= 0;
		else if (~pause_d)
			freeze <= 0;
	end

	always@(posedge clk_fst) // update the display number
	begin
		case(select_digit)
		4'b0111:
		begin
			if (adj && select && clk_4hz)
				disNum <= 7'b1111111;
			else
				disNum <= ~numToLED(counters1); //~numToLED(counters1);
			select_digit <= 4'b1110;
		end
		4'b1110:
		begin
			if (adj && select && clk_4hz)
				disNum <= 7'b1111111;
			else
				disNum <= ~numToLED(counters10); //~numToLED(counters10);
			select_digit <= 4'b1101;
		end
		4'b1101:
		begin
			if (adj && ~select && clk_4hz)
				disNum <= 7'b1111111;
			else
				disNum <= ~numToLED(counterm1); //~numToLED(counterm1);
			select_digit <= 4'b1011;
		end
		4'b1011:
		begin
			if (adj && ~select && clk_4hz)
				disNum <= 7'b1111111;
			else
				disNum <= ~numToLED(counterm10); //~numToLED(counterm10);
			select_digit <= 4'b0111;
		end
		endcase
		
	end
endmodule // counter


