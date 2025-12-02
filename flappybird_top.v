`timescale 1ns / 1ps

module flappybird_top (
    input        ClkPort,    // 100 MHz board clock
    input        BtnC,       // reset
    input        BtnL,       // start + flap
    output       Hsync,
    output       Vsync,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue
);


    // VGA timing (display_controller)
    wire        bright;
    wire [9:0]  hCount;
    wire [9:0]  vCount;

    display_controller u_disp (
        .clk    (ClkPort),
        .hSync  (Hsync),
        .vSync  (Vsync),
        .bright (bright),
        .hCount (hCount),
        .vCount (vCount)
    );

    
    // ********Slow tick for game updates******
    // 100 MHz / 2^20 ≈ 95 Hz 
    reg [19:0] tick_div;
    wire       tick = (tick_div == 20'd0);

    always @(posedge ClkPort or posedge BtnC) begin
        if (BtnC) begin
            tick_div <= 20'd0;
        end else begin
            tick_div <= tick_div + 20'd1;
        end
    end

    //*********** Flappy Bird core (game logic) ************
    wire [9:0] bird_y;
    wire [9:0] pipe1_x, pipe1_gap;
    wire [9:0] pipe2_x, pipe2_gap;
    wire [7:0] score;
    wire       hit;
    wire       q_I, q_flap, q_hitrest, q_hit;

    flappybirdcore u_core (
        .clk       (ClkPort),
        .reset     (BtnC),
        
        .start     (BtnL), //START = Left button
        .flap      (BtnU), //FLAP = Up button
        
        .tick      (tick),
        .bird_y    (bird_y),
        .pipe1_x   (pipe1_x),
        .pipe1_gap (pipe1_gap),
        .pipe2_x   (pipe2_x),
        .pipe2_gap (pipe2_gap),
        .score     (score),
        .hit       (hit),
        .q_I       (q_I),
        .q_flap    (q_flap),
        .q_hitrest (q_hitrest),
        .q_hit     (q_hit)
    );

    // ************Rendering constants***************
    // needs to match the core’s idea of geometry
    localparam integer SCREEN_WIDTH  = 640;
    localparam integer BIRD_X        = 320;   // same as in flappybirdcore
    // draw a 30x30 sprite even though core uses 20x20 for collision
    localparam integer BIRD_WIDTH    = 30;
    localparam integer BIRD_HEIGHT   = 30;
    localparam integer PIPE_WIDTH    = 40;
    localparam integer GAP_HEIGHT    = 120;
    localparam integer GROUND_Y      = 460;

    localparam [11:0] PIPE_COLOR   = 12'b0000_1111_0000; // green
    localparam [11:0] GROUND_COLOR = 12'b1000_0100_0000; // brown-ish
    // localparam [11:0] SKY_COLOR    = 12'b0010_1100_1111; // light blue

    //Background ROM hookup
    wire [11:0] bg_color;
    //MODIFICATION: Visible area is 144,35 in display_controller
    wire [9:0] bg_col = hCount - 10'd144;
    wire [8:0] bg_row = vCount - 9'd35;

    flappyBird_background_rom bg_rom (
        .clk       (ClkPort),
        .row       (bg_row),   // 0..479
        .col       (bg_col),   // 0..639
        .color_data(bg_color)
    );
    
    // BIRD Sprite ROM hookup (flappy30by30)
    wire        bird_region;
    wire [4:0]  sprite_row;
    wire [4:0]  sprite_col;
    wire [11:0] bird_color;

    // purple key color from your ROM (background to hide)
    localparam [11:0] PURPLE_KEY = 12'b101001001100_
 // is current pixel inside sprite box?
    assign bird_region =
        (hCount >= BIRD_X) &&
        (hCount <  BIRD_X + BIRD_WIDTH) &&
        (vCount >= bird_y) &&
        (vCount <  bird_y + BIRD_HEIGHT);

    // map screen coords to sprite coords (0..29)
    assign sprite_row = (vCount - bird_y)[4:0];
    assign sprite_col = (hCount - BIRD_X)[4:0];

    // HAS TO MATCH MODULE NAME
    flappy30by30_12_bit_rom bird_rom (
        .clk        (ClkPort),
        .row        (sprite_row),
        .col        (sprite_col),
        .color_data (bird_color)
    );

    
    // Pipes and ground region
    wire pipe1_region;
    wire pipe2_region;
    wire ground_region;

    // Pipe 1
    wire pipe1_horiz     = (hCount >= pipe1_x) &&
                           (hCount <  pipe1_x + PIPE_WIDTH);
    wire pipe1_above_gap = (vCount <  pipe1_gap);
    wire pipe1_below_gap = (vCount >= pipe1_gap + GAP_HEIGHT);
    assign pipe1_region  = pipe1_horiz && (pipe1_above_gap || pipe1_below_gap);

    // Pipe 2
    wire pipe2_horiz     = (hCount >= pipe2_x) &&
                           (hCount <  pipe2_x + PIPE_WIDTH);
    wire pipe2_above_gap = (vCount <  pipe2_gap);
    wire pipe2_below_gap = (vCount >= pipe2_gap + GAP_HEIGHT);
    assign pipe2_region  = pipe2_horiz && (pipe2_above_gap || pipe2_below_gap);

    // Ground strip near bottom
    assign ground_region = (vCount >= GROUND_Y);

    // -----------------------------
    // Final RGB mux (layers)
    // -----------------------------
    reg [11:0] rgb;

    always @* begin
        if (!bright) begin
            rgb = 12'h000; // outside visible area
        end
        // bird sprite on top, but treat purple as transparent
        else if (bird_region && (bird_color != PURPLE_KEY)) begin
            rgb = bird_color;
        end
        else if (pipe1_region || pipe2_region) begin
            rgb = PIPE_COLOR;
        end
        else if (ground_region) begin
            rgb = GROUND_COLOR;
        end
        else begin
            rgb = bg_color; // static background image
        end
    end

    assign vgaRed   = rgb[11:8];
    assign vgaGreen = rgb[7:4];
    assign vgaBlue  = rgb[3:0];

endmodule
