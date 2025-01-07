// This module is just a big ROM which allows you to look up the character at a position for a given note
`define NOTE_WIDTH 6
`define NOTE_WITH_SYMBOL_WIDTH 8

module note_rom(
    input [`NOTE_WITH_SYMBOL_WIDTH-1: 0] addr,
    output reg [5:0] data
);
    // A memory is implemented using a case statement 
    always @(addr)
      case (addr)
        `NOTE_WITH_SYMBOL_WIDTH'b00000000: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00000001: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00000010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00000011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00000100: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00000101: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b00000110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00000111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00001000: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00001001: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b00001010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b00001011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00001100: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00001101: data = 6'd2; // B
        `NOTE_WITH_SYMBOL_WIDTH'b00001110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00001111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00010000: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00010001: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b00010010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00010011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00010100: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00010101: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b00010110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b00010111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00011000: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00011001: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b00011010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00011011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00011100: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00011101: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b00011110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b00011111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00100000: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00100001: data = 6'd5; // E
        `NOTE_WITH_SYMBOL_WIDTH'b00100010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00100011: data = 6'd32; // blank
        
        `NOTE_WITH_SYMBOL_WIDTH'b00100100: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00100101: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b00100110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00100111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00101000: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00101001: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b00101010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b00101011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00101100: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00101101: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b00101110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00101111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00110000: data = 6'd49; // 1
        `NOTE_WITH_SYMBOL_WIDTH'b00110001: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b00110010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b00110011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00110100: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b00110101: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b00110110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00110111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00111000: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b00111001: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b00111010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b00111011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b00111100: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b00111101: data = 6'd2; // B
        `NOTE_WITH_SYMBOL_WIDTH'b00111110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b00111111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01000000: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01000001: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b01000010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01000011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01000100: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01000101: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b01000110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b01000111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01001000: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01001001: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b01001010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01001011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01001100: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01001101: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b01001110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b01001111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01010000: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01010001: data = 6'd5; // E
        `NOTE_WITH_SYMBOL_WIDTH'b01010010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01010011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01010100: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01010101: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b01010110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01010111: data = 6'd32; // blank
        
        `NOTE_WITH_SYMBOL_WIDTH'b01011000: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01011001: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b01011010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b01011011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01011100: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01011101: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b01011110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01011111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01100000: data = 6'd50; // 2
        `NOTE_WITH_SYMBOL_WIDTH'b01100001: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b01100010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b01100011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01100100: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b01100101: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b01100110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01100111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01101000: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b01101001: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b01101010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b01101011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01101100: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b01101101: data = 6'd2; // B
        `NOTE_WITH_SYMBOL_WIDTH'b01101110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01101111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01110000: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b01110001: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b01110010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01110011: data = 6'd32; // blank
        
        `NOTE_WITH_SYMBOL_WIDTH'b01110100: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b01110101: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b01110110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b01110111: data = 6'd32; // blank
        
        `NOTE_WITH_SYMBOL_WIDTH'b01111000: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b01111001: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b01111010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b01111011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b01111100: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b01111101: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b01111110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b01111111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10000000: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b10000001: data = 6'd5; // E
        `NOTE_WITH_SYMBOL_WIDTH'b10000010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10000011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10000100: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b10000101: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b10000110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10000111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10001000: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b10001001: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b10001010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b10001011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10001100: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b10001101: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b10001110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10001111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10010000: data = 6'd51; // 3
        `NOTE_WITH_SYMBOL_WIDTH'b10010001: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b10010010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b10010011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10010100: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10010101: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b10010110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10010111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10011000: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10011001: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b10011010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b10011011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10011100: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10011101: data = 6'd2; // B
        `NOTE_WITH_SYMBOL_WIDTH'b10011110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10011111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10100000: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10100001: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b10100010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10100011: data = 6'd32; // blank
        
        `NOTE_WITH_SYMBOL_WIDTH'b10100100: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10100101: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b10100110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b10100111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10101000: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10101001: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b10101010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10101011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10101100: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10101101: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b10101110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b10101111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10110000: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10110001: data = 6'd5; // E
        `NOTE_WITH_SYMBOL_WIDTH'b10110010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10110011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10110100: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10110101: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b10110110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10110111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10111000: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10111001: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b10111010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b10111011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b10111100: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b10111101: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b10111110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b10111111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11000000: data = 6'd52; // 4
        `NOTE_WITH_SYMBOL_WIDTH'b11000001: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b11000010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b11000011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11000100: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11000101: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b11000110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11000111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11001000: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11001001: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b11001010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b11001011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11001100: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11001101: data = 6'd2; // B
        `NOTE_WITH_SYMBOL_WIDTH'b11001110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11001111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11010000: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11010001: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b11010010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11010011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11010100: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11010101: data = 6'd3; // C
        `NOTE_WITH_SYMBOL_WIDTH'b11010110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b11010111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11011000: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11011001: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b11011010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11011011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11011100: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11011101: data = 6'd4; // D
        `NOTE_WITH_SYMBOL_WIDTH'b11011110: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b11011111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11100000: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11100001: data = 6'd5; // E
        `NOTE_WITH_SYMBOL_WIDTH'b11100010: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11100011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11100100: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11100101: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b11100110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11100111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11101000: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11101001: data = 6'd6; // F
        `NOTE_WITH_SYMBOL_WIDTH'b11101010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b11101011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11101100: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11101101: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b11101110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11101111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11110000: data = 6'd53; // 5
        `NOTE_WITH_SYMBOL_WIDTH'b11110001: data = 6'd7; // G
        `NOTE_WITH_SYMBOL_WIDTH'b11110010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b11110011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11110100: data = 6'd54; // 6
        `NOTE_WITH_SYMBOL_WIDTH'b11110101: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b11110110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11110111: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11111000: data = 6'd54; // 6
        `NOTE_WITH_SYMBOL_WIDTH'b11111001: data = 6'd1; // A
        `NOTE_WITH_SYMBOL_WIDTH'b11111010: data = 6'd35; // #
        `NOTE_WITH_SYMBOL_WIDTH'b11111011: data = 6'd32; // blank

        `NOTE_WITH_SYMBOL_WIDTH'b11111100: data = 6'd54; // 6
        `NOTE_WITH_SYMBOL_WIDTH'b11111101: data = 6'd2; // B
        `NOTE_WITH_SYMBOL_WIDTH'b11111110: data = 6'd32; // blank
        `NOTE_WITH_SYMBOL_WIDTH'b11111111: data = 6'd32; // blank
  
      endcase

endmodule