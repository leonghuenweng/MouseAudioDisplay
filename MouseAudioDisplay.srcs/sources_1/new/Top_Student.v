`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (input basys3_clock, 
                    input JC3,
                    output JC4,JC1,
                    
                    input [15:0] sw, 
                    
                    inout PS2Clk, //Mouse
                    inout PS2Data, //Mouse
                    
                    output [7:0] JB, //OLED
                    output [15:0] led, 
                    output [6:0]seg,
                    output [3:0] an
                    );

wire twenty_KHz_signal;
clk_divider TWENTY_KHZ(.INCLOCK(basys3_clock),.OUTCLOCK(twenty_KHz_signal));

wire [11:0]sample_wire;
Audio_Input audio_in(.CLK(basys3_clock),.cs(twenty_KHz_signal),.MISO(JC3),.clk_samp(JC1),.sclk(JC4),.sample(sample_wire));

wire [11:0]volume_wire;
Audio_Sampling audio_sampler(.clock(basys3_clock),.audio_in(sample_wire),.output_vol(volume_wire));

volumeDecoder VD(.inputVol(volume_wire),.cat(seg),.an(an),.led(led[8:0]));

wire clock_20kHz;
clk_20kHz clock20kHz_u (.CLOCK(basys3_clock), 
                         .SLOW_CLOCK(clock_20kHz));
                         
wire clock6p25MHz;
clk6p25m clk6p25m_u (   .basys3_clock(basys3_clock),
                        .SLOW_CLOCK(clock6p25MHz)
                        );
wire clock25MHz;
clk25MHz clk25MHz_u (   .basys3_clock(basys3_clock),
                        .SLOW_CLOCK(clock25MHz)
                        );                         

wire left_btn, right_btn, middle_btn;
wire [11:0] x_pos, y_pos;
MouseCtl MouseCtl_u (  .clk(basys3_clock), 
                        .ps2_clk(PS2Clk), 
                        .ps2_data(PS2Data), 
                        .rst(0), 
                        .value(0), 
                        .setx(0), 
                        .sety(0), 
                        .setmax_x(0),
                        .setmax_y(0),
                        .left(left_btn),
                        .right(right_btn),
                        .middle(middle_btn),
                        .xpos(x_pos),
                        .ypos(y_pos)
                        );
    
wire [15:0] pixel_data;  
wire [12:0] pixel_index;
wire frame_begin, sending_pixels, sample_pixel;
Oled_Display OledDisplay_u (    .clk(clock6p25MHz),
                                    .reset(0),
                                    .frame_begin(frame_begin),
                                    .sending_pixels(sending_pixels),
                                    .sample_pixel(sample_pixel),
                                    .pixel_index(pixel_index),
                                    .pixel_data(pixel_data),
                                    .cs(JB[0]),   
                                    .sdin(JB[1]),
                                    .sclk(JB[3]),
                                    .d_cn(JB[4]),
                                    .resn(JB[5]),
                                    .vccen(JB[6]),
                                    .pmoden(JB[7])                
                                    );                    

//Mouse Testing
MouseTesting MouseTesting_u (  .basys3_clock(basys3_clock),
                                .left_btn(left_btn),
                                .right_btn(right_btn),
                                .middle_btn(middle_btn),
                                .led(led[15:13])
                                );

//change cursor using middle button                                           
wire is_alternate_cursor;
change_cursor change_cursor_indicator(  .mouse_middle_button(middle_btn),
                                        .is_alternate_cursor(is_alternate_cursor)
                                        );


//check whether cursor is on segment a,b,c,d,e,f,g                                        
wire [7:0] x_mouse_oled, y_mouse_oled; //mouse cursor position on the OLED screen 
wire [6:0] is_on_segment;
check_cursor_on_segment check_cursor_on_segment_u (.clock25MHz(clock25MHz), 
                                                    .x_mouse_oled(x_mouse_oled), 
                                                    .y_mouse_oled(y_mouse_oled) , 
                                                    .is_on_segment(is_on_segment),
                                                    .led(led[6:0])
                                                     );
   
//use cursor to choose number        
wire[6:0] segment_output;      
wire[6:0] segment_output_temp;
saving_prev_segment saving_prev_segment_u (.clock25MHz(clock25MHz), .segment_output(segment_output), .segment_output_temp(segment_output_temp));

choose_segment choose_segment_u ( .right_btn(right_btn),
                                   .left_btn(left_btn),
                                   .x_mouse_oled(x_mouse_oled),
                                   .y_mouse_oled(y_mouse_oled),
                                   .segment_output(segment_output), 
                                   .is_on_segment(is_on_segment),
                                   .segment_output_temp(segment_output_temp)
                                   );    

//use switch to choose border
wire border_output;         
choose_border choose_border_u (.clock25MHz(clock25MHz), .sw(sw), .border_output(border_output));

//template of the number segments
wire [15:0] display_pixel_data;
Oled_segment_print Oled_segment_print_u (   .clock25MHz(clock25MHz), 
                                            .my_pixel_index(pixel_index), 
                                            .border_output(border_output), 
                                            .display_pixel_data(display_pixel_data),
                                            .segments(segment_output)
                                            );    

//determine what to display on OLED screen
wire [15:0] pixel_data_wire;
draw_on_OLED draw_on_OLED_u (   .clock25MHz(clock25MHz),

                                .pixel_index(pixel_index),
                                .x_mouse(x_pos),
                                .y_mouse(y_pos),
                                
                                .is_alternate_cursor(is_alternate_cursor),
                                .x_mouse_oled(x_mouse_oled),
                                .y_mouse_oled(y_mouse_oled),
                                
                                .display_pixel_data(display_pixel_data),
                                .pixel_data_wire(pixel_data_wire)
                                );
                                                                   
//display onto OLED screen                                    
Oled_control Oled_control_u (   .clock25MHz(clock25MHz), 
                                .pixel_data_wire(pixel_data_wire),    
                                .pixel_data(pixel_data));
                            

endmodule