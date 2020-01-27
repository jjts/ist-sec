`timescale 1ns/1ps

module mc_tb;

   wire bl;
   wire blb;

   reg  drive_bl;
   reg  drive_blb;

   reg  sw;
      
   assign bl = drive_bl;
   assign blb = drive_blb;
   
      
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars();

      //write 0
      #100 drive_bl = 0;
      drive_blb = 1;
      #1 sw = 1;

      #100 sw = 0;
      
      //read 
      #100 drive_bl = 1'bz;
      drive_blb = 1'bz;
      #1 sw = 1;

      
      //write 1
      #100 drive_bl = 1;
      drive_blb = 0;
      #1 sw = 1;

      #100 sw = 0;
      
      //read 
      #100 drive_bl = 1'bz;
      drive_blb = 1'bz;
      #1 sw = 1;

      #100 sw = 0;
      $finish;
   end
  
   
   mc  mc0 (
           .c(bl),
           .cb(blb),
           .sw(sw)
           );

endmodule

