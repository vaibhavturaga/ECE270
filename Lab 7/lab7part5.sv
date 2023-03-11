`default_nettype none
// Empty top module

module top (
  // I/O ports
  input  logic hz100, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);

  // Your code goes here...
  hc74_set st(.d(right[3]), .c(pb[0]), .q(right[0]), .sn(pb[16]));
  hc74_reset rs1(.d(right[0]), .c(pb[0]), .q(right[1]), .rn(pb[16]));
  hc74_reset rs2(.d(right[1]), .c(pb[0]), .q(right[2]), .rn(pb[16]));
  hc74_reset rs3(.d(right[2]), .c(pb[0]), .q(right[3]), .rn(pb[16]));

endmodule

// Add more modules down here...
module hc74_reset(input logic d, c, rn,
                  output logic q, qn);
  assign qn = ~q;
  always_ff @(posedge c, negedge rn)
    if (rn == 1'b0)
      q <= 1'b0;
    else
      q <= d;
endmodule

module hc74_set(input logic d, c, sn,
                  output logic q, qn);
  assign qn = ~q;
  always_ff @(posedge c, negedge sn)
    if (sn == 1'b0)
      q <= 1'b1;
    else
      q <= d;
endmodule