`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signal

//LEDR[0] output display

module case_1(a,b,c);
	input [3:0] a,b;
	output[7:0] c;
	wire [4:0] s;
	assign s = a + b;
	assign c = {3'b000, s};
endmodule

 module full_adder(a, b, carry_in, sum, carry_out);
     input a;
     input b;
     input carry_in;
     output sum;
     output carry_out;
     assign sum = (~((~a & b) | (a & ~b)) & carry_in) | (((~a & b) | (a & ~b)) & ~carry_in);
     assign carry_out =  (((~a & b) | (a & ~b)) & carry_in) | (a&b);
 endmodule

 module ripple_adder(LEDR, SW);
     input [9:0] SW;
     output [9:0] LEDR;
     wire Connection1;
     wire Connection2;
     wire Connection3;

     full_adder first_adder(
         .a(SW[0]),
         .b(SW[4]),
         .c_in(SW[8]),
         .sum(LEDR[0]),
         .c_out(Connection1)
     );
     full_adder second_adder(
         .a(SW[1]),
         .b(SW[5]),
         .c_in(Connection1),
         .sum(LEDR[1]),
         .c_out(Connection2)
     );
     full_adder third_adder(
         .a(SW[2]),
         .b(SW[6]),
         .c_in(Connection2),
         .sum(LEDR[2]),
         .c_out(Connection3)
     );
     full_adder fourth_adder(
         .a(SW[3]),
         .b(SW[7]),
         .c_in(Connection3),
         .sum(LEDR[3]),
         .c_out(LEDR[9])
     );
 endmodule


module mux7to1(x,y,s,t,u,v,a,z,out);
	input x;
	input y;
	input s;
	input t;
	input u;
	input v;
	input a;
	input [2:0] z;
	output out;
	reg out;
	
	
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
		default:out = x;
		endcase
	end
endmodule


module case_2(a0, a1, a2, a3, b0, b1, b2, b3, m0, m1, m2, m3, m4, m5, m6, m7);
  input a0;
  input a1;
  input a2;
  input a3;
  input b0;
  input b1;
  input b2;
  input b3;

  output m0;
  output m1;
  output m2;
  output m3;
  output m4;
  output m5;
  output m6;
  output m7;

  assign m0 = (a0 & ~b0) | (~a0 & b0);
  assign m1 = (a1 & ~b1) | (~a1 & b1);
  assign m2 = (a2 & ~b2) | (~a2 & b2);
  assign m3 = (a3 & ~b3) | (~a3 & b3);
  assign m4 = a0 | b0;
  assign m5 = a1 | b1;
  assign m6 = a2 | b2;
  assign m7 = a3 | b3;
endmodule

module case_3(a0, a1, a2, a3, b0, b1, b2, b3, m0, m1, m2, m3, m4, m5, m6, m7);
  input a0;
  input a1;
  input a2;
  input a3;
  input b0;
  input b1;
  input b2;
  input b3;
  output m0;
  output m1;
  output m2;
  output m3;
  output m4;
  output m5;
  output m6;
  output m7;
  assign m0 = a0 | a1 | a2| a3 | b0 | b1 | b2 | b3;
  assign m1 = 0;
  assign m2 = 0;
  assign m3 = 0;
  assign m4 = 0;
  assign m5 = 0;
  assign m6 = 0;
  assign m7 = 0;
endmodule


module case_4(a0, a1, a2, a3, b0, b1, b2, b3, m0, m1, m2, m3, m4, m5, m6, m7);
  input a0;
  input a1;
  input a2;
  input a3;
  input b0;
  input b1;
  input b2;
  input b3;
  output m0;
  output m1;
  output m2;
  output m3;
  output m4;
  output m5;
  output m6;
  output m7;
  assign m0 = a0 & a1 & a2 & a3 & b0 & b1 & b2 & b3;
  assign m1 = 0;
  assign m2 = 0;
  assign m3 = 0;
  assign m4 = 0;
  assign m5 = 0;
  assign m6 = 0;
  assign m7 = 0;
endmodule

module default_case(a0, a1, a2, a3, b0, b1, b2, b3, m0, m1, m2, m3, m4, m5, m6, m7);
  input a0;
  input a1;
  input a2;
  input a3;
  input b0;
  input b1;
  input b2;
  input b3;
    output m0;
    output m1;
    output m2;
    output m3;
    output m4;
    output m5;
    output m6;
    output m7;
    assign m0 = 0;
    assign m1 = 0;
    assign m2 = 0;
    assign m3 = 0;
    assign m4 = 0;
    assign m5 = 0;
    assign m6 = 0;
    assign m7 = 0;
endmodule

module case_5(a0, a1, a2, a3, b0, b1, b2, b3, m0, m1, m2, m3, m4, m5, m6, m7);
  input a0;
  input a1;
  input a2;
  input a3;
  input b0;
  input b1;
  input b2;
  input b3;
  output m0;
  output m1;
  output m2;
  output m3;
  output m4;
  output m5;
  output m6;
  output m7;
  assign m0 = a0;
  assign m1 = a1;
  assign m2 = a2;
  assign m3 = a3;
  assign m4 = b3;
  assign m5 = b2;
  assign m6 = b1;
  assign m7 = b0;
endmodule

module case_0(a0, a1, a2, a3, b0, b1, b2, b3, m0, m1, m2, m3, m4, m5, m6, m7);
    input a0;
    input a1;
    input a2;
    input a3;
    input b0;
    input b1;
    input b2;
    input b3;
    output m0;
    output m1;
    output m2;
    output m3;
    output m4;
    output m5;
    output m6;
	 output m7;
    wire Connection1;
    wire Connection2;
    wire Connection3;
    
  full_adder first_adder(
      .a(a0),
      .b(b0),
      .carry_in(0),
      .sum(m0),
      .carry_out(Connection1)
  );

  full_adder second_adder(
      .a(a1),
      .b(b1),
      .carry_in(Connection1),
      .sum(m1),
      .carry_out(Connection2)
  );

  full_adder third_adder(
      .a(a2),
      .b(b2),
      .carry_in(Connection2),
      .sum(m2),
      .carry_out(Connection3)
  );

  full_adder fourth_adder(
      .a(a3),
      .b(b3),
      .carry_in(Connection3),
      .sum(m3),
      .carry_out(m4)
  );

  assign m5 = 0;
  assign m6 = 0;
  assign m7 = 0;
endmodule
		  
module top(SW, ALUout);

    input [9:0] SW;
    output [9:0] ALUout;

	//Wiers from blocks to multiplexers

  wire Connection00;
  wire Connection10;
  wire Connection20;
  wire Connection30;
  wire Connection40;
  wire Connection50;
  wire Connection60;
  wire Connection70;

	wire Connection01;
	wire Connection11;
	wire Connection21;
	wire Connection31;
	wire Connection41;
	wire Connection51;
	wire Connection61;
  wire Connection71;
	
	wire Connection02;
	wire Connection12;
	wire Connection22;
	wire Connection32;
	wire Connection42;
	wire Connection52;
	wire Connection62;
	wire Connection72;

	wire Connection03;
	wire Connection13;
	wire Connection23;
	wire Connection33;
	wire Connection43;
	wire Connection53;
	wire Connection63;
  wire Connection73;
	
	
	wire Connection04;
	wire Connection14;
	wire Connection24;
	wire Connection34;
	wire Connection44;
	wire Connection54;
	wire Connection64;
  wire Connection74;
	
	wire Connection05;
	wire Connection15;
	wire Connection25;
	wire Connection35;
	wire Connection45;
	wire Connection55;
	wire Connection65;
  wire Connection75;
	
	wire Connection06;
	wire Connection16;
	wire Connection26;
	wire Connection36;
	wire Connection46;
	wire Connection56;
	wire Connection66;
  wire Connection76;
	
	
	 //Multiplexers
  mux7to1 mux0(
       .x(Connection00),
       .y(Connection01),
       .s(Connection02),
       .t(Connection03),
       .u(Connection04),
       .v(Connection05),
       .a(Connection06),
       .z(SW[9:7]),
       .out(ALUout[0])
    );

	mux7to1 mux1(
     .x(Connection10),
     .y(Connection11),
     .s(Connection12),
     .t(Connection13),
     .u(Connection14),
     .v(Connection15),
     .a(Connection16),
     .z(SW[9:7]),
     .out(ALUout[1])
  );

	  mux7to1 mux2(
       .x(Connection20),
       .y(Connection21),
       .s(Connection22),
       .t(Connection23),
       .u(Connection24),
       .v(Connection25),
       .a(Connection26),
       .z(SW[9:7]),
       .out(ALUout[2])
    );

    mux7to1 mux3(
     .x(Connection30),
     .y(Connection31),
     .s(Connection32),
     .t(Connection33),
     .u(Connection34),
     .v(Connection35),
     .a(Connection36),
     .z(SW[9:7]),
     .out(ALUout[3])
    );


	 mux7to1 mux4(
       .x(Connection40),
       .y(Connection41),
       .s(Connection42),
       .t(Connection43),
       .u(Connection44),
       .v(Connection45),
       .a(Connection46),
       .z(SW[9:7]),
       .out(ALUout[4])
    );

	 mux7to1 mux5(
       .x(Connection50),
       .y(Connection51),
       .s(Connection52),
       .t(Connection53),
       .u(Connection54),
       .v(Connection55),
       .a(Connection56),
       .z(SW[9:7]),
       .out(ALUout[5])
    );


	 mux7to1 mux6(
       .x(Connection60),
       .y(Connection61),
       .s(Connection62),
       .t(Connection63),
       .u(Connection64),
       .v(Connection65),
       .a(Connection66),
       .z(SW[9:7]),
       .out(ALUout[6])
    );

   mux7to1 mux7(
       .x(Connection70),
       .y(Connection71),
       .s(Connection72),
       .t(Connection73),
       .u(Connection74),
       .v(Connection75),
       .a(Connection76),
       .z(SW[9:7]),
       .out(ALUout[7])
    );

	 case_0 c0(
         .a0(SW[0]),
         .a1(SW[1]),
         .a2(SW[2]),
         .a3(SW[3]),
         .b0(SW[4]),
         .b1(SW[5]),
         .b2(SW[6]),
         .b3(SW[7]),
			.m0(Connection00),
			.m1(Connection10),
			.m2(Connection20),
			.m3(Connection30),
			.m4(Connection40),
			.m5(Connection50),
			.m6(Connection60),
         .m7(Connection70)
	 );
	 /**
	 case_1 c1(
		.a(SW[0:3]),
		.b(SW[4:7]),
		.c[0](Connection01),
		.c[1](Connection11),
		.c[2](Connection21),
		.c[3](Connection31),
		.c[4](Connection41),
		.c[5](Connection51),
		.c[6](Connection61)
	)
	 **/

    case_2 c2(
       .a0(SW[0]),
       .a1(SW[1]),
       .a2(SW[2]),
       .a3(SW[3]),
       .b0(SW[4]),
       .b1(SW[5]),
       .b2(SW[6]),
       .b3(SW[7]),
			.m0(Connection02),
			.m1(Connection12),
			.m2(Connection22),
			.m3(Connection32),
			.m4(Connection42),
			.m5(Connection52),
			.m6(Connection62),
      .m7(Connection72)
    );

    case_3 c3(
       .a0(SW[0]),
       .a1(SW[1]),
       .a2(SW[2]),
       .a3(SW[3]),
       .b0(SW[4]),
       .b1(SW[5]),
       .b2(SW[6]),
       .b3(SW[7]),
			.m0(Connection03),
			.m1(Connection13),
			.m2(Connection23),
			.m3(Connection33),
			.m4(Connection43),
			.m5(Connection53),
			.m6(Connection63),
      .m7(Connection73)
    );

    case_4 c4(
       .a0(SW[0]),
       .a1(SW[1]),
       .a2(SW[2]),
       .a3(SW[3]),
       .b0(SW[4]),
       .b1(SW[5]),
       .b2(SW[6]),
       .b3(SW[7]),
			.m0(Connection01),
			.m1(Connection14),
			.m2(Connection24),
			.m3(Connection34),
			.m4(Connection44),
			.m5(Connection54),
			.m6(Connection64),
      .m7(Connection74)
    );

    case_5 c5(
       .a0(SW[0]),
       .a1(SW[1]),
       .a2(SW[2]),
       .a3(SW[3]),
       .b0(SW[4]),
       .b1(SW[5]),
       .b2(SW[6]),
       .b3(SW[7]),
			.m0(Connection05),
			.m1(Connection15),
			.m2(Connection25),
			.m3(Connection35),
			.m4(Connection45),
			.m5(Connection55),
			.m6(Connection65),
      .m7(Connection75)
    );


  default_case d_case(
     .a0(SW[0]),
     .a1(SW[1]),
     .a2(SW[2]),
     .a3(SW[3]),
     .b0(SW[4]),
     .b1(SW[5]),
     .b2(SW[6]),
     .b3(SW[7]),
		.m0(Connection06),
		.m1(Connection16),
		.m2(Connection26),
		.m3(Connection36),
		.m4(Connection46),
		.m5(Connection56),
		.m6(Connection66),
    .m7(Connection76)
  );
endmodule
/**
module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
 
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;
endmodule
**/