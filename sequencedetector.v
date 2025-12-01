module sequencedetector(input x, clk, reset, output reg y);

    parameter s0=3'b000, s1=3'b001, s2=3'b010, s3=3'b011, s4=3'b100, s5=3'b101;
    reg [2:0] state, nextstate;

    always @(posedge clk) begin
        if(reset) begin
            state<=s0;
            y<=0;
        end
        else begin
            state<=nextstate;
            if(nextstate==s5) y<=1;
            else y<=0;
        end
    end
    always @(*)begin
        case(state)
            s0: begin
                if(x) nextstate<=s1;
                else nextstate<=s0;
            end
            s1: begin
                if(x) nextstate<=s1;
                else nextstate<=s2;
            end
            s2: begin
                if(x) nextstate<=s3;
                else nextstate<=s0;
            end
            s3: begin
                if(x) nextstate<=s1;
                else nextstate<=s4;
            end
            s4: begin
                if(x) nextstate<=s5;
                else nextstate<=s0;
            end
            s5: begin
                if(x) nextstate<=s1;
                else nextstate<=s4;
            end
        endcase
    end
endmodule