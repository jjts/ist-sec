`timescale 1ns/1ps

module register (
  input		    clk,
  input             en,
  input    [31:0] data_in,   
  output reg [31:0] data_out    
);


always @ (posedge clk)
   if (en == 1'd1) 
     data_out <= data_in;

endmodule
