`timescale 1ns / 1ps

module Oled_control (
    input clock25MHz,
    input [15:0] pixel_data_wire,
    output reg [15:0] pixel_data
    );
    
    always @(posedge clock25MHz) begin
        pixel_data <= pixel_data_wire;
    end

endmodule
