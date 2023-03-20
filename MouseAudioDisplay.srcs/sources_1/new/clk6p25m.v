`timescale 1ns / 1ps

module clk6p25m(
    input basys3_clock,
    output reg SLOW_CLOCK = 0
    );
    
    reg [3:0] COUNT = 0;
    
    always @(posedge basys3_clock) begin
        COUNT <= (COUNT == 7)? 0 : COUNT + 1;
        SLOW_CLOCK <= (COUNT == 0)? ~SLOW_CLOCK : SLOW_CLOCK;
    end
    
endmodule
