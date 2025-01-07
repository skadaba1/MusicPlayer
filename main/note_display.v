`define NOTE_WIDTH 6
`define NOTE_WITH_SYMBOL_WIDTH 8

module note_display (
    input [10:0] x1,
    input [9:0] y1,
    input [10:0] x,
    input [9:0]  y,
    input valid,
    input [`NOTE_WIDTH-1: 0] note,
    output wire display
);

// TODO: change these parameters later
// NOTE: x1, x2, y1, y2 IS THE ONLY THING CHECKING VALIDITY!!! we don't have valid_pixel anymore.
wire [10:0] x2 = x1 + 11'd32;
wire [9:0] y2 = y1 + 10'd8;

// 8 x 32 block, 4 characters
// pos is which of the 4 characters it is
// char_x is which horizontal position in the pixel render the character is
// char_y is what row in the pixel render of the character it is
// row_bitmap is the actual bitmap of the character's pixel render at row char_y

wire [10:0] pos_full = (x - x1) >> 3;
wire [1:0] pos = pos_full[1:0];
wire [`NOTE_WITH_SYMBOL_WIDTH-1 :0] note_rom_addr = (x1 <= x && x < x2 && y1 <= y && y < y2) ? {note, pos} : 0;
wire [5:0] char_addr;

note_rom note_rommy (.addr(note_rom_addr), .data(char_addr));

wire [9:0] char_y_full = y - y1;
wire [2:0] char_y = char_y_full[2:0];
wire [10:0] char_x_full = x - (x1 + {9'd0, pos} << 3);
wire [2:0] char_x = char_x_full[2:0];
wire [7:0] char_row_bitmap;

tcgrom tcgrommy (.addr({char_addr, char_y}), .data(char_row_bitmap));

assign display = valid && |(char_row_bitmap & (8'd128 >> char_x));

endmodule