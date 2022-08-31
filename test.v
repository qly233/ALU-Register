`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:22:08 05/10/2022
// Design Name:   top
// Module Name:   D:/zuchengyuanli/ALU_jicunqi/test.v
// Project Name:  ALU_jicunqi
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg [4:0] R_Addr_A;
	reg [4:0] R_Addr_B;
	reg [4:0] W_Addr;
	reg W;
	reg [2:0] ALU_OP;
	reg clk;
	reg reset;

	// Outputs
	wire ZF;
	wire OF;
	wire [31:0] F;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.R_Addr_A(R_Addr_A), 
		.R_Addr_B(R_Addr_B), 
		.W_Addr(W_Addr), 
		.W(W), 
		.ALU_OP(ALU_OP), 
		.ZF(ZF), 
		.OF(OF), 
		.F(F), 
		.clk(clk), 
		.reset(reset)
	);
	
	always #3 clk = ~clk;
	initial begin
		// Initialize Inputs
		R_Addr_A = 0;
		R_Addr_B = 0;
		W_Addr = 0;
		W = 0;
		ALU_OP = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
		
      R_Addr_A = 5'b0;
		R_Addr_B = 5'b0;
		W_Addr = 5'b0;
		W = 1;
		ALU_OP = 3'b001;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		R_Addr_A = 5'b0;
		R_Addr_B = 5'b0;
		W_Addr = 5'b00001;
		W = 1;
		ALU_OP = 3'b001;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		R_Addr_A = 5'b00000;
		R_Addr_B = 5'b00001;
		W_Addr = 5'b00010;
		W = 1;
		ALU_OP = 3'b001;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		R_Addr_A = 5'b00000;
		R_Addr_B = 5'b00001;
		W_Addr = 5'b00010;
		W = 1;
		ALU_OP = 3'b010;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		R_Addr_A = 5'b00000;
		R_Addr_B = 5'b00001;
		W_Addr = 5'b00010;
		W = 1;
		ALU_OP = 3'b011;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		R_Addr_A = 5'b00000;
		R_Addr_B = 5'b00001;
		W_Addr = 5'b00010;
		W = 1;
		ALU_OP = 3'b100;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		R_Addr_A = 5'b00000;
		R_Addr_B = 5'b00001;
		W_Addr = 5'b00010;
		W = 1;
		ALU_OP = 3'b101;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		R_Addr_A = 5'b00000;
		R_Addr_B = 5'b00001;
		W_Addr = 5'b00010;
		W = 1;
		ALU_OP = 3'b110;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		R_Addr_A = 5'b00000;
		R_Addr_B = 5'b00001;
		W_Addr = 5'b00010;
		W = 1;
		ALU_OP = 3'b111;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100; 
		// Add stimulus here

	end
      
endmodule

