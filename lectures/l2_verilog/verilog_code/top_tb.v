
`timescale 1ns / 1ps

module top_tb;

   reg 		rst;
   reg 		clk;
   
   reg [7:0] data_in;
   reg data_in_valid;

   
   reg [31:0] data_out_ref;
   wire [31:0] data_out;
   wire       data_out_valid;
   

   integer 	      i;
   
   
   // Instantiate the Unit Under Test (UUT)
   top uut (
		.rst            (rst),
		.clk		(clk),
		.data_in	(data_in),
		.data_in_valid	(data_in_valid),
		.data_out	(data_out),
		.data_out_valid	(data_out_valid)
		);
 
   
   initial begin
      $dumpfile("top.vcd");
      $dumpvars();
      
      rst = 1;
      clk = 1;
      
      data_in_valid = 0;

      #50.1 rst = 0;

      for(i=0; i < 10; i++) begin 
	 data_in = i+2;
	 data_in_valid = 1;
	 data_out_ref = (i+2)**4;
	 #10 data_in_valid = 0;
	 #50 data_in = 0;
	 
      end
	 
      $finish;

   end
   
   always
     #(10/2) clk = ~clk; //period=10ns => 100MHz
   

endmodule

