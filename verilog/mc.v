`timescale 10ns/10ps

module mc (
           inout c,
           inout cb,
           input sw
           );

   reg           c_reg, cb_reg;

   always begin
      #1;      
      if(sw) begin
         c_reg = c;
         cb_reg = cb;
      end else begin
         cb_reg = ~c_reg;
         c_reg = ~cb_reg;
      end
   end

   assign (weak0, weak1) c = c_reg;
   assign (weak0, weak1) cb = cb_reg;

endmodule

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

endmodule // mc

