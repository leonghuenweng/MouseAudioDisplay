`timescale 1ns / 1ps

module Audio_Sampling(input clock, [11:0] audio_in,output reg [11:0]output_vol);
    reg [31:0]clock_counter=0;    
    reg [11:0] peak_volume = 0;
    
    always@(posedge clock)
    begin
    clock_counter=(clock_counter>=4999999)?0:clock_counter+1; //4 Hz ,0.5 sec from 0-9999
    if(clock_counter>0)
        peak_volume<=(audio_in>peak_volume)?audio_in:peak_volume;
    if(clock_counter==0)
    begin
        output_vol<=peak_volume;
        peak_volume<=0;
    end
    end 
endmodule
