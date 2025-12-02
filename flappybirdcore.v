module flappybirdcore(clk, reset, start, flap, tick, bird_y, pipe1_x, pipe1_gap, pipe2_x, pipe2_gap, score, hit, q_I, q_flap, q_hitrest, q_hit);


	/*  INPUTS */
	input clk, reset, start, flap, tick; 

	/*  OUTPUTS */
	output reg [9:0] bird_y, pipe1_x, pipe1_gap, pipe2_x, pipe2_gap;	
    output reg [7:0] score;
    output reg hit;


	// store current state
	output q_I, q_flap, q_hitrest, q_hit;
	reg [3:0] state;
	assign {q_hit, q_hitrest, q_flap, q_I} = state;
		
	localparam 	
	I = 4'b0001, 
    FLAP = 4'b0010, 
    HITREST = 4'b0100, 
    HIT = 4'b1000;

    //pixals it moves per clock cycle so its not robotic
    reg pipe1_scored, pipe2_scored;


    //will need to adjust these when connected to the moniotor when it looks right, just kinda guessed values so def will need to change some
    localparam PIPE_SPEED = 2;
    localparam SCREEN_WIDTH = 640;
    localparam BIRD_X = 320; //center of the board
    localparam PIPE_WIDTH = 40;
    localparam GAP_HEIGHT = 120;     
    localparam GROUND_Y = 460; //becuase bird is 20x20
    localparam BIRD_WIDTH  = 20;
    localparam BIRD_HEIGHT = 20;

    integer birdleft, birdright;
    integer pipeleft1, pipeleft2;
    integer piperight1, piperight2;
    integer bottomofgap1, bottomofgap2;
    integer topofgap1, topofgap2;
	//note the resolution is fixed from the board, the resolution is 640x480

	always @ (posedge clk, posedge reset)
	begin 
		if(reset) 
		  begin
			state <= I;

            //bird on reset
            bird_y <= 240; //middle of the screen

            //reseting the pipes 
            pipe1_x <= 500; //off the right side of the screen 
            pipe1_gap <= 150; //random value for gap can change
            pipe2_x <= 800; //more off the screen
            pipe2_gap <= 180; //random can change it

            //score
            score <= 0;
            pipe1_scored <= 0;
            pipe2_scored <= 0;

            hit <= 0;
		  end
		else if (tick) 
            begin //want everything to work on a slower clock
				case(state)	
					I: begin
                        hit<= 0;
						if (start) begin 
                            state <= FLAP;
                        end 
					end	

					FLAP: begin
                        //so if nothing is happening the bird should be falling constantly
                       if(flap)
                            bird_y <= bird_y - 20;
                        else
                            bird_y <= bird_y + 2; //normal falling motion
                        
                        if(bird_y < 0)
                            bird_y <= 10; //maybe try 10 for not wrap
                        
                        //moving the pipes to the left
                        pipe1_x <= pipe1_x - PIPE_SPEED;
                        pipe2_x <= pipe2_x - PIPE_SPEED;

                        //if a pipe goes off screen make another pipe that starts from the right 
                        if(pipe1_x + PIPE_WIDTH < 0) 
                            begin 
                                pipe1_x <= SCREEN_WIDTH + 50; //again using random number will need to check
                                pipe1_gap <= 150; //not randomizing right now to see if the code works
                                pipe1_scored <= 0;
                            end 
                        
                        if(pipe2_x + PIPE_WIDTH < 0) 
                            begin 
                                pipe2_x <= SCREEN_WIDTH + 50; 
                                pipe2_gap <= 150; 
                                pipe2_scored <= 0;
                            end 

                        //now seeing if the bird got through the pipe 
                        if(!pipe1_scored && (pipe1_x + PIPE_WIDTH < BIRD_X))
                            begin 
                                score <= score + 1; //idk what type of scoring we want for each pipe 1 or 10
                                pipe1_scored <= 1;
                            end 
                        if(!pipe2_scored && (pipe2_x + PIPE_WIDTH < BIRD_X))
                            begin 
                                score <= score + 1;
                                pipe2_scored <= 1;
                            end
                        
                        //if hits a pipe
                        birdleft = BIRD_X;
                        birdright = BIRD_X + BIRD_WIDTH;
                        pipeleft1 = pipe1_x;
                        pipeleft2 = pipe2_x;
                        piperight1 = pipe1_x + PIPE_WIDTH;
                        piperight2 = pipe2_x + PIPE_WIDTH;
                        bottomofgap1 = pipe1_gap;
                        topofgap1 = pipe1_gap + GAP_HEIGHT;
                        bottomofgap2 = pipe2_gap;
                        topofgap2 = pipe2_gap + GAP_HEIGHT;

                        //does it hit the first pipe
                        if((birdright >= pipeleft1) && (birdleft <= piperight1))
                            begin
                                if(!((bird_y >= bottomofgap1) && (bird_y + BIRD_HEIGHT <= topofgap1)))
                                    begin
                                        hit<= 1;
                                    end
                            end
                        
                        //does it hit the second pipe
                        if((birdright >= pipeleft2) && (birdleft <= piperight2))
                            begin
                                if(!((bird_y >= bottomofgap2) && (bird_y + BIRD_HEIGHT <= topofgap2)))
                                    begin
                                        hit<= 1;
                                    end
                            end

                        //now if it touches the ground 
                        if(bird_y + BIRD_HEIGHT >= GROUND_Y)
                            begin 
                                hit <=1;
                            end

                        //now just the transition
                        if(hit)
                        begin
                            state <= HITREST;
                        end
                    end    

                    HITREST: begin 
                        bird_y <= bird_y + 3; //falls at a constat rate sligthly faster than usual
                        if(bird_y + BIRD_HEIGHT >= GROUND_Y)
                            begin 
                                bird_y <= GROUND_Y - BIRD_HEIGHT;
                                state <= HIT;
                            end
                    end

                    HIT: begin 
                        if(start)
                            begin
                                state <= I;
                                bird_y <= 240; 

                                pipe1_x <= 500; 
                                pipe1_gap <= 150; 
                                pipe2_x <= 800; 
                                pipe2_gap <= 180; 

                                score <= 0;
                                pipe1_scored <= 0;
                                pipe2_scored <= 0;

                                hit <= 0;
                            end
                    end
                endcase
            end							  
    end 
	
endmodule

