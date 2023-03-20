`timescale 1ns / 1ps

module change_cursor(
    input mouse_middle_button,
    output reg is_alternate_cursor = 0
    );
    
    always @(posedge mouse_middle_button)
    begin
        is_alternate_cursor <= ~is_alternate_cursor;
    end
    
endmodule
