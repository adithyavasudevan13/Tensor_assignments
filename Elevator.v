module Elevator(input [3:0] intreq, extreq, input clk, stop, reset, output reg [3:0] open);
    
    parameter s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
    reg direction;  // direction=1 means up, direction=0 means down
    reg [1:0] floor, nextfloor;
    
    always @(posedge clk or posedge reset or posedge stop) begin
        if(reset) begin
            floor<=s0;
            open<=4'b0001;
            direction<=1;
        end
        else if(stop==1) begin 
        case(floor)
        s0: open<=4'b0001;
        s1: open<=4'b0010;
        s2: open<=4'b0100;
        s3: open<=4'b1000;
        endcase 
        end
        else begin
            if(intreq==0 && extreq==0) open<=4'b0000; 

            if(floor>nextfloor) direction<=0;
            else if(floor<nextfloor) direction<=1;
            else if(nextfloor==s0) direction<=1;
            else if(nextfloor==s3) direction<=0;

            else begin
                floor<=nextfloor;
                case(nextfloor)
                s0: open<=4'b0001; 
                s1: open<=4'b0010; 
                s2: open<=4'b0100; 
                s3: open<=4'b1000; 
                endcase
            end
        end
    end

    always @(*)begin
        nextfloor=floor;
        if(direction) begin
            case(floor)
                s0: begin
                    if(extreq[0]) begin
                        nextfloor=s0;
                    end
                    else if(intreq[1] || extreq[1]) begin
                        nextfloor=s1;
                    end
                    else if(intreq[2] || extreq[2]) begin
                        nextfloor=s2;
                    end
                    else if(intreq[3] || extreq[3]) begin
                        nextfloor=s3;
                    end
                    else if(intreq[0]) begin
                        nextfloor=s0;
                    end
                end
                s1: begin
                    if(extreq[1]) begin
                        nextfloor=s1;
                    end
                    else if(intreq[2] || extreq[2]) begin
                        nextfloor=s2;
                    end
                    else if(intreq[3] || extreq[3]) begin
                        nextfloor=s3;
                    end
                    else if(intreq[1]) begin
                        nextfloor=s1;
                    end
                    else if(intreq[0] || extreq[0]) begin
                        nextfloor=s0;
                    end
                end
                s2: begin
                    if(extreq[2]) begin
                        nextfloor=s2;
                    end
                    else if(intreq[3] || extreq[3]) begin
                        nextfloor=s3;
                    end
                    else if(intreq[2]) begin
                        nextfloor=s2;
                    end
                    else if(intreq[1] || extreq[1]) begin
                        nextfloor=s1;
                    end
                    else if(intreq[0] || extreq[0]) begin
                        nextfloor=s0;
                    end
                end
                default: nextfloor=s0;
            endcase
        end

        else begin
            case(floor)
                s1: begin
                    if(extreq[1]) begin
                        nextfloor=s1;
                    end
                    else if(intreq[0] || extreq[0]) begin
                        nextfloor=s0;
                    end
                    else if(intreq[1]) begin
                        nextfloor=s1;
                    end
                    else if(intreq[3] || extreq[3]) begin
                        nextfloor=s3;
                    end
                    else if(intreq[2] || extreq[2]) begin
                        nextfloor=s2;
                    end
                end
                s2: begin
                    if(extreq[2]) begin
                        nextfloor=s2;
                    end
                    else if(intreq[1] || extreq[1]) begin
                        nextfloor=s1;
                    end
                    else if(intreq[0] || extreq[0]) begin
                        nextfloor=s0;
                    end
                    else if(intreq[2]) begin
                        nextfloor=s2;
                    end
                    else if(intreq[3] || extreq[3]) begin
                        nextfloor=s3;
                    end
                end
                s3: begin
                    if(extreq[3]) begin
                        nextfloor=s3;
                    end
                    else if(intreq[3]) begin
                        nextfloor=s3;
                    end
                    else if(intreq[2] || extreq[2]) begin
                        nextfloor=s2;
                    end
                    else if(intreq[1] || extreq[1]) begin
                        nextfloor=s1;
                    end
                    else if(intreq[0] || extreq[0]) begin
                        nextfloor=s0;
                    end
                end
                default: nextfloor=s0;
            endcase
        end
    end
endmodule