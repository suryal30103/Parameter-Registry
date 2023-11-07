`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2023 13:57:30
// Design Name: 
// Module Name: PARAM_BLOCK_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PARAM_BLOCK_TB;
    reg param_id,clk,reset;
    reg [7:0] data;
    wire [10:0] mask_param,code_param;
    wire [1:0]sjw;
    
    
    
    PARAM_BLOCK u0 (.param_id(param_id),.clk(clk),.reset(reset),.data(data),.mask_param(mask_param),.code_param(code_param),.sjw(sjw));
    
    
    initial begin
        clk=0;
        forever #5 clk=~clk;
    end
    initial begin
        reset=1;
        param_id=1;
        data=8'b11110000;
        #20 reset=0;
        #100 param_id=0;
        #100 param_id=1;
        data=8'b10101010;
        #150 param_id=0;
        #150 param_id=1;
        data=8'b00001111;
        #100 param_id=0;
        #100 param_id=1;
        data=8'b00100100;
        #80 reset=1;   
        #50 reset =0;
        data =8'b01010101;
        #100 param_id=0;
        #80 param_id=1;
        
           
        
        
    end
    
        
               


endmodule
