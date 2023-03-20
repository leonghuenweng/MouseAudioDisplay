`timescale 1ns / 1ps

module choose_segment (
    input right_btn,
    input left_btn,
    input [7:0] x_mouse_oled,
    input [7:0] y_mouse_oled,
    input [6:0] is_on_segment,
    input [6:0] segment_output_temp,
    output reg [6:0] segment_output = 7'b0000000
    );
    
    always @ (posedge left_btn, posedge right_btn)
    begin
        if(left_btn)begin
            segment_output[0] <= (is_on_segment[0] == 1)? 1 : segment_output_temp[0];
            segment_output[1] <= (is_on_segment[1] == 1)? 1 : segment_output_temp[1];
            segment_output[2] <= (is_on_segment[2] == 1)? 1 : segment_output_temp[2];
            segment_output[3] <= (is_on_segment[3] == 1)? 1 : segment_output_temp[3];
            segment_output[4] <= (is_on_segment[4] == 1)? 1 : segment_output_temp[4];
            segment_output[5] <= (is_on_segment[5] == 1)? 1 : segment_output_temp[5];
            segment_output[6] <= (is_on_segment[6] == 1)? 1 : segment_output_temp[6];
            
        end
        else begin
            segment_output[0] <= (is_on_segment[0] == 1)? 0 : segment_output_temp[0];
            segment_output[1] <= (is_on_segment[1] == 1)? 0 : segment_output_temp[1];
            segment_output[2] <= (is_on_segment[2] == 1)? 0 : segment_output_temp[2];
            segment_output[3] <= (is_on_segment[3] == 1)? 0 : segment_output_temp[3];
            segment_output[4] <= (is_on_segment[4] == 1)? 0 : segment_output_temp[4];
            segment_output[5] <= (is_on_segment[5] == 1)? 0 : segment_output_temp[5];
            segment_output[6] <= (is_on_segment[6] == 1)? 0 : segment_output_temp[6];
        end
    end     
    
endmodule     

/*
parameter segments_0 = 7'b0111111;
parameter segments_1 = 7'b0000110;
parameter segments_2 = 7'b1011011;
parameter segments_3 = 7'b1001111;
parameter segments_4 = 7'b1100110;
parameter segments_5 = 7'b1101101;
parameter segments_6 = 7'b1111101;
parameter segments_7 = 7'b0000111;
parameter segments_8 = 7'b1111111;
parameter segments_9 = 7'b1101111;
     
//display number 0 when switch 0 is on
if (sw[0] == 1) 
begin
    segment_output <= segments_0;
end


//display number 1 when switch 1 is on
else if (sw[1] == 1) 
begin
    segment_output <= segments_1;
end


//display number 2 when switch 2 is on
else if (sw[2] == 1)
begin
    segment_output <= segments_2;
end

//display number 3 when switch 3 is on
else if (sw[3] == 1)
begin
    segment_output <= segments_3;
end

//display number 4 when switch 4 is on
else if (sw[4] == 1)
begin
    segment_output <= segments_4;
end

else if (sw[5] == 1)
begin
    segment_output <= segments_5;
end

else if (sw[6] == 1)
begin
    segment_output <= segments_6;
end

else if (sw[7] == 1)
begin 
    segment_output <= segments_7;
end

else if (sw[8] == 1)
begin
    segment_output <= segments_8;
end

else if (sw[9] == 1)
begin
    segment_output <= segments_9;
end
 
else
begin
    segment_output <= 0;
end
*/