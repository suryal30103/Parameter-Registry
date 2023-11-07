`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2023 12:39:02
// Design Name: 
// Module Name: PARAM_BLOCK
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


module PARAM_BLOCK(input reg param_id,clk,reset, input reg [7:0]data, output reg [10:0]mask_param,code_param, output reg [1:0]sjw );
    localparam [2:0]
        idle=3'b000,
        prmtr_0=3'b001,
        prmtr_1=3'b010,
        prmtr_2=3'b011,
        prmtr_id_comp=3'b100;
        
        reg [1:0] state_reg,state_next;
        reg [10:0] mask_param_1,code_param_1;
        reg [1:0] sjw_1;
        reg [7:0] data_reg;
        reg [7:0] data_reg_in;
       // assign data_reg=data;
        always@(posedge clk, posedge reset)
                  if (reset)
                      begin
                         state_reg<=idle;
                         mask_param_1<= 11'b00000000000;
                         code_param_1<= 11'b00000000000;
                         sjw_1<=2'b00;
                      end
                  else if(~reset)
                      begin
                          state_reg<=state_next;
                          data_reg_in[7:0]=data[7:0];
                      end
               always@(posedge clk, posedge reset)
                  if (reset)
                       begin
                           state_reg<=idle;
                           mask_param<= 11'b00000000000;
                           code_param<= 11'b00000000000;
                           sjw<=2'b00;
                       end
                  else if(~reset)
                      begin
                          state_reg<=state_next;
                          data_reg[7:0] <=data_reg_in[7:0];
                      end 

                
        
        always@*
        begin
            
            state_reg=state_next;
            case (state_reg)
                        idle:
                            begin
                                mask_param<= 11'b00000000000;
                                code_param<= 11'b00000000000;
                                sjw<=2'b00;
                                if (param_id)
                                    state_next=prmtr_0;
                            end     
                        prmtr_0:
                            begin
                                
                                 mask_param_1={3'b000,data_reg[7:0]};
                                 code_param_1 = code_param;
                                 sjw_1=sjw;
                                 state_next=prmtr_1;
                             end
                        prmtr_1:
                            begin
                                mask_param_1={data_reg[2:0],mask_param_1[7:0]};
                                code_param_1={6'b000000,data_reg[7:3]};
                                sjw_1=sjw;
                                state_next=prmtr_2; 
                                
                            end
                        prmtr_2:
                            begin
                                code_param_1[10:5]=data_reg[5:0];
                                sjw_1[1:0]=data_reg[7:6];
                                mask_param_1=mask_param_1;   
                                state_next=prmtr_id_comp; 
                            end   
                        prmtr_id_comp:
                            begin
                                if(param_id)
                                    state_next=prmtr_0;
                                else
                                    state_next=prmtr_id_comp;
                            end
                        default:
                            state_next=idle;
                    
               endcase
                     mask_param=mask_param_1;
                     code_param=code_param_1;
                     sjw=sjw_1;    
           end
             
                    
                    
             
 endmodule
