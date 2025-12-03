`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USC Viterbi EE354 F2025
// Engineer: 
// 
// Create Date:    12:18:00 12/14/2017 
// Design Name: 
// Module Name:    vga_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// Date: 04/04/2020
// Author: Yue (Julien) Niu
// Description: Port from NEXYS3 to NEXYS4
//////////////////////////////////////////////////////////////////////////////////
module vga_top(
	input ClkPort,
	input BtnC,
	input BtnU,
	input BtnR,
	input BtnL,
	input BtnD,
	//VGA signal
	output hSync, vSync,
	output [3:0] vgaR, vgaG, vgaB,
	
	//SSG signal 
	output An0, An1, An2, An3, An4, An5, An6, An7,
	output Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	
	//output MemOE, MemWR, RamCS,
	output  QuadSpiFlashCS,
	output audioOut
	);
	wire Reset;
	assign Reset=BtnC;
	wire bright;
	wire[9:0] hc, vc;

	// *************BACKGROUND ROM (640x480 scaled)
	wire [11:0] bg_color;
	wire [9:0] bg_row = vc - 35;   // shift to visible region if needed
	wire [9:0] bg_col = hc - 144;
	
	// clamp to ROM size (if your ROM is 640×480 or scaled)
	wire [9:0] bg_row_clamped = (bg_row > 479) ? 479 : bg_row;
	wire [9:0] bg_col_clamped = (bg_col > 639) ? 639 : bg_col;
	
	flappyBird_background_12_bit_rom background_rom (
	    .clk(ClkPort),
	    .row(bg_row_clamped),
	    .col(bg_col_clamped),
	    .color_data(bg_color)
	);

	
	wire[15:0] score;
	wire up,down,left,right;
	wire [3:0] anode;
	wire [11:0] rgb;
	wire [11:0] rgb_block;
	wire[11:0] rgb_pipe;
	wire[11:0] rgb_pipe2;
	wire[11:0] rgb_pipe3;
	
	wire [11:0] xpos_block , ypos_block;
	
	wire [11:0] xpos_pipe, xpos_pipe2, xpos_pipe3; 
    wire [10:0] ypos_pipe, ypos_pipe2, ypos_pipe3;

	//**************** BIRD SPRITE ***************
	localparam BIRD_WIDTH  = 30;
	localparam BIRD_HEIGHT = 30;
	
	wire is_bird_pixel;
	assign is_bird_pixel =
	       (hc >= xpos_block - 15) &&
	       (hc <  xpos_block + 15) &&
	       (vc >= ypos_block - 15) &&
	       (vc <  ypos_block + 15);
	
	wire [4:0] bird_sprite_row = vc - (ypos_block - 15);
	wire [4:0] bird_sprite_col = hc - (xpos_block - 15);
	wire [11:0] bird_color;
	
	flappy30by30_12_bit_rom bird_rom (
	    .clk(ClkPort),
	    .row(bird_sprite_row),
	    .col(bird_sprite_col),
	    .color_data(bird_color)
	);
	localparam [11:0] PURPLE_KEY = 12'hC4C; 
	//***end of BIRD SPRITE ***************

	wire rst;
	
	reg [3:0]	SSD;
	wire [3:0]	SSD3, SSD2, SSD1, SSD0;
	reg [7:0]  	SSD_CATHODES;
	wire [1:0] 	ssdscan_clk;
	
	reg [27:0]	DIV_CLK;
	reg [11:0] pixel; 
	always @ (posedge ClkPort, posedge Reset)  
	begin : CLOCK_DIVIDER
      if (Reset)
			DIV_CLK <= 0;
	  else
			DIV_CLK <= DIV_CLK + 1'b1;
	end
	wire move_clk;
	assign move_clk=DIV_CLK[19]; //slower clock to drive the movement of objects on the vga screen
	wire [11:0] background;

	display_controller dc(.clk(ClkPort), .hSync(hSync), .vSync(vSync), .bright(bright), .hCount(hc), .vCount(vc));
	block_controller sc(.clk(move_clk), .bright(bright), .rst(BtnC), .up(BtnU), .down(BtnD),.left(BtnL),.right(BtnR),.hCount(hc), .vCount(vc), .rgb_out(rgb_block), .background(background), .xpos(xpos_block), .ypos(ypos_block));
	pipe_controller #(.initialXPos(700), .initialYPos(250)) pc(.clk(move_clk), .bright(bright),.up(BtnU), .rst(BtnC),.hCount(hc), .vCount(vc), .rgb_out(rgb_pipe), .xpos(xpos_pipe), .ypos(ypos_pipe));
	pipe_controller #(.initialXPos(1100), .initialYPos(160)) pc2(.clk(move_clk), .bright(bright),.up(BtnU), .rst(BtnC),.hCount(hc), .vCount(vc), .rgb_out(rgb_pipe2), .xpos(xpos_pipe2), .ypos(ypos_pipe2));
	pipe_controller #(.initialXPos(1500), .initialYPos(370)) pc3(.clk(move_clk), .bright(bright),.up(BtnU), .rst(BtnC),.hCount(hc), .vCount(vc), .rgb_out(rgb_pipe3), .xpos(xpos_pipe3), .ypos(ypos_pipe3));
    
    wire hitPipe1, hitPipe2, hitPipe3, hitGround;
    wire hitPipe;

    assign hitPipe1 = (xpos_block + 5 >= xpos_pipe - 50) && 
                    (xpos_block - 5 <= xpos_pipe + 50) &&
                    ((ypos_block - 5 <= ypos_pipe - 50) || (ypos_block + 5 >= ypos_pipe + 50));

    assign hitPipe2 = (xpos_block + 5 >= xpos_pipe2 - 50) && 
                    (xpos_block - 5 <= xpos_pipe2 + 50) &&
                    ((ypos_block - 5 <= ypos_pipe2 - 50) || (ypos_block + 5 >= ypos_pipe2 + 50));

    assign hitPipe3 = (xpos_block + 5 >= xpos_pipe3 - 50) && 
                    (xpos_block - 5 <= xpos_pipe3 + 50) &&
                    ((ypos_block - 5 <= ypos_pipe3 - 50) || (ypos_block + 5 >= ypos_pipe3 + 50));
                    
	assign hitGround = (ypos_block >= 514); //changed to YPOS because too low means checking vertical allignement

    assign hitPipe = hitPipe1 || hitPipe2 || hitPipe3 || hitGround;
    
    wire passPipe1, passPipe2, passPipe3;

    assign passPipe1 = (xpos_pipe >= xpos_block) && (xpos_pipe < xpos_block + 2) &&
                (ypos_block - 5 >= ypos_pipe - 50) && (ypos_block + 5 <= ypos_pipe + 50);

    assign passPipe2 = (xpos_pipe2 >= xpos_block) && (xpos_pipe2 < xpos_block + 2) &&
                (ypos_block - 5 >= ypos_pipe2 - 50) && (ypos_block + 5 <= ypos_pipe2 + 50);

    assign passPipe3 = (xpos_pipe3 >= xpos_block) && (xpos_pipe3 < xpos_block + 2) &&
                (ypos_block - 5 >= ypos_pipe3 - 50) && (ypos_block + 5 <= ypos_pipe3 + 50);
    reg fail;
    reg[11:0] points;
    reg [23:0] tone, duration;

    always @(posedge move_clk, posedge Reset) begin
        if(Reset)begin
            fail<=0;
            points<=0;
        end
        else if(hitPipe)
            fail<=1;
        else if ( passPipe1 || passPipe2 || passPipe3) begin
            points<= points+1;
        end
    end
    always @(posedge ClkPort, posedge Reset) begin
        if(Reset)begin
            tone<=0;
            duration<=0;
        end
        else begin
            tone <= (tone >= 83333) ? 0 : tone + 1;
            duration <= (passPipe1 || passPipe2 || passPipe3) ? 5000000 : (duration > 0) ? duration - 1 : 0;
        end
    end

    // assign rgb = (~bright) ? 12'b0000_0000_0000 :(fail) ? 12'b1111_0000_0000 : (rgb_pipe + rgb_block + rgb_pipe2 + rgb_pipe3);
	//Updated RGB logic with sprite
	
	always @* begin
	    if (~bright) begin
	        pixel = 12'h000;
	    end
	    else begin
	        // 1) base: background
	        pixel = bg_color;
	
	        // 2) pipes
	        if (rgb_pipe  != 12'h000) pixel = rgb_pipe;
	        if (rgb_pipe2 != 12'h000) pixel = rgb_pipe2;
	        if (rgb_pipe3 != 12'h000) pixel = rgb_pipe3;
	
	        // 3) old block (optional fallback / hitbox)
	        if (rgb_block != 12'h000) pixel = rgb_block;
	
	        // 4) bird sprite overrides block, with purple transparent
	        if (is_bird_pixel && (bird_color != PURPLE_KEY))
	            pixel = bird_color;
	
	        // 5) fail overrides everything
	        if (fail)
	            pixel = 12'hF00;
		    end
		end
	
	assign rgb = pixel;
	

	
	
    assign audioOut = (duration > 0) & (tone < 41666);

	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];
	
	// disable mamory ports
	//assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;
	assign QuadSpiFlashCS = 1'b1;
	
	//------------
// SSD (Seven Segment Display)
	// reg [3:0]	SSD;
	// wire [3:0]	SSD3, SSD2, SSD1, SSD0;
	
	//SSDs display 
	//to show how we can interface our "game" module with the SSD's, we output the 12-bit rgb background value to the SSD's
	assign SSD3 = 4'b0000;
	assign SSD2 = points[11:8];
	assign SSD1 = points[7:4];
	assign SSD0 = points[3:0];


	// need a scan clk for the seven segment display 
	
	// 100 MHz / 2^18 = 381.5 cycles/sec ==> frequency of DIV_CLK[17]
	// 100 MHz / 2^19 = 190.7 cycles/sec ==> frequency of DIV_CLK[18]
	// 100 MHz / 2^20 =  95.4 cycles/sec ==> frequency of DIV_CLK[19]
	
	// 381.5 cycles/sec (2.62 ms per digit) [which means all 4 digits are lit once every 10.5 ms (reciprocal of 95.4 cycles/sec)] works well.
	
	//                  --|  |--|  |--|  |--|  |--|  |--|  |--|  |--|  |   
    //                    |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | 
	//  DIV_CLK[17]       |__|  |__|  |__|  |__|  |__|  |__|  |__|  |__|
	//
	//               -----|     |-----|     |-----|     |-----|     |
    //                    |  0  |  1  |  0  |  1  |     |     |     |     
	//  DIV_CLK[18]       |_____|     |_____|     |_____|     |_____|
	//
	//         -----------|           |-----------|           |
    //                    |  0     0  |  1     1  |           |           
	//  DIV_CLK[19]       |___________|           |___________|
	//

	assign ssdscan_clk = DIV_CLK[19:18];
	assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An2	=  !((ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An3	=  !((ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	// Turn off another 4 anodes
	assign {An7, An6, An5, An4} = 4'b1111;
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
				  2'b00: SSD = SSD0;
				  2'b01: SSD = SSD1;
				  2'b10: SSD = SSD2;
				  2'b11: SSD = SSD3;
		endcase 
	end

	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD) // in this solution file the dot points are made to glow by making Dp = 0
		    //                                                                abcdefg,Dp
			4'b0000: SSD_CATHODES = 8'b00000010; // 0
			4'b0001: SSD_CATHODES = 8'b10011110; // 1
			4'b0010: SSD_CATHODES = 8'b00100100; // 2
			4'b0011: SSD_CATHODES = 8'b00001100; // 3
			4'b0100: SSD_CATHODES = 8'b10011000; // 4
			4'b0101: SSD_CATHODES = 8'b01001000; // 5
			4'b0110: SSD_CATHODES = 8'b01000000; // 6
			4'b0111: SSD_CATHODES = 8'b00011110; // 7
			4'b1000: SSD_CATHODES = 8'b00000000; // 8
			4'b1001: SSD_CATHODES = 8'b00001000; // 9
			4'b1010: SSD_CATHODES = 8'b00010000; // A
			4'b1011: SSD_CATHODES = 8'b11000000; // B
			4'b1100: SSD_CATHODES = 8'b01100010; // C
			4'b1101: SSD_CATHODES = 8'b10000100; // D
			4'b1110: SSD_CATHODES = 8'b01100000; // E
			4'b1111: SSD_CATHODES = 8'b01110000; // F    
			default: SSD_CATHODES = 8'bXXXXXXXX; // default is not needed as we covered all cases
		endcase
	end	
	
	// reg [7:0]  SSD_CATHODES;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES};

endmodule


