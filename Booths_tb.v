
`timescale 1ns/1ps
module Booths_tb;
	reg[7:0]A,B;
	reg clk,start,reset;
	wire done;
	wire[15:0]M;

	Booths dut(
		.A(A),
		.B(B),
		.clk(clk),
		.start(start),
		.reset(reset),
		.done(done),
		.M(M)
	);

	initial clk=0;
	always #5 clk=~clk;

	initial begin
		reset=1;
		start=0;
		A=0;
		B=0;
		#20 reset=0;

		#10 A=8'd7;B=8'd3;start=1;
		#10 start=0;
		# 200;

		#10 A=8'd12;B=8'd5;start=1;
		#10 start=0;
		# 200;

		#10 A=8'd25;B=8'd10;start=1;
		#10 start=0;
		# 200;

		#10 A=8'd100;B=8'd200;start=1;
		#10 start=0;
		# 300;

		$finish;
	end
endmodule