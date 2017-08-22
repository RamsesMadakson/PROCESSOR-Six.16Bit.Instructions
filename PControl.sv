/***********************************************************/
/*                                                         */
/*  NAME: Ramses Peter Madakson                            */
/*                                                         */
/*  SUBJECT: PControl                                      */
/*                                                         */
/***********************************************************/

	
module PControl(PC_up,PC_clr,IR,IR_Id,D_addr,D_wr,RF_s,RF_W_addr,RF_W_en,
				RF_Ra_addr,RF_Rb_addr,Alu_s0,Clock,Reset,State,NextState, PC_Out);

output [15:0] IR;       // Instruction Register
input Clock, Reset;		// Clock and Reset
output logic PC_clr,PC_up,D_wr,RF_s,RF_W_en, IR_Id; // 1 Bit Logic
output logic [3:0] RF_W_addr,RF_Ra_addr,RF_Rb_addr; // Addresses
output logic [2:0] Alu_s0; // ALU Select
output logic [7:0] D_addr; // Data Address
output [6:0] PC_Out; // Program Counter Output
logic [15:0] Data; // Data for DROM Access

output logic [3:0] State = 4'h0, NextState = 4'h0;

	/** ROM Instruction Data Access **/
	DROM ROM (PC_Out, Clock, Data);
	
	/** Instruction Register Call for Data Input  **/
	InstructionRegister I (Data, Clock, IR, IR_Id);
	
	/** Program Counter**/
	ProgramCounter PC (PC_up, PC_clr, Clock, PC_Out);

/** Parameters **/

localparam 
	
	Initial = 4'h0,
	Fetch = 4'h1,
	Decode = 4'h2,
	Halt = 4'h3,
	NOOP = 4'h4,
	LoadA = 4'h5,
	LoadB = 4'h6,
	Copy = 4'h7, /******** Created a new Copy State in Param ********/
	Add = 4'h8,
	Subtract = 4'h9,
	Store = 4'hA,
	Increment = 4'hB;   
	
	always_comb begin
		
		/** Initializations **/
		
		Alu_s0 = 3'h7;
		RF_W_addr = 0;
		D_addr = 0;
		D_wr = 0;
		RF_s = 0;
		RF_W_en = 0;
		IR_Id = 0;
		PC_clr = 0;
		PC_up = 0;
		RF_Ra_addr = 0;
		RF_Rb_addr = 0;

		/*************** Cases for States ***************/
		
		case(State)
			
			Initial	:	begin	
							PC_clr = 1'b1;
							
							NextState = Fetch;
							
							end
						
			Fetch	:	begin
							
							IR_Id = 1'b1;
							NextState = Decode;
							
						end
						
			Decode:	begin
			
							/** Added a new IF statement for IR[15:12] = 7 for Copy **/
							
							if (IR[15:12] == 4'b0111) 
								
								begin
									
									NextState = Copy; /** Go to Copy State Below **/
									PC_up = 1'b1;     /** Increment Program Counter**/
								
								end
							
							else if (IR[15:12] == 4'b0000)
								
								begin
								
									NextState = NOOP;
									PC_up = 1'b1;
								
								end
								
							else if (IR[15:12] == 4'b1000)
								
								begin
								
									NextState = Increment;
									PC_up = 1'b1;
								
								end
							
							else if (IR[15:12] == 4'b0010) 
								
								begin
								
									NextState = LoadA;
									PC_up = 1'b1;
									
								end
								
							else if (IR[15:12] == 4'b0001) 
								
								begin
									
									NextState = Store;
									PC_up = 1'b1;
									
								end
								
							else if (IR[15:12] == 4'b0011) 
								
								begin
								
									NextState = Add;
									PC_up = 1'b1;
									
								end
								
							else if (IR[15:12] == 4'b0100) 
							
								begin
								
									NextState = Subtract;
									PC_up = 1'b1;
									
								end
								
							else if (IR[15:12] == 4'b0101) 
								
								begin
									
									NextState = Halt;
									PC_up = 1'b1;
								
								end
							
							else 
								
								begin
									
									NextState = Fetch;
								
								end
							
							end
							
			Halt:	begin
						
						NextState = Halt;
					
					end
					
			NOOP	:	begin
			
							NextState = Fetch;
							
						end
						
			LoadA	:	begin
							
							D_addr = IR[11:4];
							RF_s = 1'b1;
							RF_W_addr = IR[3:0];
							NextState = LoadB;
							
						end
						
			LoadB	:	begin
							
							D_addr = IR[11:4];
							RF_s = 1'b1;
							RF_W_addr = IR[3:0];
							RF_W_en = 1'b1;
							NextState = Fetch;
							
						end
						
						
			
			/******************************************** COPY STATE ********************************************/
			
			
			Copy     :  begin
								
							Alu_s0 = 3'h3; /** ALU COPY Operation ALUOUT = A **/
		
							RF_Ra_addr = IR[11:8]; /** A Address **/
							RF_Rb_addr = IR[7:4];  /** B Address **/
							RF_W_addr = IR[3:0];   /** W Address **/
							RF_W_en = 1;			 /** Register File Enable **/
							NextState = Fetch;	/** Next State is Fetch State **/
							RF_s = 0;             /** 2 to 1 Mux Select is 0 for ALU OUT **/ 
							
							
							end
						
			
						
			Add		:	begin
			
							Alu_s0 = 3'h0;   
							RF_Ra_addr = IR[11:8];
							RF_Rb_addr = IR[7:4];
							RF_W_addr = IR[3:0];
							RF_W_en = 1;	
							NextState = Fetch;
							RF_s = 0;
							
							end
							
								
			Increment :	begin
			
							Alu_s0 = 3'h2;   
							RF_Ra_addr = IR[11:8];
							RF_Rb_addr = IR[7:4];
							RF_W_addr = IR[3:0];
							RF_W_en = 1;	
							NextState = Fetch;
							RF_s = 0;
							
							end
							
			Subtract	:	begin
			
							Alu_s0 = 3'h1;
							RF_Ra_addr = IR[11:8];
							RF_Rb_addr = IR[7:4];
							RF_W_addr = IR[3:0];
							RF_W_en = 1;	
							NextState = Fetch;
							RF_s = 0;
							
							end
							
			Store	: 	begin
							
							D_addr = IR[7:0]; 
							D_wr = 1'b1;
							RF_Ra_addr = IR[11:8];
							NextState = Fetch;
							
						end
							
		
							
			default : 	begin 
							
							Alu_s0 = 3'h7;
							PC_clr = 0;
							PC_up = 0;
							RF_Ra_addr = 0;
							RF_Rb_addr = 0;
							RF_W_addr = 0;
							D_addr = 0;
							D_wr = 0;
							RF_s = 0;
							RF_W_en = 0;
							IR_Id = 0; 
							NextState = Initial;
							
							end
							
		endcase
		
	end
	
	always_ff @ (posedge Clock) 
		
		begin
		
			if (Reset) 
			
				begin
			
					State <= Initial;
				
				end
		
		else
		
			begin
			
				State <= NextState;
				
			end
			
	end



endmodule
