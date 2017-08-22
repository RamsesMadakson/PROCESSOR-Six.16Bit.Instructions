/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: Top Module                                    */
/*                                                         */
/***********************************************************/



module LabB (CLOCK_50, LEDR, LEDG, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7, KEY, SW);
	
	/** Inputs and Outputs **/
	input CLOCK_50;
	input [2:1] KEY;
	input [17:15] SW; 
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;    
	output [17:15] LEDR;       
	output [2:1] LEDG;
	
	/** Logic **/
	logic [3:0] State, NextState;
	logic [6:0] PC;
	logic Clock;
	logic Reset; 
	logic [15:0] ALU_A, ALU_B, ALU_OUT, IR_Out; 
	logic Strobe, Bo, Out; 
	logic [15:0] In_A, In_B, In_C, In_D;  
	logic [3:0] PC0, PC1, PC2, PC3;
	logic [15:0] Mux0, Mux1, Mux2, Mux3;
	logic [15:0] MuxOutput;
	
	/** Assignment **/

	assign Reset = !KEY[1];
	assign LEDG[1] = !KEY[1];
	assign Clock = !KEY[2];
	assign LEDG[2] = !KEY[2];
	assign Mux0[15] = 1'b0;
	assign Mux0[14:8] = PC;
	assign Mux0[7:4] = State;
	assign Mux0[3:0] = NextState;
	assign Mux1 = ALU_A;
	assign Mux2 = ALU_B;
	assign Mux3 = ALU_OUT;
	assign PC0 = IR_Out[3:0];
	assign PC1 = IR_Out[7:4];
	assign PC2 = IR_Out[11:8];
	assign PC3 = IR_Out[15:12];
	assign LEDR = SW;
	
	/** ButtonSync Function Call **/
   ButtonSync BS(CLOCK_50, Clock, Bo);
	
	/** KeyFilter Function Call **/
	KeyFilter KF (CLOCK_50, Bo, Out, Strobe); 
	
	/** Processor Function Call **/
	Processor PCC (Out,Reset,IR_Out,PC,State,NextState,
				 ALU_A,ALU_B,ALU_OUT);
	
	/** Mux_8_to_1 Function Call **/
	Mux_8_to_1 Mux (Mux0, Mux1, Mux2, Mux3, 16'h0, 16'h0, 16'h0, 16'h0, SW, MuxOutput);
	
	/** HEX Display Decoder Function calls **/
	
	HEXDecoder Hex_0 (HEX0, PC0);
	HEXDecoder Hex_1 (HEX1, PC1);
	HEXDecoder Hex_2 (HEX2, PC2);
	HEXDecoder Hex_3 (HEX3, PC3);
	HEXDecoder Hex_4 (HEX4, MuxOutput[3:0]);
	HEXDecoder Hex_5 (HEX5, MuxOutput[7:4]);
	HEXDecoder Hex_6 (HEX6, MuxOutput[11:8]);
	HEXDecoder Hex_7 (HEX7, MuxOutput[15:12]);
	

endmodule 
