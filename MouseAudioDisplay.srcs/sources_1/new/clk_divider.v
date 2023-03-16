`timescale 1ns / 1ps
module clk_divider(input INCLOCK,output reg OUTCLOCK=0);
reg [31:0]counter_20kHz =0;
reg output_20Khz= 0;
always@(posedge INCLOCK)
begin
    counter_20kHz<=(counter_20kHz>=2499)?0:counter_20kHz+1;
    output_20Khz<=(counter_20kHz==0)?~output_20Khz:output_20Khz;
end



always @(posedge INCLOCK)
begin
    OUTCLOCK=output_20Khz;
end
endmodule
