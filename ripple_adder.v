`timescale 1ns / 1ns // `timescale time_unit/time_precision
 //SW[2:0] data inputs
 //SW[9] select signal
 //LEDR[0] output display

 module full_adder(a, b, c_in, sum, c_out);
     input a;
     input b;
     input c_in;
     output sum;
     output c_out;
     assign sum = (~((~a & b) | (a & ~b)) & c_in) | (((~a & b) | (a & ~b)) & ~c_in);
     assign c_out =  (((~a & b) | (a & ~b)) & c_in) | (a&b);
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





