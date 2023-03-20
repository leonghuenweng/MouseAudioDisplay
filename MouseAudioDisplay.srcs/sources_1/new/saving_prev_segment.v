`timescale 1ns / 1ps

module saving_prev_segment(
    input clock25MHz,
    input [6:0] segment_output,
    output reg [6:0] segment_output_temp = 0
    );
    
    always @(posedge clock25MHz) begin
        segment_output_temp <= segment_output;
    end
endmodule
