`timescale 1ns / 1ns

module lab4part3(SW, KEY, LEDR, CLOCK_50);
	input CLOCK_50;
	output [9:0] LEDR;
	input [9:0] SW;
	input [3:0] KEY;
	wire clock_on_shifterbit;
	wire [11:0] multiplexer_determined_pattern;
	wire lsb;
	
	Pulsar pulse(
		.clk(CLOCK_50),
		.f(clock_on_shifterbit)
	);
	
	mux8to1 mux8(
		.x(11'b00000011101),
		.y(11'b00101010111),
		.s(11'b10111010111),
		.t(11'b00001010111),
		.u(11'b00000000001),
		.v(11'b00101110101),
		.a(11'b00101110111),
		.z(SW[2:0]),
		.ej(11'b000010101010),
		.out(multiplexer_determined_pattern)
	);
	
	Shifter shift_bit(
		.clk(clock_on_shifterbit),
		.input_bits(multiplexer_determined_pattern),
		.out(lsb),
		.KEY(KEY),
		.SW(SW) 
	);
	
	assign LEDR[0] = lsb;
endmodule


module Pulsar(clk,f);
	input clk;
	output reg f;
	reg [26:0] q;

	always @(posedge clk)
	begin
		if (q == 25'b1011111010111100001000000) begin
			f <= 1;
			q <= 0;
		end
		else
			f <= 0;
			q <= q + 1'b1;
	end
endmodule

module Shifter(input_bits, clk, out, KEY, SW);
	input [9:0] SW; //SW[9] is connected to the synchronous active low reset
	input [3:0] KEY;
	reg [7:0] Q;
	wire s1tos2;
	wire s2tos3;
	wire s3tos4;
	wire s4tos5;
	wire s6tos7;
	wire s7tos8;
	wire s8tos9;
	wire s9tos10;
	wire s11toout;
	output out;
	input [11:0] input_bits;
	input clk;

	ShifterBit s1(
		.load_val(input_bits[10]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(0),
		.out(s1tos2)
	);

	ShifterBit s2(
		.load_val(input_bits[9]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s1tos2),
		.out(s2tos3)
	);
	
	ShifterBit s3(
		.load_val(input_bits[8]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s2tos3),
		.out(s3tos4)
	);
	
	
	ShifterBit s4(
		.load_val(input_bits[7]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s3tos4),
		.out(s4tos5)
	);
	
	ShifterBit s5(
		.load_val(input_bits[6]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s4tos5),
		.out(s5tos6)
	);
	
	ShifterBit s6(
		.load_val(input_bits[5]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s5tos6),
		.out(s6tos7)
	);
	
	
	ShifterBit s7(
		.load_val(input_bits[4]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s6tos7),
		.out(s7tos8)
	);
	
	ShifterBit s8(
		.load_val(input_bits[3]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s7tos8),
		.out(s8tos9)
	);
	
	ShifterBit s9(
		.load_val(input_bits[2]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s8tos9),
		.out(s9tos10)
	);
	ShifterBit s10(
		.load_val(input_bits[1]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s9tos10),
		.out(s10tos11)
	);
	
	ShifterBit s11(
		.load_val(input_bits[0]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(clk),
		.in(s10tos11),
		.out(s11toout)
	);
	
	assign out = s11toout;
	
endmodule

module mux8to1(x,y,s,t,u,v,a,z,ej,out);
	input [10:0] x;
	input [10:0] y;
	input [10:0] s;
	input [10:0] ej;
	input [10:0] t;
	input [10:0] u;
	input [10:0] v;
	input [10:0] a;
	input [2:0] z;
	output reg [10:0] out;
	
	
	always @(*)
	begin
		case(z[2:0])
		3'b000: out = x;
		3'b001: out = y;
		3'b010: out = s;
		3'b011: out = t;
		3'b100: out = u;
		3'b101: out = v;
		3'b110: out = a;
		3'b111: out = ej;
		default:out = x;
		endcase
	end
endmodule


module ShifterBit(in, shift, load_val, load_n, clk, reset_n, out);
	input in;
	input shift;
	input load_n;
	input reset_n;
	input load_val;
	input clk;
	output out;

	wire outputtomux0;
	wire mux0tomux1;
	wire mux1toflipflop;
	
	
	mux2to1 MUX0(
		.x(in),
		.y(outputtomux0),
		.m(mux0tomux1),
		.s(shift)
	);
	
	mux2to1 MUX1(
		.x(mux0tomux1),
		.y(load_val),
		.s(load_n),
		.m(mux1toflipflop)
	);
	
	flipflop F0(
		.d(mux1toflipflop),
		.clock(clk),
		.reset_n(reset_n),
		.q(outputtomux0)
	);
	
	assign out = outputtomux0;
endmodule
	
module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;

endmodule

module flipflop(d, q, clock, reset_n);
	input d;
	input clock;
	input reset_n;
	output reg q;
	
	always @(posedge clock) // Triggered every time clock rises
		begin
		if (reset_n == 1'b0) // when reset n is 0 (note this is tested on every rising clock edge)
			q <= 0; // q is set to 0. Note that the assignment uses <=
		else // when reset n is not 	0
			q <= d; // value of d passes through to output q
		end
endmodule
