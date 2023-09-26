`default_nettype none

module tt_um_blink(
				   input wire [7:0]  ui_in, // Dedicated inputs
				   output wire [7:0] uo_out, // Dedicated outputs
				   input wire [7:0]  uio_in, // IOs: Bidirectional Input path
				   output wire [7:0] uio_out, // IOs: Bidirectional Output path
				   output wire [7:0] uio_oe, // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
				   input wire 	     ena, // will go high when the design is enabled
				   input wire 	     clk, // clock
				   input wire 	     rst_n     // reset_n - low to reset
);

   wire 					     reset = ! rst_n;
   wire [7:0] 					     n;
   reg [15:0]  cnt;

   assign uo_out = cnt[15:8];
   assign uio_oe = 8'b11111111;    // use bidirectionals as outputs

   always @(posedge clk) begin
      if (reset) begin
         cnt <= 0;
      end else begin
         cnt <= cnt + 1;
      end
   end
   assign n[7:0] = ui_in[7:0];
   assign uio_out[7:0] = ~n[7:0];
endmodule
