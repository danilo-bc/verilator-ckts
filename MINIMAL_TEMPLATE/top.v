// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2003 by Wilson Snyder.
// ======================================================================

// This is intended to be a complex example of several features, please also
// see the simpler examples/hello_world_c.

module top
  (
   // Declare some signals so we can see how I/O works
   input         A,
   input         B,
   input test_clock,
   input reset_l,

   output S   
  );

   and_custom U1(// Inputs
                 .A(A),
                 .B(B),
                 .S(S)
                 );

   // This part controls $finish used in cpp simulation
   // There should be workarounds to using this code snippet
   // e.g. for loop instead of while loop in sim_main.cpp
   reg [3:0] clk_count;
   always_ff @ (posedge test_clock or negedge reset_l) begin
      if (!reset_l) begin
         clk_count <= 4'h0;
      end
      else begin
         clk_count <= clk_count + 4'b1;
         if (clk_count >= 15) begin
            $display("[%0t] Process ended in %d clocks\n",
                     $time, clk_count);
            $write("*-* All Finished *-*\n");
            $finish;
         end
      end
   end
   
   initial begin
      $display("[%0t] Model running...\n", $time);
   end

endmodule
