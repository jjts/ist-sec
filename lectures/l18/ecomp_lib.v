`timescale 1ns/1ps

module ecomp_not
  (
   input  a,
   output c
   );

   assign #1 c = ~a;

endmodule


module ecomp_and
  (
   input a,
   input b,
   output c
   );

   assign #1 c = a & b;

endmodule // ecomp_and

module ecomp_or
  (
   input a,
   input b,
   output c
   );

   assign #1 c = a | b;

endmodule // ecomp_or

module ecomp_xor
  (
   input a,
   input b,
   output c
   );

   assign #1 c = a ^ b;

endmodule // ecomp_xor

module ecomp_ha
  (
   input a,
   input b,
   output s,
   output c
   );
   
   assign #1 c = a & b;
   assign #1 s = a ^ b;

endmodule // ecomp_ha


module ecomp_fa
  (
   input  a,
   input  b,
   input ci,
   output s,
   output co
   );

   wire   g, p, cop;

   assign #1 g = a & b;
   assign #1 p = a ^ b;   
   assign #1 s = p ^ ci;
   assign #1 cop = p&ci;
   assign #1 co = cop | g;

endmodule // ecomp_ha

module ecomp_fa_tb;

   reg [3:0] cnt = 0;
   wire co, s;
   
   ecomp_fa fa0
     (
      .a(cnt[0]),
      .b(cnt[1]),
      .ci(cnt[2]),
      .s(s),
      .co(co)
      );

   always begin
      cnt = #10 cnt + 1;
      if(cnt == 8) $finish;
   end

   initial begin
      $dumpfile("ecomp.vcd");
      $dumpvars();
   end
     
endmodule


module ecomp_pmul
  #(
    parameter N=4
    )
  
  (
   input [N-1: 0]        M,
   input [N-1: 0]        m,
   output reg signed [2*N-1: 0] p //must be signed because pp (signed) is assigned to it
   );

   reg signed [2*N-1:0]    pp [N-1:0]; //must be signed so right arithmetic shift works

   //generate partial products   
   integer i, j;
   always @*
     for (i=0; i<N; i=i+1) begin
        pp[i] = 1'b0;
        for (j=0; j<N; j=j+1)
          pp[i][j] = m[i] & M[j]; //notice shifting unlike before
     end

   //add partial products
   integer k;
   always @* begin 
      p = 1'b0;
      for (k=0; k<(N-1); k=k+1) //all pps except last 
        p = p + ((pp[k]<<N)>>>(N-k)); //full left-shift followed by arithmetic right-shift by N-k
      p = p - ((pp[k]<<N)>>>(N-k)); //same thing, but subtract last pp
   end
   
endmodule

module ecomp_pmul_tb;

   localparam N=4;
   
   reg [2*N:0] cnt = 0;
   wire [2*N-1:0] p;
   
   ecomp_pmul 
     #(
       .N(N)
       ) mul0
     (
      .M(cnt[N-1:0]),
      .m(cnt[2*N-1:N]),
      .p(p)
      );

   always begin
      cnt = #10 cnt + 1;
      if(cnt == 2**(2*N)) $finish;
   end

   initial begin
      $dumpfile("ecomp.vcd");
      $dumpvars();
   end

endmodule

