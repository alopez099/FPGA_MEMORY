`timescale 1ns / 1ps
module sign_magnitude_adder (
  input [7:0] A, B,  // the [7]th bit represents the signed bit
  input cin,
  output reg [7:0] S,
  output reg cout
);

  always @(*) begin // Needds to be in always block since values are non-constant
    if (A[7] == 1 && B[7] == 1) begin
      // both A and B are negative
      S = -A - B - cin;
      cout = (S[7] == 1) ? 0 : 1;
//The expression (S[7] == 1) is evaluated first. If it is true, then the value assigned to cout will be 0. 
//If it is false, then the value assigned to cout will be 1.

    end else if (A[7] == 1 && B[7] == 0) begin
      // A is negative and B is positive
      S = B - A - cin;
      cout = (S[7] == 0) ? 1 : 0;
    end else if (A[7] == 0 && B[7] == 1) begin
      // A is positive and B is negative
      S = A - B - cin;
      cout = (S[7] == 0) ? 1 : 0;
    end else begin
      // both A and B are positive
      S = A + B + cin;
      cout = (S[7] == 1) ? 1 : 0;
    end
  end

endmodule
