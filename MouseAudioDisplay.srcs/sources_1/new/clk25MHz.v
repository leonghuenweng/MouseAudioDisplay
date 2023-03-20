`timescale 1ns / 1ps

module clk25MHz(
    input basys3_clock,
    output reg SLOW_CLOCK = 0
    );
    
    reg count = 0;
    
    always @(posedge basys3_clock)
    begin
        count <= (count == 1)? 0 : count + 1;
        SLOW_CLOCK <= (count == 0)? ~SLOW_CLOCK : SLOW_CLOCK;
    end
    
endmodule