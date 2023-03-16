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


module Top_Student (input clock,JC3,output JC4,JC1,output [8:0]led, [6:0] seg,[3:0] an);

wire twenty_KHz_signal;
clk_divider TWENTY_KHZ(.INCLOCK(clock),.OUTCLOCK(twenty_KHz_signal));

wire [11:0]sample_wire;
Audio_Input audio_in(.CLK(clock),.cs(twenty_KHz_signal),.MISO(JC3),.clk_samp(JC1),.sclk(JC4),.sample(sample_wire));

wire [11:0]volume_wire;
Audio_Sampling audio_sampler(.clock(clock),.audio_in(sample_wire),.output_vol(volume_wire));

volumeDecoder VD(.inputVol(volume_wire),.cat(seg),.an(an),.led(led));

endmodule