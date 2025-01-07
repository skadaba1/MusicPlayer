module display_top (
    input clk,
    input reset,
    input new_sample,
    input [15:0] flopped_chord_sample,
    input [15:0] flopped_sample1,
    input [15:0] flopped_sample2,
    input [15:0] flopped_sample3,
    input [17:0] notes_to_play,
    input [17:0] prev_notes_to_play,
    input [17:0] prev_prev_notes_to_play,
    input [10:0] x,
    input [9:0] y,
    input display_ready,
    input vsync,
    output [7:0] r,
    output [7:0] g,
    output [7:0] b
);
    parameter TEXT_X1 = 88;
    parameter TEXT_Y1 = 336;
    parameter W = 800;
    parameter H = 176;

    wire display_chord, display_wd1, display_wd2, display_wd3;
    wire display_nd1_curr, display_nd2_curr, display_nd3_curr;
    wire display_nd1_prev, display_nd2_prev, display_nd3_prev;
    wire display_nd1_prev_prev, display_nd2_prev_prev, display_nd3_prev_prev;

    wave_display_top wd_chord (
        .clk (clk),
        .reset (reset),
        .new_sample (new_sample),
        .sample (flopped_chord_sample),
        .x(x),
        .y(y),
        .valid(display_ready),
        .vsync(vsync),
        .display(display_chord)
    );

    wave_display_top #(.R(8'd255), .G(8'd0), .B(8'd0)) wd1 (
        .clk (clk),
        .reset (reset),
        .new_sample (new_sample),
        .sample (flopped_sample1),
        .x(x),
        .y(y),
        .valid(display_ready),
        .vsync(vsync),
        .display(display_wd1)
    );

    wave_display_top #(.R(8'd0), .G(8'd255), .B(8'd0)) wd2 (
        .clk (clk),
        .reset (reset),
        .new_sample (new_sample),
        .sample (flopped_sample2),
        .x(x),
        .y(y),
        .valid(display_ready),
        .vsync(vsync),
        .display(display_wd2)
    );

    wave_display_top #(.R(8'd0), .G(8'd0), .B(8'd255)) wd3 (
        .clk (clk),
        .reset (reset),
        .new_sample (new_sample),
        .sample (flopped_sample3),
        .x(x),
        .y(y),
        .valid(display_ready),
        .vsync(vsync),
        .display(display_wd3)
    );

    wire [7:0] r_nd1_curr, g_nd1_curr, b_nd1_curr;
    note_display nd1_curr(
        .x1(TEXT_X1 + W / 2 - 16),
        .y1(TEXT_Y1 + 32),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(notes_to_play[17:12]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd1_curr)
    );

    wire [7:0] r_nd2_curr, g_nd2_curr, b_nd2_curr;
    note_display nd2_curr(
        .x1(TEXT_X1 + W / 2 + 16),
        .y1(TEXT_Y1 + 32),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(notes_to_play[11:6]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd2_curr)
    );

    wire [7:0] r_nd3_curr, g_nd3_curr, b_nd3_curr;
    note_display nd3_curr(
        .x1(TEXT_X1 + W / 2 + 48),
        .y1(TEXT_Y1 + 32),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(notes_to_play[5:0]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd3_curr)
    );
    
    wire [7:0] r_nd1_prev, g_nd1_prev, b_nd1_prev;
    note_display nd1_prev(
        .x1(TEXT_X1 + W / 2 - 16),
        .y1(TEXT_Y1 + 16),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(prev_notes_to_play[17:12]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd1_prev)
    );

    wire [7:0] r_nd2_prev, g_nd2_prev, b_nd2_prev;
    note_display nd2_prev(
        .x1(TEXT_X1 + W / 2 + 16),
        .y1(TEXT_Y1 + 16),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(prev_notes_to_play[11:6]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd2_prev)
    );

    wire [7:0] r_nd3_prev, g_nd3_prev, b_nd3_prev;
    note_display nd3_prev(
        .x1(TEXT_X1 + W / 2 + 48),
        .y1(TEXT_Y1 + 16),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(prev_notes_to_play[5:0]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd3_prev)
    );

    wire [7:0] r_nd1_prev_prev, g_nd1_prev_prev, b_nd1_prev_prev;
    note_display nd1_prev_prev(
        .x1(TEXT_X1 + W / 2 - 16),
        .y1(TEXT_Y1),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(prev_prev_notes_to_play[17:12]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd1_prev_prev)
    );

    wire [7:0] r_nd2_prev_prev, g_nd2_prev_prev, b_nd2_prev_prev;
    note_display nd2_prev_prev(
        .x1(TEXT_X1 + W / 2 + 16),
        .y1(TEXT_Y1),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(prev_prev_notes_to_play[11:6]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd2_prev_prev)
    );

    wire [7:0] r_nd3_prev_prev, g_nd3_prev_prev, b_nd3_prev_prev;
    note_display nd3_prev_prev(
        .x1(TEXT_X1 + W / 2 + 48),
        .y1(TEXT_Y1),
        .x(x),
        .y(y),
        .valid(display_ready),
        .note(prev_prev_notes_to_play[5:0]), // TODO: add vsync -> wave_display_idle ? so that the display is idle. Let's see.
        .display(display_nd3_prev_prev)
    );

    // IMPORTANT: merge all together
    assign r = {8{
      display_wd1 | display_chord |
      display_nd1_curr | display_nd1_prev | display_nd1_prev_prev |
      display_nd2_curr | display_nd2_prev | display_nd2_prev_prev |
      display_nd3_curr | display_nd3_prev | display_nd3_prev_prev
    }};

    assign g = {8{
      display_wd2 | display_chord |
      display_nd1_curr | display_nd1_prev | display_nd1_prev_prev |
      display_nd2_curr | display_nd2_prev | display_nd2_prev_prev |
      display_nd3_curr | display_nd3_prev | display_nd3_prev_prev
    }};

    assign b = {8{
      display_wd3 | display_chord |
      display_nd1_curr | display_nd1_prev | display_nd1_prev_prev |
      display_nd2_curr | display_nd2_prev | display_nd2_prev_prev |
      display_nd3_curr | display_nd3_prev | display_nd3_prev_prev
    }};

endmodule
