module Booths(
	input [7:0] A,
	input [7:0] B,
	input clk,
	input start,
	input reset,
	output reg done,
	output reg [15:0] M
);

	reg signed [16:0] shiftreg;
	reg signed [16:0] shiftreg_next;
	reg signed [16:0] temp;

	reg [7:0] multiplicand;
	reg [7:0] multiplicand_next;
	reg [7:0] negmultiplicand;
	reg [7:0] negmultiplicand_next;

	parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10;

	reg [1:0] state;
	reg [1:0] state_next;
	reg [3:0] count;
	reg [3:0] count_next;
	reg [15:0] preM;
	reg [15:0] preM_next;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shiftreg <= 17'd0;
			multiplicand <= 8'd0;
			negmultiplicand <= 8'd0;
			state <= s0;
			count <= 4'd0;
			M <= 16'd0;
			preM <= 16'd0;
			done <= 1'b0;
		end else begin
			shiftreg <= shiftreg_next;
			multiplicand <= multiplicand_next;
			negmultiplicand <= negmultiplicand_next;
			state <= state_next;
			count <= count_next;
			M <= preM_next;
			preM <= preM_next;
			done <= (state_next == s2);
		end
	end

	always @(*) begin
		shiftreg_next = shiftreg;
		multiplicand_next = multiplicand;
		negmultiplicand_next = negmultiplicand;
		state_next = state;
		count_next = count;
		preM_next = M;
		temp = shiftreg;

		case (state)
			s0: begin
				shiftreg_next[8:1] = B;
				shiftreg_next[16:9] = 8'd0;
				shiftreg_next[0] = 1'b0;
				multiplicand_next = A;
				negmultiplicand_next = (~A) + 8'd1;
				count_next = 4'd0;
				if (start)
					state_next = s1;
			end

			s1: begin
				if (count == 4'd8) begin
					preM_next = shiftreg[16:1];
					state_next = s2;
				end else begin
					case (shiftreg[1:0])
						2'b01: temp[16:9] = shiftreg[16:9] + multiplicand;
						2'b10: temp[16:9] = shiftreg[16:9] + negmultiplicand;
						default: temp = shiftreg;
					endcase
					shiftreg_next = temp >>> 1;
					count_next = count + 4'd1;
				end
			end

			s2: begin
				if (!start)
					state_next = s0;
			end
		endcase
	end
endmodule
