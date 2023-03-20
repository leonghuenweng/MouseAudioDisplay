`timescale 1ns / 1ps
                
module draw_on_OLED(
    input clock25MHz,
    input [12:0] pixel_index,
    input [11:0] x_mouse, 
    input [11:0] y_mouse,
    
    input is_alternate_cursor,
    
    input [15:0] display_pixel_data,
    
    output [7:0] x_mouse_oled,
    output [7:0] y_mouse_oled,
 
    output reg [15:0] pixel_data_wire = 16'b0000_0000_0000_0000
    );   
    
    
    parameter red = 16'b11111_000000_00000;
    parameter blue = 16'b00000_000000_11111;    
    
    wire [7:0] x, y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
    wire [11:0] x_mouse_copy, y_mouse_copy;
    assign x_mouse_copy = x_mouse / 10;
    assign y_mouse_copy = y_mouse / 10;
    
    assign x_mouse_oled = (x_mouse_copy > 94 && !is_alternate_cursor)? 94 
                                    : (x_mouse_copy > 90 && is_alternate_cursor)? 90 
                                        : x_mouse_copy[7:0];                          
    assign y_mouse_oled = (y_mouse_copy > 62 && !is_alternate_cursor)? 62 
                                    : (y_mouse_copy > 57 && is_alternate_cursor)? 57
                                        : y_mouse_copy[7:0];
  
    always @(posedge clock25MHz)
    begin
        if(!is_alternate_cursor) begin
        
            if( x >= x_mouse_oled && x <=x_mouse_oled+1 && y >= y_mouse_oled && y <= y_mouse_oled+1 ) begin
                pixel_data_wire <= red;  
            end
            else begin
                pixel_data_wire <= display_pixel_data;
            end
        end
        
        else begin
            if(x >= x_mouse_oled && x <=x_mouse_oled+4 && y >= y_mouse_oled && y <= y_mouse_oled+4 ) begin
                pixel_data_wire <= blue;  
            end
        
            else begin
                pixel_data_wire <= display_pixel_data;
            end
        end
    end
   
endmodule