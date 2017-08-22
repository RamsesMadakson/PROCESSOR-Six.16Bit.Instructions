
/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: Mux 8 to 1                                    */
/*                                                         */
/***********************************************************/

module Mux_8_to_1 (In_A, In_B, In_C, In_D, In_E, In_F, In_G, In_H, Selection, Output);
	
	/** Inputs and Outputs **/
	input [15:0] In_A, In_B, In_C, In_D, In_E, In_F, In_G, In_H;
	output logic [15:0] Output;
	input [2:0] Selection;
	
	always_comb 
		
		begin
			
			case (Selection)
				
				3'h0: Output = In_A;
				3'h1: Output = In_B;
				3'h2: Output = In_C;
				3'h3: Output = In_D;
				3'h4: Output = In_E;
				3'h5: Output = In_F;
				3'h6: Output = In_G;
				3'h7: Output = In_H;
			
			endcase 
		
		end
		
endmodule 


/***********************************************************/
/*                                                         */
/*                       TEST BENCH	                       */
/*                                                         */
/***********************************************************/

`timescale 1ps/1ps

module Mux_8_to_1_TestBench;
	
	logic [15:0] In_A, In_B, In_C, In_D, In_E, In_F, In_G, In_H;
	logic [15:0] Output;
	logic [2:0] Selection;
	logic Clock;
	
	Mux_8_to_1 DUT (In_A, In_B, In_C, In_D, In_E, In_F, In_G, In_H, Selection, Output);
	
	always begin
		
		Clock = 0;
		#10;
		Clock = 1'b1;
		#10;
		
	end


	initial begin
		
		In_A = 16'h1;
		In_B = 16'h2;
		In_C = 16'h3;
		In_D = 16'h4;
		In_E = 16'h5;
		In_F = 16'h6;
		In_G = 16'h7;
		In_H = 16'h8;
		Selection = 3'h2;
		#50;
		
		$stop;
		
	end
	
endmodule

