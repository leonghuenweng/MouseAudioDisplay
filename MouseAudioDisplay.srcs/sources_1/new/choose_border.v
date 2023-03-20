`timescale 1ns / 1ps

module choose_border(
    input clock25MHz,
    input [15:0] sw,
    output reg border_output = 0
    );
    always @(posedge clock25MHz) begin
        //green border when switch 14 is on    
        border_output <= sw[14];
    end
    
endmodule
