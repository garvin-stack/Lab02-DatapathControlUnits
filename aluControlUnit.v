//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name:Garvin Ha 
// Email:gha003@ucr.edu
// 
// Assignment name: Lab2-DatapathControlUnits
// Lab section: 021
// TA: Eren, Omar
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

module aluControlUnit (
    input  wire [1:0] alu_op, 
    input  wire [5:0] instruction_5_0, 
    output reg [3:0] alu_out
    );

// ------------------------------
// Insert your solution below
// ------------------------------ 
always @(alu_op, instruction_5_0)
begin 

 if (alu_op==2'b00) begin // LW and SW 
	alu_out = 4'b0010; 
 end 

 else if (alu_op==2'b01) begin  // Branch 
		alu_out = 4'b0110; 
 end
 
 else begin 
    if(instruction_5_0==6'b000000) begin
        alu_out = 4'b0010;
    end
    else if(instruction_5_0==6'b000010) begin
        alu_out = 4'b0110;
    end
    else if(instruction_5_0==6'b000100) begin
        alu_out = 4'b0000;
    end
    else if(instruction_5_0==6'b000101) begin
        alu_out = 4'b0001;
    end
    else if(instruction_5_0==6'b001010) begin
        alu_out = 4'b0111;
    end
    else if(instruction_5_0==6'b000111) begin
        alu_out = 4'b1100;
    end

  end // End else 

end  // End block 

endmodule
