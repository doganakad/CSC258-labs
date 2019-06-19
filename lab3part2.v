module lab3part2(SW, HEX0, HEX1, KEY, LEDR);

	input [9:0] SW;
	output [7:0] LEDR;
	reg [7:0] q;
	input [3:0] KEY;
	output [6:0] HEX0,HEX1;
	wire [7:0] alu_to_register;
	wire[7:0] register_to_alu;
	
	alu alu_component(
		.A(SW[3:0]),
		.B(register_to_alu[3:0]),
		.alu_function(KEY[3:1]),
		.result(alu_to_register)
	);
	
	the_register register(
		.clock_in(KEY[0]),

		.reset_n(SW[9]),
		.d(alu_to_register),
		.q(register_to_alu)
	);
	
	
	hex_decoder lsb(
		.hex_digit(register_to_alu[3:0]),
		.segments(HEX0)
	);
	
	hex_decoder msb(
		.hex_digit(register_to_alu[7:4]),
		.segments(HEX1)
	);
	
	
	assign LEDR = register_to_alu;
endmodule

module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule


module the_register(reset_n, q, d, clock_in);
	input clock_in;
	input reset_n;
	input [7:0] d;
	output reg [7:0] q;	
	
	always@(posedge clock_in)
	begin
		if (reset_n == 1'b0)
			q <= 0;
		else
			q <= d;
	end
endmodule

	//assign HEX1 = 0;
	//assign HEX2 = 0;
	//assign HEX3 = 0;
//	assign LEDR = q;
	//assign HEX0 = SW[3:0];
	
	


module alu(A, B, alu_function, result);
	input [3:0] A;
	input [3:0] B;
	input [2:0] alu_function;
	output reg [7:0] result;
	
	
	wire [7:0] case0_connection;
	wire [7:0] case1_connection;
	wire [7:0] case2_connection;
	wire [7:0] case3_connection;
	wire [7:0] case4_connection;
	wire [7:0] case5_connection;
	wire [7:0] case6_connection;
	wire [7:0] case7_connection;
	
	//Case 0 declaration
	case_0 c0(
		.a(A),
		.b(B),
		.ci(case0_connection)
	);
	//Case 1 declaration
	case_1 c1(
		.a(A),
		.b(B),
		.c(case1_connection)
	);
	//Case 1 declaration
	case_2 c2(
		.a(A),
		.b(B),
		.c(case2_connection)
	);
	//Case 3 declaration
	case_3 c3(
		.a(A),
		.b(B),
		.c(case3_connection)
	);
	
	//Case 4 declaration
	case_4 c4(
		.a(A),
		.b(B),
		.c(case4_connection)
	);
	
	//Case 5 instantiation
	case_5 c5(
		.a(A),
		.b(B),
		.c(case5_connection)
	);
	
	//Case 6 instantiation
	case_6 c6(
		.a(A),
		.b(B),
		.c(case6_connection)
	);
	
	//Case 7 instantiation
	case_7 c7(
		.a(A),
		.b(B),
		.c(case7_connection)
	);
	
	always@(*)
	begin
		case(alu_function)
			3'b000: result = case0_connection;
			3'b001: result = case1_connection;
			3'b010: result = case2_connection;
			3'b011: result = case3_connection;
			3'b100: result = case4_connection;
			3'b101: result = case5_connection;
			3'b110: result = case6_connection;
			3'b111: result = case7_connection;
			default:
				result= 8'b00000000;
		endcase
	end
endmodule

module case_7(a, b, c);
	input [3:0] a;
	input [3:0] b;
	output [7:0] c;
	
	assign c = a * b;
endmodule

module case_6(a, b, c);
	input [3:0] a;
	input [3:0] b;
	output [7:0] c;
	
	assign c = b >> a;
endmodule

module case_5(a, b, c);
	input [3:0] a;
	input [3:0] b;
	output [7:0] c;
	
	assign c = b << a;
endmodule

module case_4(a, b, c);
	input [3:0] a;
	input [3:0] b;
	output [7:0] c;
	
	assign c = (a[0] & a[1] & a[2] & a[3] & b[0] & b[1] & b[2] & b[3]) ? 8'b0000000 : 8'b00000001;
endmodule

module case_2(a, b, c);
	input [3:0] a;
	input [3:0] b;
	output [7:0] c;
	
	assign c[0] = a[0] ^ b[0];
	assign c[1] = a[1] ^ b[1];
	assign c[2] = a[2] ^ b[2];
	assign c[3] = a[3] ^ b[3];
	assign c[4] = a[0] | b[0];
	assign c[5] = a[1] | b[1];
	assign c[6] = a[2] | b[2];
	assign c[7] = a[3] | b[3];
endmodule
			
module case_3(a, b, c);
	input [3:0] a, b;
	output [7:0] c;
	assign c = (a[0] | a[1] | a[2] | a[3] | b[0] | b[1] | b[2] | b[3]) ? 8'b0000000 : 8'b00000001;
endmodule

module case_0(a,b,ci,co,s);
	input a,b,ci;
	output co, s;
	assign co = (ci & (a ^ b)) | (a & b);
	assign s = (a ^ b ^ ci) | (a & b & ci);
endmodule

			
module case_1(a,b,c);
	input [3:0] a,b;
	output[7:0] c;
	wire [4:0] s;
	assign s = a + b;

	assign c = {3'b000, s};
endmodule