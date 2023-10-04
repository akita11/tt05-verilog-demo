`default_nettype none
`timescale 1ns/1ps

/*
this testbench just instantiates the module and makes some convenient wires
that can be driven / tested by the cocotb test.py
*/

// testbench is controlled by test.py
module tb ;

    // wire up the inputs and outputs
    reg  clk;
    reg  rst_n;
    reg  ena;
    reg  [7:0] ui_in;
    reg  [7:0] uio_in;

    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    tt_um_blink tt_um_blink (
    // include power ports for the Gate Level test
    `ifdef GL_TEST
        .VPWR( 1'b1),
        .VGND( 1'b0),
    `endif
        .ui_in      (ui_in),    // Dedicated inputs
        .uo_out     (uo_out),   // Dedicated outputs
        .uio_in     (uio_in),   // IOs: Input path
        .uio_out    (uio_out),  // IOs: Output path
        .uio_oe     (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
        .ena        (ena),      // enable - goes high when design is selected
        .clk        (clk),      // clock
        .rst_n      (rst_n)     // not reset
        );

   initial begin
      #0 clk = 0; rst_n = 1; ena = 1; ui_in = 1;
      #20 rst_n = 0;
      #20 rst_n = 1;
      #100
      $finish;
   end
   
   always #5 clk = ~clk;
   always #10 ui_in = ui_in * 2;
   
    // this part dumps the trace to a vcd file that can be viewed with GTKWave
    initial
      $monitor($stime, "c=%b r=%b / in=%b out=%b / Q=%b", clk, rst_n, ui_in, uio_out, uo_out);
//        $dumpfile ("tb.vcd");
//        $dumpvars (0, tb);
//        #1;
   
endmodule
