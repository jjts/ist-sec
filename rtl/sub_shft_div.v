`timescale 1ns / 1ps

module sub_shft_div (
                     input         clk,
                     input         rst,
                     
                     input [7:0]   a, 
                     input [7:0]   b,
                     output reg [7:0] c,
                     output reg [7:0] d,
                     input         start,
                     output        done
                     );

   reg [3:0]                     counter;
   assign done = (counter == 4'd8);

   always@(posedge clk)
     if(rst)
       counter <= 8;
     else if (start)
       counter <= 0;
     else if (counter != 8)
       counter <= counter + 1'b1;
   
   wire [7:0]                    tmp = d<<1 | a[7-counter];
   
   always@(posedge clk)
     if(rst) begin
       c <= 0;
       d <= 0;
     end else if(counter != 8) begin 
        c <= c<<1 | ( tmp > b);
        d <= tmp > b? tmp-b: tmp;
     end
   
endmodule


module sub_shft_div_tb ();

   reg clk, rst;
   reg [7:0] a, b;
   wire [7:0] c;
   wire [7:0] d;
   reg         start;
   wire        done;
   
   sub_shft_div div0 (
                       .clk(clk),
                       .rst(rst),
                     
                       .a(a), 
                       .b(b),
                       .c(c),
                       .d(d),
                       .start(start),
                       .done(done)
                     );   

   initial begin

      $dumpfile("dump.vcd");
      $dumpvars;
      
      rst = 1;
      clk = 1;
      start = 0;

      a= 144;
      b = 33;

      @(posedge clk) #1 rst=0;

      #5 @(posedge clk) #1 start=1;
      @(posedge clk) #1 start=0;

      @(posedge done)$display("%d/%d=%d*%d+%d", a, b, c, b, d);
      
      @(posedge clk) $finish;
   end
   
   always #10 clk = ~clk;
 
endmodule
