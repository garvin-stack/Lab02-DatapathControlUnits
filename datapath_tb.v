//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Garvin Ha 
// Email: gha003@ucr.edu
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

`timescale 1ns / 1ps

module datapath_tb;
    // Inputs
    reg clk; 
    reg [5:0] instr_op;    
    reg [5:0] instr_field;

    wire [8:0] result;
    wire [3:0] alu_result;

    reg [8:0] R;
    reg [3:0] R_alu;

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab04.vcd");
        $dumpvars(0);
    end
    
    // ---------------------------------------------------
    // Instantiate the Units Under Test (UUT)
    // --------------------------------------------------- 
    controlUnit uut1 (
        .instr_op(instr_op),
        .reg_dst(result[8]),
        .alu_src(result[7]),
        .mem_to_reg(result[6]),
        .reg_write(result[5]),
        .mem_read(result[4]),
        .mem_write(result[3]),
        .branch(result[2]),
        .alu_op(result[1:0])
    );

    aluControlUnit uut2 (
        .alu_op(result[1:0]),
        .instruction_5_0(instr_field),
        .alu_out(alu_result)
    );

    initial begin 
        clk = 0;
        forever begin 
            clk = ~clk; #10; 
        end 
    end
     
    integer failedTests = 0;
    integer totalTests = 0;
    initial begin
        // Reset
        @(posedge clk); // Wait for first clock out of reset 
        #10; // Wait 

        // -------------------------------------------------------
        // Test group 1: Control Unit
        // -------------------------------------------------------
        $display("Test Group 1: Testing Control unit... ");

        $write("\tTest Case 1.1: R-format ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        R = { 9'b100100010 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 1.2: lw ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b100011;
        R = { 9'b011110000 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 1.3: sw ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b101011;
        R = { 9'b010001000 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end        

        $write("\tTest Case 1.4: beq ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000100;
        R = { 9'b000000101 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 1.4: imm ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        R = { 9'b100100010 }; 
        #100; // Wait
        if (R != result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end
        // -------------------------------------------------------
        // More ALU Control Unit tests jere
        // -------------------------------------------------------

        // --------------------------------------------------------------
        // End testing
        // --------------------------------------------------------------
        $write("\n--------------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests",totalTests-failedTests,totalTests);
        $write("\n--------------------------------------------------------------\n");
        $finish();
    end
endmodule

