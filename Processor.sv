/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: Processor                                     */
/*                                                         */
/***********************************************************/

module Processor( Clock, Reset, IR, PC_Out, State, NextState, ALU_A, ALU_B, ALU_Out );

	input Clock;            // Clock
	input Reset;            // Reset
	output [15:0] IR;   // Instruction Register
	output [6:0] PC_Out;    // Program Counter
	output [3:0] State;     // Current state
	output [3:0] NextState; // Next state 
	output [15:0] ALU_A;    // ALU A Input
	output [15:0] ALU_B;    // ALU B Input
	output [15:0] ALU_Out;  // ALU Output
	logic PC_clr, PC_up, IR_Id;
	logic [7:0] D_addr;
	logic [3:0] RF_W_addr;
	logic [3:0] RF_Ra_addr;
	logic [3:0] RF_Rb_addr;
	logic [3:0] State = 4'h0;
	logic [3:0] NextState = 4'h0;
	logic [15:0] Data;
	logic [2:0] Alu_s0;
	logic [15:0] MuxOutput;
	
	logic RF_s, RF_W_en, D_wr;
	
	/** PControl Function Call **/
	PControl PP (PC_up,PC_clr,IR,IR_Id,
				D_addr,D_wr,RF_s,RF_W_addr,RF_W_en,
				RF_Ra_addr,RF_Rb_addr,Alu_s0,Clock,Reset, State,NextState, PC_Out);

				
	/** PDataPath Function Call **/
	PDataPath PD (ALU_A, ALU_B, D_addr, Clock, Alu_s0, D_wr, RF_s, RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, ALU_Out);
	

endmodule 

