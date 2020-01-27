`timescale 1ns/1ps

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

   assign (weak0, weak1) c = sw? c_reg: 1'bz;
   assign (weak0, weak1) cb = sw? cb_reg: 1'bz;

endmodule

