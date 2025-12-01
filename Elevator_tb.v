`timescale 1ns/1ps
module Elevator_tb;
reg [3:0] intreq, extreq;
reg clk, stop, reset;
wire [3:0] open;

Elevator dut(
    .intreq(intreq),
    .extreq(extreq),
    .clk(clk),
    .stop(stop),
    .reset(reset),
    .open(open)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    reset = 1;
    stop  = 0;
    intreq = 4'b0000;
    extreq = 4'b0000;

    #12 reset = 0;

    #10 intreq = 4'b1000;
    #40 intreq = 4'b0000;

    #10 extreq = 4'b0010;
    #30 extreq = 4'b0000;

    #10 intreq = 4'b0100;
    #20 stop = 1;
    #10 stop = 0;

    #20 intreq = 4'b0001;
    #10 extreq = 4'b1000;
    #50 intreq = 4'b0000;
    #50 extreq = 4'b0000;
end

endmodule
