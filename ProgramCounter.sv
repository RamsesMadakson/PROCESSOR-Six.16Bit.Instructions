
/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: ProgramCounter                                */
/*                                                         */
/***********************************************************/


module ProgramCounter(Enable, PC_Clr, Clock, Counter);
	
	input Clock, PC_Clr, Enable;
	output logic [6:0] Counter;

	
	always @ (posedge Clock)
		
		if (PC_Clr)
			
			begin
			
			Counter <= 0;
			
			end
		
		else 
			
			begin
			
			if (Enable)
				
				begin
			
				Counter <= Counter + 1'b1;
				
				end
			
			end

endmodule
	
/***********************************************************/
/*                                                         */
/*                       TEST BENCH	                       */
/*                                                         */
/***********************************************************/


`timescale 1ps/1ps
module ProgramCounter_TestBench;

	logic Clock, PC_Clr, Enable;
   logic [6:0] Counter;
	
	
	ProgramCounter DUT (Enable, PC_Clr, Clock, Counter);
	
	always begin
		
		Clock = 0;
		#10;
		Clock = 1'b1;
		#10;
		
	end 
	
	initial begin
	
		PC_Clr = 1;
		#50;
		PC_Clr = 0;
		#50;
		Enable = 1;
		#50;
		Enable = 0;
		#50;
		Enable = 1;
		#50;
		PC_Clr = 1;
		#50;
		$stop;
	
	end
	
	
endmodule 