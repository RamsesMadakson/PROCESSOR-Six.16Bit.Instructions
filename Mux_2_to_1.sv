
/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: Mux 2 to 1                                    */
/*                                                         */
/***********************************************************/

module Mux_2_to_1(S, X, Y, M);
	
	/** Inputs and Outputs**/
	input S;            
	input  [15:0] X, Y;  
	output logic [15:0] M; 
	integer i;

	
	/** Selection **/
	assign M = S ? X : Y;
		
		
  
endmodule


/***********************************************************/
/*                                                         */
/*                       TEST BENCH	                       */
/*                                                         */
/***********************************************************/

`timescale 1ps/1ps

module Mux_2_to_1_TestBench;
	
	logic S;            
	logic  [15:0] X, Y;  
	logic [15:0] M; 
	logic Clock;
	
	Mux_2_to_1 DUT (S, X, Y, M);
	
	always begin
		
		Clock = 0;
		#10;
		Clock = 1'b1;
		#10;
		
	end

	
	initial begin
		
		X = 16'h2;
		Y = 16'h3;
		S = 0;
		#50;
		
		X = 16'h2;
		Y = 16'h3;
		S = 1;
		#50;
		
		$stop;
		
	end
	
endmodule
