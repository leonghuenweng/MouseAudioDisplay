`timescale 1ns / 1ps

module Oled_segment_print(
    input clock25MHz,
    input [12:0] my_pixel_index, 
    input [6:0] segments,
    input border_output,
    output reg [15:0] display_pixel_data
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
    
    wire [7:0] x_cd;
    wire [7:0] y_cd;
    
    assign x_cd = my_pixel_index % 96;
    assign y_cd = my_pixel_index / 96;
    
    always @(posedge clock25MHz)
    begin
        //7 seg outline
        if ((x_cd >= segA_left && x_cd <= segA_right && y_cd == segA_top) || //first horizontal line
        (x_cd >= segA_left && x_cd <= segA_right && y_cd == segA_bottom) || //second horizontal line
        (x_cd >= segG_left && x_cd <= segG_right && y_cd == segG_top) || //third horizontal line
        (x_cd >= segG_left && x_cd <= segG_right && y_cd == segG_bottom) || //fourth horizontal line
        (x_cd >= segD_left && x_cd <= segD_right && y_cd == segD_top) || //fifth horizontal line
        (x_cd >= segD_left && x_cd <= segD_right && y_cd == segD_bottom) || //sixth horizontal line
        (x_cd == segF_left && y_cd >= segF_top && y_cd <= segE_bottom) || //first vertical line
        (x_cd == segF_right && y_cd >= segF_top && y_cd <= segE_bottom) || //second vertical line
        (x_cd == segB_left && y_cd >= segB_top && y_cd <= segC_bottom) || //third vertical line
        (x_cd == segB_right && y_cd >= segB_top && y_cd <= segC_bottom)) // fourth vertical line
        begin
            display_pixel_data <= white;
        end
        
        else begin
            display_pixel_data <= black;
        end
    
        //green border when switch 4 is on
        if (border_output == 1) begin            
            if ((x_cd >= border_inner && x_cd <= border_outer && y_cd <= border_outer) || //vertical border
            (x_cd <= border_outer && y_cd >= border_inner && y_cd <= border_outer)) //horizontal border
            begin
                display_pixel_data <= green;
            end
        end

        //segment A
        if (segments[0] == 1) begin
            if (x_cd >= segA_left && x_cd <= segA_right && y_cd >= segA_top && y_cd <= segA_bottom)
            begin
                display_pixel_data <= white;
            end
        end
        
        //segment B
        if (segments[1] == 1) begin
            if (x_cd >= segB_left && x_cd <= segB_right && y_cd >= segB_top && y_cd <= segB_bottom)
            begin
                display_pixel_data <= white;
            end     
        end
        
        //segment C
        if (segments[2] == 1) begin
            if (x_cd >= segC_left && x_cd <= segC_right && y_cd >= segC_top && y_cd <= segC_bottom)
            begin
                display_pixel_data <= white;
            end
        end
        
        //segment D
        if (segments[3] == 1) begin
            if (x_cd >= segD_left && x_cd <= segD_right && y_cd >= segD_top && y_cd <= segD_bottom)
            begin
                display_pixel_data <= white;
            end
        end

        //segment E
        if (segments[4] == 1) begin
            if (x_cd >= segE_left && x_cd <= segE_right && y_cd >= segE_top && y_cd <= segE_bottom)
            begin
                display_pixel_data <= white;
            end
        end
        
        //segment F                       
        if (segments[5] == 1) begin
            if (x_cd >= segF_left && x_cd <= segF_right && y_cd >= segF_top && y_cd <= segF_bottom)
            begin
                display_pixel_data <= white;
            end
        end

        //segment G
        if (segments[6] == 1) begin
            if (x_cd >= segG_left && x_cd <= segG_right && y_cd >= segG_top && y_cd <= segG_bottom)
            begin
                display_pixel_data <= white;
            end
        end
        
    end
    
endmodule