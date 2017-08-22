/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: Register File                                 */
/*                                                         */
/***********************************************************/

module RegisterFile
  (input clock, 
   input [3:0] wrAddr,
   input write,    
   input [3:0] rdAddrA,        
   input [3:0] rdAddrB,  
	output [15:0] rdDataA,   
   output [15:0] rdDataB,
   input [15:0] wrData); 

   logic [15:0] regfile [15:0];  
	
	/** Assignments **/
   assign rdDataA = regfile[rdAddrA]; 
   assign rdDataB = regfile[rdAddrB];

   always @(posedge clock) begin
      
		/**If Write enable, assign Wr Data **/
		if (write) regfile[wrAddr] <= wrData;
   
	end
	
	
endmodule 


/***********************************************************/
/*                                                         */
/*                       TEST BENCH	                       */
/*                                                         */
/***********************************************************/

`timescale 1ps/1ps

module RegisterFile_TestBench;

	logic clock; 
   logic [3:0] wrAddr;
   logic write;    
   logic [3:0] rdAddrA;        
   logic [3:0] rdAddrB;  
	logic [15:0] rdDataA;  
   logic [15:0] rdDataB;
   logic [15:0] wrData;
	
	RegisterFile DUT (clock, wrAddr, write, rdAddrA, rdAddrB, rdDataA, rdDataB, wrData);
	
	always begin
		
		clock = 0;
		#10;
		clock = 1'b1;
		#10;
		
	end
	
	initial begin
		
		write = 0;
		wrAddr = 4'h3;
		rdAddrA = 16'h2;
		rdAddrB = 16'h3;
		wrData = 16'h10;
		#50;
		write = 1;
		#50;
		wrAddr = 4'h1;
		#50;
		$stop;
	
	end
	
endmodule 
		
		
		
		
		