`timescale 1ns / 1ps

module computer_mouse_cursor(
    input middle_btn,
    input clock25MHz,
    input [12:0] pixel_index,
    input [11:0] x_mouse, 
    input [11:0] y_mouse,
    input is_alternate_cursor,
    input [15:0] background_pixel_data,
    output [7:0] x_mouse_decrease,
    output [7:0] y_mouse_decrease,
    output reg [15:0] pixel_data = 16'b0000_0000_0000_0000
    );   
    
    
        parameter red = 16'b11111_000000_00000;
        parameter green = 16'b00000_111111_00000;
        parameter blue = 16'b00000_000000_11111;
        parameter black = 16'b00000_000000_00000;
        parameter white = 16'b11111_111111_11111;
        
        parameter border_inner = 58;
        parameter border_outer = 60;
        
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
    
    wire [7:0] x, y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    wire [11:0] x_mouse_copy, y_mouse_copy;
    assign x_mouse_copy = x_mouse / 10;
    assign y_mouse_copy = y_mouse / 10;
    
    assign x_mouse_decrease = (x_mouse_copy > 94 && !is_alternate_cursor)? 94 
                                    : (x_mouse_copy > 90 && is_alternate_cursor)? 90 
                                        : x_mouse_copy[7:0];                          
    assign y_mouse_decrease = (y_mouse_copy > 62 && !is_alternate_cursor)? 62 
                                    : (y_mouse_copy > 57 && is_alternate_cursor)? 57
                                        : y_mouse_copy[7:0];
  
  
  
    always @(posedge clock25MHz)
    begin
        if(!is_alternate_cursor) begin
        
            if( x >= x_mouse_decrease && x <=x_mouse_decrease+1 && y >= y_mouse_decrease && y <= y_mouse_decrease+1 ) begin
                pixel_data <= red;  
            end
            else begin
                pixel_data <= background_pixel_data;
            end
        end
        
        else begin
            if(x >= x_mouse_decrease && x <=x_mouse_decrease+4 && y >= y_mouse_decrease && y <= y_mouse_decrease+4 ) begin
                pixel_data <= blue;  
            end
        
            else begin
                pixel_data <= background_pixel_data;
            end
        end
    end
   
endmodule