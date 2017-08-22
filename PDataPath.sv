/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: DataPath                                      */
/*                                                         */
/***********************************************************/

module PDataPath (ALU_A, ALU_B, D_addr, Clock, ALU_s0, D_wr, RF_s, RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, ALU_Out);
	
	/** Inputs and Outputs **/
	input [7:0] D_addr;
	input Clock, D_wr;
	input RF_s;
	output [15:0] ALU_A, ALU_B;
	output [15:0] ALU_Out;
	input [2:0] ALU_s0;
	input [3:0] RF_Ra_addr, RF_Rb_addr;
	logic [15:0] Data;
	logic [15:0] MuxOutput;
	logic [15:0] wrData, DRam_Out;
	input RF_W_en;
	input [3:0] RF_W_addr;
	
	/** Data Memory Function call **/
	DRAM RAM (D_addr, Clock, ALU_A, D_wr, Data);
	
	/** ALU Function call **/
	ALU A (ALU_s0, ALU_A, ALU_B, ALU_Out);
	
	/** Mux 2 to 1 Function call **/
	Mux_2_to_1 Mux (RF_s, Data, ALU_Out, MuxOutput);
	
	/** Register File Function call **/
	RegisterFile R (Clock, RF_W_addr, RF_W_en, RF_Ra_addr, RF_Rb_addr, ALU_A, ALU_B, MuxOutput);
	
endmodule 