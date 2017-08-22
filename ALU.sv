/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: ALU                                           */
/*                                                         */
/***********************************************************/


module ALU(Selection, A, B, S);

  input [2:0] Selection;  // function selection
  input [15:0] A, B;  // input data
  output reg [15:0] S; // ALU output (result)
  
  always @ * begin
    
	 S = 0;  // 	fault value
    case (Selection)
    
		3'h0: begin
        S = A + B;  // ADD
      end
      3'h1: begin
        S = A - B;  // SUBTRACT
      end
      3'h2: begin
        S = A + 1'b1; // INCREMENT
      end
      3'h3: begin
        S = A;  // FALL-THROUGH
      end
		3'h4: begin
        S = A & B;  // AND
      end
      3'h5: begin
        S = A | B;  // OR
      end
      3'h6: begin
        S = A ^ B;  // XOR
      end
      3'h7: begin
        S = 0;   // ZERO
      end
	
    endcase
  end // always
endmodule 


/***********************************************************/
/*                                                         */
/*                       TEST BENCH	                       */
/*                                                         */
/***********************************************************/

`timescale 1ps/1ps

module ALU_TestBench;
	
	logic [3:0] Sel;  // SEL
	logic [15:0] A, B; // A and B Data
	logic [15:0] S;
	logic Clock;
	
	ALU DUT (Sel, A, B, S);
  
	
	always begin
		
		Clock = 0;
		#10;
		Clock = 1'b1;
		#10;
		
	end

	
	initial begin
		
		A = 16'h3;
		B = 16'h4;
		Sel = 4'h3;
		#50;
			
		A = 16'h3;
		B = 16'h4;
		Sel = 4'h0;
		#50;
		
		$stop;
		
	end
	
endmodule