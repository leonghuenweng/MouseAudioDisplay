`timescale 1ns / 1ps

module clk_20kHz(
    input CLOCK,
    output reg SLOW_CLOCK = 0
    );
    
    reg[12:0] COUNT = 0;
    
    always @(posedge CLOCK)begin
        COUNT <= (COUNT == 2499)? 0 : COUNT + 1;
        SLOW_CLOCK <= (COUNT == 0)? ~SLOW_CLOCK : SLOW_CLOCK;
    end
    
endmodule
