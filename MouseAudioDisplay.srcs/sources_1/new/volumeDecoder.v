`timescale 1ns / 1ps

module volumeDecoder(input [11:0] inputVol,output reg[6:0] cat,reg[3:0] an=4'b1110,reg[8:0] led);
always@(inputVol)
begin
if(inputVol<2048)
    begin
        led<=0;
        cat<=7'b1000000;//0
    end
else if(2048<=inputVol && inputVol<2275)
    begin
        led<= 9'b000000001;
        cat<= 7'b1001111;//1
    end
else if (2275<=inputVol && inputVol<2503)
    begin
        led<= 9'b000000011;
        cat<=7'b0100100;//2
    end
else if (2503<=inputVol && inputVol<2730)
    begin
        led<= 9'b000000111;
        cat<=7'b0110000;//3
    end
else if (2730<=inputVol && inputVol<2958)
    begin
        led<= 9'b000001111;
        cat<= 7'b0011001;//4
    end
else if (2958<=inputVol && inputVol<3185)
    begin
        led<=9'b000011111;
        cat<= 7'b0010010;//5
    end
else if (3185<=inputVol && inputVol<3413)
    begin
        led<=9'b000111111;
        cat<=7'b0100000;//6
    end
else if (3413<=inputVol && inputVol<3640)
    begin
        led<=9'b001111111;
        cat<=7'b1111000;//7
    end
else if(3640<=inputVol && inputVol<3868)
    begin
        led<=9'b011111111;
        cat<=7'b0000000;//8
    end
else if (3868<=inputVol && inputVol<4095)
    begin
        led<=9'b111111111;
        cat<=7'b0010000;//9
    end
end
endmodule
