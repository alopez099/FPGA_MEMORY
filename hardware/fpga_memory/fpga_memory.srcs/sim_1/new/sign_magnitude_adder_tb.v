`timescale 1ns / 1ps

module sign_magnitude_adder_tb;

  reg [7:0] A, B;
  reg cin;
  wire [7:0] S;
  wire cout;
  integer i ;
  
  sign_magnitude_adder dut (
    .A(A),
    .B(B),
    .cin(cin),
    .S(S),
    .cout(cout)
  );

  initial begin
    $display("A B cin | S cout");
    $display("---------|-----");
    for ( i = 0; i < 65536; i = i + 1) begin
      A = i % 32;
      B = i / 32;
      cin = (i > 32768) ? 1 : 0; //Sets cin to 1 if i is greater than 15, and 0 
      #1 $display("%b %b %b | %b %b", A, B, cin, S, cout); //Delays the simulation by one time unit
                                                           // and displays the current values of A, B, cin, S, and cout.
    end
    $finish;
  end

endmodule