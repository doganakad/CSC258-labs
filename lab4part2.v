module lab4part2(SW, LEDR, KEY, CLOCK_50, HEX0);
	input CLOCK_50;
	input [3:0] KEY;
	input [1:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX0;
	
	wire connectionclock;
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
	

	RateDivider r(
		.clk(CLOCK_50),
		.b0(SW[0]),
		.b1(SW[1]),
		.q(connectionclock)
	);
	
	tflipflop flip0(
		.enable_signal(KEY[0]),
		.clock(connectionclock),
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
		.clock(connectionclock),
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
		.clock(connectionclock),
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
		.clock(connectionclock),
		.clear_b(KEY[2]),
		.q(connection3a)
	);
	
	assign LEDR[3] = connection3a;
	assign LEDR[2] = connection2a;
	assign LEDR[1] = connection1a;
	assign LEDR[0] = connection0a;
    segment_6 seg_6(
        .c0(connection0a),
        .c1(connection1a),
        .c2(connection2a),
        .c3(connection3a),
        .out(HEX0[6])
    );

    segment_5 seg_5(
        .c0(connection0a),
        .c1(connection1a),
        .c2(connection2a),
        .c3(connection3a),
        .out(HEX0[5])
    );

    segment_4 seg_4(
        .c0(connection0a),
        .c1(connection1a),
        .c2(connection2a),
        .c3(connection3a),
        .out(HEX0[4])
    );

    segment_3 seg_3(
        .c0(connection0a),
        .c1(connection1a),
        .c2(connection2a),
        .c3(connection3a),
        .out(HEX0[3])
    );

    segment_2 seg_2(
        .c0(connection0a),
        .c1(connection1a),
        .c2(connection2a),
        .c3(connection3a),
        .out(HEX0[2])
    );

    segment_1 seg_1(
        .c0(connection0a),
        .c1(connection1a),
        .c2(connection2a),
        .c3(connection3a),
        .out(HEX0[1])
    );

    segment_0 seg_0(
        .c0(connection0a),
        .c1(connection1a),
        .c2(connection2a),
        .c3(connection3a),
        .out(HEX0[0])
    );
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



module RateDivider(clk, b0, b1, q);
	input clk;
	input b0, b1;
	output reg q;
	reg [26:0] counter0;
	reg [26:0] counter1;
	reg [26:0] counter2;
	reg [26:0] counter3;

	always @(posedge clk)
	begin
		if (b0 == 0 && b1 == 0) begin
			q <= ~q;
		end else if (b0 == 0 && b1 == 1) begin
			if (counter0 == 26'b10111110101111000010000000) begin
				q <= 1;
				counter0 <= 0;
			end else begin
				q <= 0;
				counter0 <= counter0 + 1'b1;
			end
		end else if (b0 == 1 && b1 == 0) begin
			if (counter0 == 26'b10111110101111000010000000) begin
				if (counter1 == 26'b10111110101111000010000000) begin
					q <= 1;
					counter0 <= 0;
					counter1 <= 0;
				end else begin
					q <= 0;
					counter1 <= counter1 + 1'b1;
				end
			end else begin
				q <= 0;
				counter0 <= counter0 + 1'b1;
			end
		end else if (b0 == 1 && b1 == 1) begin
			if (counter0 == 26'b10111110101111000010000000) begin
				if (counter1 == 26'b10111110101111000010000000) begin
					if (counter2 == 26'b10111110101111000010000000) begin
						if (counter3 == 26'b10111110101111000010000000) begin
							q <= 1;
							counter0 <= 0;
							counter1 <= 0;
							counter2 <= 0;
							counter3 <= 0;
						end else begin
							q <= 0;
							counter3 <= counter3 + 1'b1;
						end
					end else begin
						q <= 0;
						counter2 <= counter2 + 1'b1;
					end
				end else begin
					q <= 0;
					counter1 <= counter1 + 1'b1;
				end
			end else begin
				q <= 0;
				counter0 <= counter0 + 1'b1;
			end
		end
	end
endmodule


module segment_5(c3, c2, c1, c0, out);
    input c3;
    input c2;
    input c1;
    input c0;
    output out;
    assign out = ~c3&~c2&c1&~c0 | ~c3&~c2&c1&c0 | ~c3&c2&c1&c0 | c3&c2&~c1&c0;
endmodule

module segment_4(c3, c2, c1, c0, out);
    input c3;
    input c2;
    input c1;
    input c0;
    output out;
    assign out = ~c3&~c2&c1&c0 | ~c3&c2&~c1&~c0 | ~c3&c2&~c1&c0 | ~c3&c2&c1&c0 | c3&~c2&~c1&c0;
endmodule


module segment_3(c3, c2, c1, c0, out);
    input c3;
    input c2;
    input c1;
    input c0;
    output out;
    assign out = ~c3&~c2&~c1&c0 | ~c3&c2&~c1&~c0 | ~c3&c2&c1&c0 | c3&~c2&~c1&c0 | c3&~c2&c1&~c0 | c0&c1&c2&c3;
endmodule


module segment_6(c0, c1, c2, c3, out);
    input c0; //selected when s is 0
    input c1; //selected when s is 1
    input c2; //select signal
	 input c3;
    output out;
    assign out = ~c3 & ~c2 & ~c1 & ~c0 | ~c3 & ~c2 & ~c1 & c0 | ~c3 & c2 & ~c1 & c0 | ~c3 & c2 & c1 & c0 | c3 & c2 & ~c1 & ~c0 ;
    // OR
    // assign m = s ? y : x;

endmodule

module segment_2(c0, c1, c2, c3, out);
    input c0; //selected when s is 0
    input c1; //selected when s is 1
    input c2; //select signal
	 input c3;
    output out;
    assign out = ~c3 & ~c2 & ~c1 & c0 | ~c3 & ~c2 & c1 & ~c0 | c3 & c2 & ~c1 & ~c0 | c3 & c2 & c1 & ~c0 | c3 & c2 & c1 & c0 ;
    // OR
    // assign m = s ? y : x;

endmodule

module segment_1(c0, c1, c2, c3, out);
    input c0; //selected when s is 0
    input c1; //selected when s is 1
    input c2; //select signal
	 input c3;
    output out;
    assign out = ~c3 & ~c2 & ~c1 & c0 | ~c3 & c2 & ~c1 & c0 | ~c3 & c2 & c1 & ~c0 | c3 & ~c2 & c1 & c0 | c3 & c2 & c1 & ~c0 | c3 & c2 & c1 & c0;
    // OR
    // assign m = s ? y : x;

endmodule

module segment_0(c0, c1, c2, c3, out);
    input c0; //selected when s is 0
    input c1; //selected when s is 1
    input c2; //select signal
	 input c3;
    output out;
    assign out = ~c3 & ~c2 & ~c1 & c0 | ~c3 & c2 & ~c1 & ~c0 | c3 & ~c2 & c1 & c0 | c3 & c2 & ~c1 & c0;
    // OR
    // assign m = s ? y : x;

endmodule


