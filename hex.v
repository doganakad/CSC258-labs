`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[[3:0] data inputs
//HEX0[6:0] hex display

module mux(HEX0, SW);
    input [3:0] SW;
    output [6:0] HEX0;

    segment_6 seg_6(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .out(HEX0[6])
    );

    segment_5 seg_5(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .out(HEX0[5])
    );

    segment_4 seg_4(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .out(HEX0[4])
    );

    segment_3 seg_3(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .out(HEX0[3])
    );

    segment_2 seg_2(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .out(HEX0[2])
    );

    segment_1 seg_1(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .out(HEX0[1])
    );

    segment_0 seg_0(
        .c0(SW[0]),
        .c1(SW[1]),
        .c2(SW[2]),
        .c3(SW[3]),
        .out(HEX0[0])
    );
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
    assign out = ~c3&~c2&~c1&c0 | ~c3&c2&~c1&~c0 | ~c3&c2&c1&c0 | c3&~c2&~c1&c0 | c3&~c2&c1&~c0;
endmodule


module segment_6(c0, c1, c2, c3, out);
    input c0; //selected when s is 0
    input c1; //selected when s is 1
    input c2; //select signal
	 input c3;
    output out;
    assign out = ~c3 & ~c2 & ~c1 & ~c0 | ~c3 & ~c2 & ~c1 & c0 | ~c3 & c2 & ~c1 & c0 | ~c3 & c2 & c1 & ~c0 | ~c3 & c2 & c1 & c0 | c3 & c2 & ~c1 & ~c0 ;
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
    assign out = ~c3 & ~c2 & ~c1 & c0 | ~c3 & c2 & ~c1 & c0 | ~c3 & c2 & c1 & ~c0 | c3 & ~c2 & c1 & c0 | ~c3 & ~c2 & c1 & c0 | c3 & c2 & c1 & ~c0 | c3 & c2 & c1 & c0;
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
