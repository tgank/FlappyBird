module flappy30by30_rom
	(
		input wire clk, //TODO: fast updating clock
		input wire [4:0] row,
		input wire [4:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [4:0] row_reg;
	reg [4:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @(*) begin








		if(({row_reg, col_reg}>=10'b0000000000) && ({row_reg, col_reg}<10'b0100000101)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100000101)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0100000110) && ({row_reg, col_reg}<10'b0100001001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100001001)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0100001010) && ({row_reg, col_reg}<10'b0100001110)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}>=10'b0100001110) && ({row_reg, col_reg}<10'b0100010000)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b0100010000)) color_data = 12'b101101001100;
		if(({row_reg, col_reg}==10'b0100010001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100010010)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0100010011) && ({row_reg, col_reg}<10'b0100010111)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100010111)) color_data = 12'b101001001011;

		if(({row_reg, col_reg}>=10'b0100011000) && ({row_reg, col_reg}<10'b0100100000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100100000)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0100100001) && ({row_reg, col_reg}<10'b0100100100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100100100)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0100100101) && ({row_reg, col_reg}<10'b0100101000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100101000)) color_data = 12'b101000111100;
		if(({row_reg, col_reg}==10'b0100101001)) color_data = 12'b101101001101;
		if(({row_reg, col_reg}>=10'b0100101010) && ({row_reg, col_reg}<10'b0100101101)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b0100101101)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100101110)) color_data = 12'b101000111100;
		if(({row_reg, col_reg}==10'b0100101111)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0100110000)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0100110001) && ({row_reg, col_reg}<10'b0100110011)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}>=10'b0100110011) && ({row_reg, col_reg}<10'b0100110101)) color_data = 12'b101001001011;

		if(({row_reg, col_reg}>=10'b0100110101) && ({row_reg, col_reg}<10'b0101000010)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0101000010)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0101000011) && ({row_reg, col_reg}<10'b0101001000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0101001000)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b0101001001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0101001010)) color_data = 12'b100101001011;
		if(({row_reg, col_reg}==10'b0101001011)) color_data = 12'b011000100111;
		if(({row_reg, col_reg}==10'b0101001100)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==10'b0101001101)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}==10'b0101001110)) color_data = 12'b001100010100;
		if(({row_reg, col_reg}==10'b0101001111)) color_data = 12'b010000010100;
		if(({row_reg, col_reg}==10'b0101010000)) color_data = 12'b010100100101;
		if(({row_reg, col_reg}==10'b0101010001)) color_data = 12'b100101001011;
		if(({row_reg, col_reg}==10'b0101010010)) color_data = 12'b101101001101;
		if(({row_reg, col_reg}==10'b0101010011)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0101010100)) color_data = 12'b101001011100;
		if(({row_reg, col_reg}==10'b0101010101)) color_data = 12'b101001001011;

		if(({row_reg, col_reg}>=10'b0101010110) && ({row_reg, col_reg}<10'b0101101000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0101101000)) color_data = 12'b100101001100;
		if(({row_reg, col_reg}==10'b0101101001)) color_data = 12'b011000100110;
		if(({row_reg, col_reg}==10'b0101101010)) color_data = 12'b010000010011;
		if(({row_reg, col_reg}==10'b0101101011)) color_data = 12'b100110000011;
		if(({row_reg, col_reg}>=10'b0101101100) && ({row_reg, col_reg}<10'b0101101110)) color_data = 12'b101110100011;
		if(({row_reg, col_reg}==10'b0101101110)) color_data = 12'b100010000001;
		if(({row_reg, col_reg}==10'b0101101111)) color_data = 12'b001100110010;
		if(({row_reg, col_reg}==10'b0101110000)) color_data = 12'b100010001000;
		if(({row_reg, col_reg}==10'b0101110001)) color_data = 12'b011000100110;
		if(({row_reg, col_reg}==10'b0101110010)) color_data = 12'b100100111010;
		if(({row_reg, col_reg}>=10'b0101110011) && ({row_reg, col_reg}<10'b0101110111)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0101110111)) color_data = 12'b101001001011;

		if(({row_reg, col_reg}>=10'b0101111000) && ({row_reg, col_reg}<10'b0110000001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0110000001)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0110000010) && ({row_reg, col_reg}<10'b0110000110)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0110000110)) color_data = 12'b100101001011;
		if(({row_reg, col_reg}==10'b0110000111)) color_data = 12'b100101001010;
		if(({row_reg, col_reg}==10'b0110001000)) color_data = 12'b010100100110;
		if(({row_reg, col_reg}==10'b0110001001)) color_data = 12'b011101100010;
		if(({row_reg, col_reg}==10'b0110001010)) color_data = 12'b101110110010;
		if(({row_reg, col_reg}==10'b0110001011)) color_data = 12'b111011100011;
		if(({row_reg, col_reg}==10'b0110001100)) color_data = 12'b111111110100;
		if(({row_reg, col_reg}==10'b0110001101)) color_data = 12'b111111010011;
		if(({row_reg, col_reg}==10'b0110001110)) color_data = 12'b011101100010;
		if(({row_reg, col_reg}==10'b0110001111)) color_data = 12'b101110111011;
		if(({row_reg, col_reg}==10'b0110010000)) color_data = 12'b111011111110;
		if(({row_reg, col_reg}==10'b0110010001)) color_data = 12'b100110011001;
		if(({row_reg, col_reg}==10'b0110010010)) color_data = 12'b010100110110;
		if(({row_reg, col_reg}==10'b0110010011)) color_data = 12'b100101001011;
		if(({row_reg, col_reg}==10'b0110010100)) color_data = 12'b101000111100;
		if(({row_reg, col_reg}==10'b0110010101)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}>=10'b0110010110) && ({row_reg, col_reg}<10'b0110011000)) color_data = 12'b101001001011;

		if(({row_reg, col_reg}>=10'b0110011000) && ({row_reg, col_reg}<10'b0110100001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0110100001)) color_data = 12'b101101001100;
		if(({row_reg, col_reg}==10'b0110100010)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0110100011)) color_data = 12'b101000111011;
		if(({row_reg, col_reg}==10'b0110100100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0110100101)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b0110100110)) color_data = 12'b011000110111;
		if(({row_reg, col_reg}==10'b0110100111)) color_data = 12'b010000010101;
		if(({row_reg, col_reg}==10'b0110101000)) color_data = 12'b000100010001;
		if(({row_reg, col_reg}==10'b0110101001)) color_data = 12'b001100110010;
		if(({row_reg, col_reg}==10'b0110101010)) color_data = 12'b101110100010;
		if(({row_reg, col_reg}==10'b0110101011)) color_data = 12'b111111100011;
		if(({row_reg, col_reg}==10'b0110101100)) color_data = 12'b111111100100;
		if(({row_reg, col_reg}==10'b0110101101)) color_data = 12'b110111100010;
		if(({row_reg, col_reg}==10'b0110101110)) color_data = 12'b010001000010;
		if(({row_reg, col_reg}==10'b0110101111)) color_data = 12'b111011101110;
		if(({row_reg, col_reg}==10'b0110110000)) color_data = 12'b110111011101;
		if(({row_reg, col_reg}==10'b0110110001)) color_data = 12'b010101100101;
		if(({row_reg, col_reg}==10'b0110110010)) color_data = 12'b100010001000;
		if(({row_reg, col_reg}==10'b0110110011)) color_data = 12'b010100100110;
		if(({row_reg, col_reg}==10'b0110110100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0110110101)) color_data = 12'b101000111100;

		if(({row_reg, col_reg}>=10'b0110110110) && ({row_reg, col_reg}<10'b0111000001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0111000001)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0111000010) && ({row_reg, col_reg}<10'b0111000100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0111000100)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b0111000101)) color_data = 12'b011100101000;
		if(({row_reg, col_reg}==10'b0111000110)) color_data = 12'b011101010111;
		if(({row_reg, col_reg}>=10'b0111000111) && ({row_reg, col_reg}<10'b0111001010)) color_data = 12'b110111011101;
		if(({row_reg, col_reg}==10'b0111001010)) color_data = 12'b011101110101;
		if(({row_reg, col_reg}==10'b0111001011)) color_data = 12'b101010100011;
		if(({row_reg, col_reg}==10'b0111001100)) color_data = 12'b111111100011;
		if(({row_reg, col_reg}==10'b0111001101)) color_data = 12'b111011000011;
		if(({row_reg, col_reg}==10'b0111001110)) color_data = 12'b011001010001;
		if(({row_reg, col_reg}==10'b0111001111)) color_data = 12'b110011001100;
		if(({row_reg, col_reg}==10'b0111010000)) color_data = 12'b110011001101;
		if(({row_reg, col_reg}==10'b0111010001)) color_data = 12'b011001100110;
		if(({row_reg, col_reg}==10'b0111010010)) color_data = 12'b101010111010;
		if(({row_reg, col_reg}==10'b0111010011)) color_data = 12'b010000010100;
		if(({row_reg, col_reg}==10'b0111010100)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b0111010101)) color_data = 12'b101101001100;

		if(({row_reg, col_reg}>=10'b0111010110) && ({row_reg, col_reg}<10'b0111100000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0111100000)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b0111100001) && ({row_reg, col_reg}<10'b0111100100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0111100100)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b0111100101)) color_data = 12'b011000100111;
		if(({row_reg, col_reg}==10'b0111100110)) color_data = 12'b011101100111;
		if(({row_reg, col_reg}==10'b0111100111)) color_data = 12'b111111111110;
		if(({row_reg, col_reg}>=10'b0111101000) && ({row_reg, col_reg}<10'b0111101010)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==10'b0111101010)) color_data = 12'b111011101100;
		if(({row_reg, col_reg}==10'b0111101011)) color_data = 12'b011001010011;
		if(({row_reg, col_reg}==10'b0111101100)) color_data = 12'b110010110010;
		if(({row_reg, col_reg}==10'b0111101101)) color_data = 12'b111111110011;
		if(({row_reg, col_reg}==10'b0111101110)) color_data = 12'b110011000010;
		if(({row_reg, col_reg}==10'b0111101111)) color_data = 12'b011101110101;
		if(({row_reg, col_reg}>=10'b0111110000) && ({row_reg, col_reg}<10'b0111110010)) color_data = 12'b110011001100;
		if(({row_reg, col_reg}==10'b0111110010)) color_data = 12'b100110001001;
		if(({row_reg, col_reg}==10'b0111110011)) color_data = 12'b001100010100;
		if(({row_reg, col_reg}==10'b0111110100)) color_data = 12'b100001001010;
		if(({row_reg, col_reg}==10'b0111110101)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b0111110110)) color_data = 12'b101101001100;
		if(({row_reg, col_reg}==10'b0111110111)) color_data = 12'b100101001011;

		if(({row_reg, col_reg}>=10'b0111111000) && ({row_reg, col_reg}<10'b1000000000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1000000000)) color_data = 12'b101101001100;
		if(({row_reg, col_reg}>=10'b1000000001) && ({row_reg, col_reg}<10'b1000000101)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1000000101)) color_data = 12'b011100101000;
		if(({row_reg, col_reg}==10'b1000000110)) color_data = 12'b011101010011;
		if(({row_reg, col_reg}==10'b1000000111)) color_data = 12'b111011101000;
		if(({row_reg, col_reg}==10'b1000001000)) color_data = 12'b111111111110;
		if(({row_reg, col_reg}==10'b1000001001)) color_data = 12'b111111111101;
		if(({row_reg, col_reg}==10'b1000001010)) color_data = 12'b110111010110;
		if(({row_reg, col_reg}==10'b1000001011)) color_data = 12'b011001010010;
		if(({row_reg, col_reg}==10'b1000001100)) color_data = 12'b110011000010;
		if(({row_reg, col_reg}>=10'b1000001101) && ({row_reg, col_reg}<10'b1000001111)) color_data = 12'b111111100011;
		if(({row_reg, col_reg}==10'b1000001111)) color_data = 12'b101010010010;
		if(({row_reg, col_reg}==10'b1000010000)) color_data = 12'b010100110001;
		if(({row_reg, col_reg}>=10'b1000010001) && ({row_reg, col_reg}<10'b1000010011)) color_data = 12'b010100100001;
		if(({row_reg, col_reg}==10'b1000010011)) color_data = 12'b010000000000;
		if(({row_reg, col_reg}==10'b1000010100)) color_data = 12'b011000100100;
		if(({row_reg, col_reg}==10'b1000010101)) color_data = 12'b100100111010;

		if(({row_reg, col_reg}>=10'b1000010110) && ({row_reg, col_reg}<10'b1000100000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1000100000)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1000100001) && ({row_reg, col_reg}<10'b1000100011)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}>=10'b1000100011) && ({row_reg, col_reg}<10'b1000100101)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1000100101)) color_data = 12'b100101001011;
		if(({row_reg, col_reg}==10'b1000100110)) color_data = 12'b011100110111;
		if(({row_reg, col_reg}==10'b1000100111)) color_data = 12'b011101010011;
		if(({row_reg, col_reg}==10'b1000101000)) color_data = 12'b110010110011;
		if(({row_reg, col_reg}==10'b1000101001)) color_data = 12'b101110110011;
		if(({row_reg, col_reg}==10'b1000101010)) color_data = 12'b011101100001;
		if(({row_reg, col_reg}==10'b1000101011)) color_data = 12'b101110100010;
		if(({row_reg, col_reg}==10'b1000101100)) color_data = 12'b111111100010;
		if(({row_reg, col_reg}==10'b1000101101)) color_data = 12'b111111100011;
		if(({row_reg, col_reg}==10'b1000101110)) color_data = 12'b101110100010;
		if(({row_reg, col_reg}==10'b1000101111)) color_data = 12'b011000110001;
		if(({row_reg, col_reg}==10'b1000110000)) color_data = 12'b100100110001;
		if(({row_reg, col_reg}==10'b1000110001)) color_data = 12'b101001000010;
		if(({row_reg, col_reg}>=10'b1000110010) && ({row_reg, col_reg}<10'b1000110100)) color_data = 12'b101000110001;
		if(({row_reg, col_reg}==10'b1000110100)) color_data = 12'b011100100010;
		if(({row_reg, col_reg}==10'b1000110101)) color_data = 12'b011100100111;
		if(({row_reg, col_reg}==10'b1000110110)) color_data = 12'b100101001100;
		if(({row_reg, col_reg}==10'b1000110111)) color_data = 12'b101101001100;

		if(({row_reg, col_reg}>=10'b1000111000) && ({row_reg, col_reg}<10'b1001000000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1001000000)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1001000001) && ({row_reg, col_reg}<10'b1001000011)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}>=10'b1001000011) && ({row_reg, col_reg}<10'b1001000101)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1001000101)) color_data = 12'b101101001101;
		if(({row_reg, col_reg}==10'b1001000110)) color_data = 12'b100101001011;
		if(({row_reg, col_reg}==10'b1001000111)) color_data = 12'b011100110111;
		if(({row_reg, col_reg}==10'b1001001000)) color_data = 12'b001000100011;
		if(({row_reg, col_reg}==10'b1001001001)) color_data = 12'b001000000001;
		if(({row_reg, col_reg}==10'b1001001010)) color_data = 12'b101001110000;
		if(({row_reg, col_reg}==10'b1001001011)) color_data = 12'b111111000001;
		if(({row_reg, col_reg}==10'b1001001100)) color_data = 12'b111110110001;
		if(({row_reg, col_reg}==10'b1001001101)) color_data = 12'b111010110000;
		if(({row_reg, col_reg}==10'b1001001110)) color_data = 12'b100001010000;
		if(({row_reg, col_reg}==10'b1001001111)) color_data = 12'b100000110000;
		if(({row_reg, col_reg}==10'b1001010000)) color_data = 12'b011000100000;
		if(({row_reg, col_reg}==10'b1001010001)) color_data = 12'b010100010000;
		if(({row_reg, col_reg}==10'b1001010010)) color_data = 12'b010000010000;
		if(({row_reg, col_reg}==10'b1001010011)) color_data = 12'b001100100001;
		if(({row_reg, col_reg}==10'b1001010100)) color_data = 12'b010000010100;
		if(({row_reg, col_reg}==10'b1001010101)) color_data = 12'b100101001011;
		if(({row_reg, col_reg}==10'b1001010110)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1001010111)) color_data = 12'b100101001010;

		if(({row_reg, col_reg}>=10'b1001011000) && ({row_reg, col_reg}<10'b1001100010)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1001100010)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1001100011) && ({row_reg, col_reg}<10'b1001100110)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1001100110)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1001100111)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1001101000)) color_data = 12'b100101001100;
		if(({row_reg, col_reg}==10'b1001101001)) color_data = 12'b011100100110;
		if(({row_reg, col_reg}==10'b1001101010)) color_data = 12'b100001010000;
		if(({row_reg, col_reg}==10'b1001101011)) color_data = 12'b101001110000;
		if(({row_reg, col_reg}==10'b1001101100)) color_data = 12'b111010110000;
		if(({row_reg, col_reg}==10'b1001101101)) color_data = 12'b111111000000;
		if(({row_reg, col_reg}==10'b1001101110)) color_data = 12'b111010110000;
		if(({row_reg, col_reg}==10'b1001101111)) color_data = 12'b100001010000;
		if(({row_reg, col_reg}==10'b1001110000)) color_data = 12'b100100110001;
		if(({row_reg, col_reg}==10'b1001110001)) color_data = 12'b101000100001;
		if(({row_reg, col_reg}==10'b1001110010)) color_data = 12'b101000110010;
		if(({row_reg, col_reg}==10'b1001110011)) color_data = 12'b011000100001;
		if(({row_reg, col_reg}==10'b1001110100)) color_data = 12'b010000010100;
		if(({row_reg, col_reg}==10'b1001110101)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1001110110)) color_data = 12'b101000111100;
		if(({row_reg, col_reg}==10'b1001110111)) color_data = 12'b101101001011;

		if(({row_reg, col_reg}>=10'b1001111000) && ({row_reg, col_reg}<10'b1010000001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010000001)) color_data = 12'b101001001101;
		if(({row_reg, col_reg}==10'b1010000010)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010000011)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1010000100) && ({row_reg, col_reg}<10'b1010000110)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010000110)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1010000111) && ({row_reg, col_reg}<10'b1010001001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010001001)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1010001010)) color_data = 12'b011000100111;
		if(({row_reg, col_reg}==10'b1010001011)) color_data = 12'b010000100100;
		if(({row_reg, col_reg}==10'b1010001100)) color_data = 12'b011101100000;
		if(({row_reg, col_reg}>=10'b1010001101) && ({row_reg, col_reg}<10'b1010001111)) color_data = 12'b101001110000;
		if(({row_reg, col_reg}==10'b1010001111)) color_data = 12'b100001100000;
		if(({row_reg, col_reg}==10'b1010010000)) color_data = 12'b001100100100;
		if(({row_reg, col_reg}==10'b1010010001)) color_data = 12'b010000010100;
		if(({row_reg, col_reg}==10'b1010010010)) color_data = 12'b010000010011;
		if(({row_reg, col_reg}==10'b1010010011)) color_data = 12'b010000010100;
		if(({row_reg, col_reg}==10'b1010010100)) color_data = 12'b011000100111;
		if(({row_reg, col_reg}>=10'b1010010101) && ({row_reg, col_reg}<10'b1010010111)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010010111)) color_data = 12'b100101001100;

		if(({row_reg, col_reg}>=10'b1010011000) && ({row_reg, col_reg}<10'b1010100000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}>=10'b1010100000) && ({row_reg, col_reg}<10'b1010100010)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1010100010) && ({row_reg, col_reg}<10'b1010100100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010100100)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1010100101)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010100110)) color_data = 12'b101001001101;
		if(({row_reg, col_reg}==10'b1010100111)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1010101000) && ({row_reg, col_reg}<10'b1010101010)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010101010)) color_data = 12'b101101001100;
		if(({row_reg, col_reg}==10'b1010101011)) color_data = 12'b101001001101;
		if(({row_reg, col_reg}==10'b1010101100)) color_data = 12'b010100100110;
		if(({row_reg, col_reg}>=10'b1010101101) && ({row_reg, col_reg}<10'b1010101111)) color_data = 12'b010000010101;
		if(({row_reg, col_reg}==10'b1010101111)) color_data = 12'b010100100110;
		if(({row_reg, col_reg}==10'b1010110000)) color_data = 12'b100101001011;
		if(({row_reg, col_reg}==10'b1010110001)) color_data = 12'b101101001100;
		if(({row_reg, col_reg}>=10'b1010110010) && ({row_reg, col_reg}<10'b1010110101)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1010110101)) color_data = 12'b101000111100;

		if(({row_reg, col_reg}>=10'b1010110110) && ({row_reg, col_reg}<10'b1011000001)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011000001)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1011000010) && ({row_reg, col_reg}<10'b1011001000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011001000)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1011001001)) color_data = 12'b101001001101;
		if(({row_reg, col_reg}==10'b1011001010)) color_data = 12'b100101001010;
		if(({row_reg, col_reg}==10'b1011001011)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1011001100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011001101)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1011001110)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011001111)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1011010000) && ({row_reg, col_reg}<10'b1011010011)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011010011)) color_data = 12'b100101001100;
		if(({row_reg, col_reg}==10'b1011010100)) color_data = 12'b100101011011;
		if(({row_reg, col_reg}==10'b1011010101)) color_data = 12'b101101011011;
		if(({row_reg, col_reg}>=10'b1011010110) && ({row_reg, col_reg}<10'b1011011000)) color_data = 12'b101001001011;

		if(({row_reg, col_reg}>=10'b1011011000) && ({row_reg, col_reg}<10'b1011100010)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}>=10'b1011100010) && ({row_reg, col_reg}<10'b1011100100)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}>=10'b1011100100) && ({row_reg, col_reg}<10'b1011100110)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011100110)) color_data = 12'b101001001011;
		if(({row_reg, col_reg}==10'b1011100111)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011101000)) color_data = 12'b101101001011;
		if(({row_reg, col_reg}==10'b1011101001)) color_data = 12'b101000111100;
		if(({row_reg, col_reg}>=10'b1011101010) && ({row_reg, col_reg}<10'b1011101100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011101100)) color_data = 12'b101101001100;
		if(({row_reg, col_reg}>=10'b1011101101) && ({row_reg, col_reg}<10'b1011110000)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011110000)) color_data = 12'b101101001100;
		if(({row_reg, col_reg}>=10'b1011110001) && ({row_reg, col_reg}<10'b1011110100)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011110100)) color_data = 12'b101000111100;
		if(({row_reg, col_reg}>=10'b1011110101) && ({row_reg, col_reg}<10'b1011110111)) color_data = 12'b101001001100;
		if(({row_reg, col_reg}==10'b1011110111)) color_data = 12'b101001001101;







		if(({row_reg, col_reg}>=10'b1011111000) && ({row_reg, col_reg}<=10'b1110111101)) color_data = 12'b101001001100;
	end
endmodule