`timescale 1ns/1ps
module div_tb;
   reg [3:0] D, d;
   wire [3:0] q, r;
   reg        clk, rst;
   
   div div0 (
             .D(D),
             .d(d),
             .q(q),
             .r(r),
             .clk(clk),
             .rst(rst)
             );
 
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars();
      rst = 1;
      clk = 1;  
      D = 15;
      d = 2;
      #40
      rst = 0;
      #400;
      D = 0;
      d = 2;
      #100 rst = 1;
      #100 rst = 0;
      #400;
      D = 8;
      d = 8;
      #100 rst = 1;
      #100 rst = 0;
      #400;
      D = 3;
      d = 6;
      #100 rst = 1;
      #100 rst = 0;
      #500;
      $finish;
   end

   always #10 clk = ~clk;
   
endmodule // div_tb

