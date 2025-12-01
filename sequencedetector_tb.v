`timescale 1ns/1ps
module suquencedetector_tb();
    reg x, clk, reset;
    wire y;

    sequencedetector dut(.clk(clk), .x(x), .reset(reset), .y(y));

    initial begin
        clk=0;
        forever #5 clk=~clk;
    end

    initial begin
        x=0;
        reset=1; #20;
        reset=0; #10;
        x=1; #10;
        x=0; #10;
        x=1; #10;
        x=0; #10;
        x=1; #10;
        x=0; #10;
        x=0; #10;
        x=1; #10;
        x=0; #10;
        x=1; #10;
        x=0; #10;
        x=1; #10;
        x=0; #10;
        x=1; #10;
        x=0; #10;
        x=1; #10;
        #20; $finish;
    end
endmodule