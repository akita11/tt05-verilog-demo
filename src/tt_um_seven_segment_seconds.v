`default_nettype none

module tt_um_seven_segment_seconds(
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
   assign uo_out = cnt[15:8];
   // use bidirectionals as outputs
   assign uio_oe = 8'b11111111;
   // put bottom 8 bits of second counter out on the bidirectional gpio
//   assign uio_out = cnt[7:0];
   
   // external clock is 10MHz, so need 24 bit counter
   reg [15:0]  cnt;

   always @(posedge clk) begin
      // if reset, set counter to 0
      if (reset) begin
         cnt <= 0;
      end else begin
         cnt <= cnt + 1;
      end
   end
   assign ui_in = {0, n[6:0]};
   assign uio_out[6:0] = ~n[6:0];
   buf (uio_out[7], n[7]);
endmodule
