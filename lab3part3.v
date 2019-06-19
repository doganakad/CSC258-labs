module lab3part3(SW, KEY, LEDR);
	input [9:0] SW; //SW[9] is connected to the synchronous active low reset
	input [3:0] KEY;
	output [7:0] LEDR;
	reg [7:0] Q;
	
	
	wire s1tos2;
	wire s2tos3;
	wire s3tos4;
	wire s4tos5;
	wire s6tos7;
	wire s7tos8;
	
	ShifterBit s1(
		.load_val(SW[7]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(KEY[0]),
		.in(0),
		.out(s1tos2)
	);

	ShifterBit s2(
		.load_val(SW[6]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(KEY[0]),
		.in(s1tos2),
		.out(s2tos3)
	);
	
	ShifterBit s3(
		.load_val(SW[5]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(KEY[0]),
		.in(s2tos3),
		.out(s3tos4)
	);
	
	
	ShifterBit s4(
		.load_val(SW[4]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(KEY[0]),
		.in(s3tos4),
		.out(s4tos5)
	);
	
	ShifterBit s5(
		.load_val(SW[3]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(KEY[0]),
		.in(s4tos5),
		.out(s5tos6)
	);
	
	ShifterBit s6(
		.load_val(SW[2]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(KEY[0]),
		.in(s5tos6),
		.out(s6tos7)
	);
	
	
	ShifterBit s7(
		.load_val(SW[1]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(KEY[0]),
		.in(s6tos7),
		.out(s7tos8)
	);
	
	ShifterBit s8(
		.load_val(SW[0]),
		.shift(KEY[2]),
		.load_n(KEY[1]),
		.reset_n(SW[9]),
		.clk(KEY[0]),
		.in(s7tos8),
		.out(LEDR[0])
	);
	
	assign LEDR[1] = s7tos8;
	assign LEDR[2] = s6tos7;
	assign LEDR[3] = s5tos6;
	assign LEDR[4] = s4tos5;
	assign LEDR[5] = s3tos4;
	assign LEDR[6] = s2tos3;
	assign LEDR[7] = s1tos2;
	
	
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
