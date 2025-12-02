`timescale 1ns / 1ps
module pipe_controller #(parameter initialXPos = 800, parameter initialYPos = 250)(
    input clk,
    input bright,
    input up,
    input rst,
    input [9:0] hCount, vCount,
    output reg [11:0] rgb_out,
    output reg [11:0] xpos,
    output reg [10:0] ypos
);
    wire pipe_fill;
    wire pipe_top;
    wire pipe_down;
    wire in_display_range;
   
    wire [11:0] hCount_ext;
    assign hCount_ext = {2'b00, hCount};
   
    parameter GREEN = 12'b0000_1111_0000;
   
    always @(*) begin
        if (pipe_fill)
            rgb_out = GREEN;
        else    
            rgb_out = 12'b0000_0000_0000;
    end
   

    assign in_display_range = (xpos >= 94) && (xpos <= 850);
   
    assign pipe_top = in_display_range &&
                      vCount >= 35 && vCount <= (ypos[9:0] - 50) &&
                      hCount_ext >= (xpos - 50) && hCount_ext <= (xpos + 50);
                     
    assign pipe_down = in_display_range &&
                       vCount >= (ypos[9:0] + 50) && vCount <= 515 &&
                       hCount_ext >= (xpos - 50) && hCount_ext <= (xpos + 50);
   
    assign pipe_fill = pipe_top || pipe_down;
   
    always @(posedge clk, posedge rst)
    begin
        if (rst) begin
            xpos <= initialXPos;
            ypos <= initialYPos;
        end
        else begin
       
            if (xpos <= 50) 
                xpos <= xpos + 1200;  // wrap
            else
                xpos <= xpos - 2;
        end
    end
endmodule
