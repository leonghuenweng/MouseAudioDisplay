`timescale 1ns / 1ps

module check_cursor_on_segment(
    input clock25MHz,
    input [7:0] x_mouse_oled,
    input [7:0] y_mouse_oled,
    output reg [6:0] is_on_segment = 0,
    output reg [6:0] led = 0
    );
    
       parameter segA_top = 5;
       parameter segA_bottom = 11;
       parameter segA_left = 12;
       parameter segA_right = 46;
       
       parameter segB_top = 5;
       parameter segB_bottom = 32;
       parameter segB_left = 40;
       parameter segB_right = 46;
       
       parameter segC_top = 26;   
       parameter segC_bottom = 53;
       parameter segC_left = 40; 
       parameter segC_right = 46;
       
       parameter segD_top = 47;   
       parameter segD_bottom = 53;
       parameter segD_left = 12; 
       parameter segD_right = 46;
       
       parameter segE_top = 26;   
       parameter segE_bottom = 53;
       parameter segE_left = 12; 
       parameter segE_right = 18;
       
       parameter segF_top = 5;   
       parameter segF_bottom = 32;
       parameter segF_left = 12; 
       parameter segF_right = 18;
       
       parameter segG_top = 26;   
       parameter segG_bottom = 32;
       parameter segG_left = 12; 
       parameter segG_right = 46;
   
        always @(posedge clock25MHz) begin
            is_on_segment[0] = (x_mouse_oled >= segA_left && x_mouse_oled <= segA_right && y_mouse_oled >= segA_top && y_mouse_oled <= segA_bottom)? 1 : 0;
            is_on_segment[1] = (x_mouse_oled >= segB_left && x_mouse_oled <= segB_right && y_mouse_oled >= segB_top && y_mouse_oled <= segB_bottom)? 1 : 0;
            is_on_segment[2] = (x_mouse_oled >= segC_left && x_mouse_oled <= segC_right && y_mouse_oled >= segC_top && y_mouse_oled <= segC_bottom)? 1 : 0;
            is_on_segment[3] = (x_mouse_oled >= segD_left && x_mouse_oled <= segD_right && y_mouse_oled >= segD_top && y_mouse_oled <= segD_bottom)? 1 : 0;
            is_on_segment[4] = (x_mouse_oled >= segE_left && x_mouse_oled <= segE_right && y_mouse_oled >= segE_top && y_mouse_oled <= segE_bottom)? 1 : 0;
            is_on_segment[5] = (x_mouse_oled >= segF_left && x_mouse_oled <= segF_right && y_mouse_oled >= segF_top && y_mouse_oled <= segF_bottom)? 1 : 0;
            is_on_segment[6] = (x_mouse_oled >= segG_left && x_mouse_oled <= segG_right && y_mouse_oled >= segG_top && y_mouse_oled <= segG_bottom)? 1 : 0;
            
            led[0] = is_on_segment[0];
            led[1] = is_on_segment[1];
            led[2] = is_on_segment[2];
            led[3] = is_on_segment[3];
            led[4] = is_on_segment[4];
            led[5] = is_on_segment[5];
            led[6] = is_on_segment[6];
        end
    
endmodule
