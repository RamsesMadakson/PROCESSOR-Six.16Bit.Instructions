/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: Instruction Register                          */
/*                                                         */
/***********************************************************/

module InstructionRegister(Data, Clock, IR, IRId);
	
	/** Inputs and Outputs**/
	
	input IRId;
	input Clock;
	input [15:0] Data;
	output logic [15:0] IR;
	
	/** Always **/
	always_ff @ (posedge Clock)
			
			begin
				
				if(IRId)
					
					begin
						
						/** Register = Data **/
						IR = Data; 
					
					end	
					
				end
		
endmodule 


/***********************************************************/
/*                                                         */
/*                       TEST BENCH	                       */
/*                                                         */
/***********************************************************/

`timescale 1ps/1ps

module InstructionRegister_TestBench;
	
	logic Clock;
	logic IRId;
	logic [15:0] Data;
	logic [15:0] IR;
	
	InstructionRegister DUT (Data, Clock, IR, IRId);
  
	
	always begin
		
		Clock = 0;
		#10;
		Clock = 1'b1;
		#10;
		
	end
	
	initial begin
		
		IRId = 0;
		Data = 16'h5;
		#50;
		
		IRId = 1;
		Data = 16'h5;
		#50;
		
		$stop;
		
	end
	
endmodule