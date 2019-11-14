`timescale 1ns/1ps
module div(
           input [3:0]      D,
           input [3:0]      d,
           output reg [3:0] q,
           output [3:0]     r,
           input            rst,
           input            clk,
           output           valid
);
   reg [7:0]                Dext;
   reg [2:0]                cnt;

   assign r = Dext[3:0];

   assign valid = (cnt == 3'b111);

   always @ (posedge clk) begin 
      if(rst) begin
         q <= 4'b1111;
         cnt <= 4;
      end else begin
         if(cnt == 4)
           Dext <= {4'b0, D};
         else if( (d<<cnt) > Dext )
           q[cnt] <= 0;
         else
           Dext <= Dext - (d<<cnt);
         cnt <= (cnt != 3'b111) ? cnt - 1'b1 : cnt;
      end
   end
endmodule // div





