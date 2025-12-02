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
        .start     (BtnL),
        .flap      (BtnL),
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
    // we’ll draw a 30x30 sprite even though core uses 20x20 for collision
    localparam integer BIRD_WIDTH    = 30;
    localparam integer BIRD_HEIGHT   = 30;
    localparam integer PIPE_WIDTH    = 40;
    localparam integer GAP_HEIGHT    = 120;
    localparam integer GROUND_Y      = 460;

    localparam [11:0] PIPE_COLOR   = 12'b0000_1111_0000; // green
    localparam [11:0] GROUND_COLOR = 12'b1000_0100_0000; // brown-ish
    localparam [11:0] SKY_COLOR    = 12'b0010_1100_1111; // light blue

    // Sprite ROM hookup (flappy30by30)
    wire        bird_region;
    wire [4:0]  sprite_row;
    wire [4:0]  sprite_col;
    wire [11:0] bird_color;

    // purple key color from your ROM (background to hide)
    localparam [11:0] PURPLE_KEY = 12'b101001001100_
