`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:08:55 05/10/2022 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU(of,zf,A,B,ALU_OP,F);
	input[31:0] A,B;
	output reg[31:0] F;
	input[2:0] ALU_OP;
	output reg zf,of;
	
	reg[32:0] CF;
	reg[5:0] i;
	
	always@(ALU_OP or A or B)
	begin
		case(ALU_OP)
		4'b000:begin CF = A&B;end
		4'b001:begin CF = A|B;end
		4'b010:begin CF = A^B;end
		4'b011:begin CF = ~(A|B);end
		4'b100:begin CF = A+B;end
		4'b101:begin CF = A-B;end
		4'b110:begin CF = (A<B);end
		4'b111:begin CF = B<<A;end
		endcase
	
	F[31:0] = CF[31:0];
	
	zf = 0;
	for(i = 0;i < 32;i = i + 1)
		zf = zf|F[i];
	zf=~zf;
	of = CF[32]^F[31];
	
	end
endmodule

module Register_file(R_Addr_A,R_Addr_B,W_Addr,Write_Reg,W_Data,Clk,Reset,R_Data_A,R_Data_B);
	input [4:0]R_Addr_A;
	input [4:0]R_Addr_B;
	input [4:0]W_Addr;
	input Write_Reg;
	input [31:0]W_Data;
	input Clk;
	input Reset;
	output [31:0]R_Data_A;
	output [31:0]R_Data_B;
	reg [31:0]REG_Files[0:31];
	reg [5:0]i;
	initial
	begin
	REG_Files[0]=32'h00010001;
	REG_Files[1]=32'h00100010;
	for(i=2;i<=31;i=i+1)
		REG_Files[i]=0;
	end
	assign R_Data_A=REG_Files[R_Addr_A];
	assign R_Data_B=REG_Files[R_Addr_B];
	always@(posedge Clk or posedge Reset)
	begin
	if(Reset)
	for(i=0;i<=31;i=i+1)
		REG_Files[i]=0;
	else 
	if(Write_Reg&&W_Addr!=0)
		REG_Files[W_Addr]=W_Data;
	end
endmodule
	
module top(R_Addr_A,R_Addr_B,W_Addr,sw,W,ALU_OP,an,seg,clk,clk_s,reset);
	input[4:0] R_Addr_A;
	input[4:0] R_Addr_B;
	input[4:0] W_Addr;
	input clk_s;
	input W;
	input sw;
	input[2:0] ALU_OP;
	input clk,reset;
	output[3:0] an;
	output[7:0] seg;
	
	wire ZF,OF;
	wire[31:0] F;
	wire[31:0] R_Data_A;
	wire[31:0] R_Data_B;
	reg[31:0] led;
	
	Register_file Register_file0(R_Addr_A,R_Addr_B,W_Addr,W,F,clk,reset,R_Data_A,R_Data_B);
	ALU ALU0(OF,ZF,R_Data_A,R_Data_B,ALU_OP,F);
	
	always@(*)
	begin
	if(sw)
		led=F;
	else
		led={30'b0,ZF,OF};
	end
	
	clk_show clk_show0(clk_s,clk_t);
	show show0(reset,clk_t,led,an,seg);
	
endmodule

module clk_show(clk_in,clk_out);//分频器1数码管刷新
	input clk_in;
	reg[11:0] counter = 12'b0;
	output reg clk_out = 1'b0;
	always @(posedge clk_in)
	begin
		if(counter == 11'd2000)
			begin
				clk_out <= ~clk_out;
				counter <= 12'b0;
			end	 
      else
			counter <= counter+1'b1;
   end
endmodule

module show(clr,clk,Data,an,seg);//数码管显示模块
	input clk,clr;
	input[31:0] Data;
	output reg[3:0] an;
	output reg[7:0] seg;

	reg[2:0] BitSel = 3'b0; //选择用哪一个数码管显示
	reg[3:0] data; //数码管所需要显示的数字
	//数码管显示数字模块
	always@(*)
	begin
		case(data)
			4'b0000: seg[7:0]<=8'b00000011;
			4'b0001: seg[7:0]<=8'b10011111;
			4'b0010: seg[7:0]<=8'b00100101;
			4'b0011: seg[7:0]<=8'b00001101;
			4'b0100: seg[7:0]<=8'b10011001;
			4'b0101: seg[7:0]<=8'b01001001;
			4'b0110: seg[7:0]<=8'b01000001;
			4'b0111: seg[7:0]<=8'b00011111;
			4'b1000: seg[7:0]<=8'b00000001;
			4'b1001: seg[7:0]<=8'b00001001;
			4'b1010: seg[7:0]<=8'b00010001;
			4'b1011: seg[7:0]<=8'b11000001;
			4'b1100: seg[7:0]<=8'b01100011;
			4'b1101: seg[7:0]<=8'b10000101;
			4'b1110: seg[7:0]<=8'b01100001;
			4'b1111: seg[7:0]<=8'b01110001;
		endcase
	end
	
	always@( posedge clk)
		begin
				begin
							BitSel <= BitSel + 1'b1;
							case(BitSel)
							3'b000: 
							begin 
								an<=4'b1111;
								if(clr) data <= 4'b1010;
								else data<=Data[3:0];
							end
							3'b001: 
							begin
								an<=4'b1110;							
								if(clr) data <= 4'b1010;
								else data<=Data[7:4];
							end
							3'b010: 
							begin
								an<=4'b1101;
								if(clr) data <= 4'b1010;
								else data<=Data[11:8];
							end
							3'b011: 
							begin
								an<=4'b1100;
								if(clr) data <= 4'b1010;
								else data<=Data[15:12];								
							end							
							3'b100:
							begin
								an<=4'b1011;
								if(clr) data <= 4'b1010;
								else data<=Data[19:16];
							end
							3'b101:
							begin
								an<=4'b1010;
								if(clr) data <= 4'b1010;
								else data<=Data[23:20];
							end
							3'b110:
							begin
								an<=4'b1001;
								if(clr) data <= 4'b1010;
								else data<=Data[27:24];
							end
							3'b111:
							begin
								an<=4'b1000;
								if(clr) data <= 4'b1010;
								else data<=Data[31:28];
							end
						endcase		
				end
		end
endmodule

