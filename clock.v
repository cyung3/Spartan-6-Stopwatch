module clock(input clk, output clk_2hz, output clk_1hz, output clk_fst, output clk_4hz);
   

  //internal clock is 100MHz so we need 27 bits to hold 10^8
  //clocks are designed in a way such that they are easier to output
  reg [27:0] counter1;
  reg [26:0] counter2; // TODO: divide 2hz clock by 2
  reg [26:0] counter4;
  reg [26:0] counterfst;
  
initial begin
	counter1 = 0;
	counter2 = 0;
	counter4 = 0;
	counterfst = 0;
end
  
	
assign clk_1hz = (counter1 == 000000000)? 1'b1 : 1'b0;
assign clk_2hz = (counter2 == 00000000)? 1'b1 : 1'b0;
assign clk_fst = (counterfst >= 125000)? 1'b0 : 1'b1;
//assign clk_fst = counter1[8]; // ~380 Hz
assign clk_4hz = (counter4 >= 12500000)? 1'b0 : 1'b1;


  always @(posedge clk)
    begin
      counter1 <= (counter1 + 1) % 100000000; //TODO: change back to 100000000
	  counter2 <= (counter2 + 1) % 50000000;
	  counter4 <= (counter4 + 1) % 50000000;
	  counterfst <= (counterfst + 1) % 250000;
    end
   
	
endmodule // clock
