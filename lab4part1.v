module lab4part1(KEY, LEDR);
	input [3:0] KEY;
	output [9:0] LEDR;
	
	wire connection0;
	wire connection1;
	wire connection2;
	wire connection3;
	wire connection4;
	wire connection5;
	wire connection6;
	
	wire connection0a;
	wire connection1a;
	wire connection2a;
	wire connection3a;
	wire connection4a;
	wire connection5a;
	wire connection6a;
	wire connection7a;
	
	tflipflop flip0(
		.enable_signal(KEY[0]),
		.clock(KEY[1]),
		.clear_b(KEY[2]),
		.q(connection0a)
	);
	
	andmodule and1(
		.e1(KEY[0]),
		.e2(connection0a),
		.q(connection0)
	);

	tflipflop flip1(
		.enable_signal(connection0),
		.clock(KEY[1]),
		.clear_b(KEY[2]),
		.q(connection1a)
	);

	andmodule and2(
		.e1(connection0),
		.e2(connection1a),
		.q(connection1)
	);

	tflipflop flip2(
		.enable_signal(connection1),
		.clock(KEY[1]),
		.clear_b(KEY[2]),
		.q(connection2a)
	);

	andmodule and3(
		.e1(connection1),
		.e2(connection2a),
		.q(connection2)
	);

	tflipflop flip3(
		.enable_signal(connection2),
		.clock(KEY[1]),
		.clear_b(KEY[2]),
		.q(connection3a)
	);

	andmodule and4(
		.e1(connection2),
		.e2(connection3a),
		.q(connection3)
	);
	
	tflipflop flip4(
		.enable_signal(connection3),
		.clock(KEY[1]),
		.clear_b(KEY[2]),
		.q(connection4a)
	);

	andmodule and5(
		.e1(connection3),
		.e2(connection4a),
		.q(connection4)
	);

	
	tflipflop flip5(
		.enable_signal(connection4),
		.clock(KEY[1]),
		.clear_b(KEY[2]),
		.q(connection5a)
	);

	andmodule and6(
		.e1(connection4),
		.e2(connection5a),
		.q(connection5)
	);
	
	tflipflop flip6(
		.enable_signal(connection5),
		.clock(KEY[1]),
		.clear_b(KEY[2]),
		.q(connection6a)
	);

	andmodule and7(
		.e1(connection5),
		.e2(connection6a),
		.q(connection6)
	);
	
	tflipflop flip7(
		.enable_signal(connection6),
		.clock(KEY[1]),
		.clear_b(KEY[2]),
		.q(LEDR[7])
	);
	
	assign LEDR[6] = connection6a;
	assign LEDR[5] = connection5a;
	assign LEDR[4] = connection4a;
	assign LEDR[3] = connection3a;
	assign LEDR[2] = connection2a;
	assign LEDR[1] = connection1a;
	assign LEDR[0] = connection0a;
endmodule
	
module tflipflop(q,q1,enable_signal,clock, clear_b);
	output q,q1;
	input clear_b,enable_signal,clock;
	reg q,q1;
	
	initial
		begin
			q = 1'b0;
			q1 = ~q;
		end
	
	always @(posedge clock, negedge clear_b)
		if (!clear_b) begin
			q <= 1'b0;
			q1 <= 1'b1;
		end
		else if (enable_signal) begin
			q <= ~q;
			q1 <= ~q1;
		end
endmodule

module andmodule(e1, e2, q);
	input e1, e2;
	output q;
	
	assign q = e1 & e2;
endmodule
