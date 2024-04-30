/*/
 *  file: downsampler
 *  purp: pass 1 N bit sample for every M samples
/*/

//////// module ////////
module downsampler
#(
  parameter N = 16,
  parameter M = 4,
  parameter logM = 2
)
(
  //// input signals ////
  input wire clk,
  input wire [N-1:0] sample,
  //// output signals ////
  output wire clkd4,
  output reg [N-1:0] sampled4
);
  //// internal signals ////
  wire counter [logM-1:0];

  //// always ////
  always @(posedge clk)
  begin
    if()
  end
end module

/*/
 *  authors: jack martin
 *  date: 04/27/2024
/*/