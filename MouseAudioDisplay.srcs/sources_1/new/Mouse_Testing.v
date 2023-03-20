`timescale 1ns / 1ps

module MouseTesting(
    input basys3_clock,
    input left_btn,
    input right_btn,
    input middle_btn,
    output reg [2:0] led
    );

    always @(posedge basys3_clock) begin
        led <= {left_btn, middle_btn, right_btn};
    end
    
endmodule
