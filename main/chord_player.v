
// time constants in seconds 
module chord_player (
    input  clk,
    input  reset,
    input  play_enable,         
    input  harmonics_button,
    input  [5:0] note_to_load,  
    input  [5:0] duration,      
    input  load_new_note,       
    input  waiting,            
    input  beat,                
    input  generate_next_sample,
    input activate_dynamics,
	output note_done,
    output signed [15:0] sample1,             
    output signed [15:0] sample2, 
    output signed [15:0] sample3,             
    output signed [15:0] sample_out,             
    output done_waiting,
    output sample_ready,
    output [17:0] curr_notes,
    output [17:0] prev_notes,
    output [17:0] prev_prev_notes
);

reg [3:0] load_new_notes; 
wire [3:0] notes_done;
assign done_waiting = notes_done[0];

wire [5:0] curr_note_1, curr_note_2, curr_note_3, curr_note_4;
wire [5:0] curr_duration_1, curr_duration_2, curr_duration_3, curr_duration_4; // NOTE: curr_duration_4 is unused
wire [5:0] curr_elapsed_1, curr_elapsed_2, curr_elapsed_3, curr_elapsed_4; // NOTE: curr_duration_4 is unused
wire [5:0] prev_note_1, prev_note_2, prev_note_3, prev_note_4;
wire [5:0] prev_prev_note_1, prev_prev_note_2, prev_prev_note_3, prev_prev_note_4;

chord_slot slot1(
    .clk(clk),
    .reset(reset),
    .play_enable(play_enable),
    .beat(beat),
    .done_waiting(done_waiting),
    .load_new_note_this_slot(load_new_notes[3]),
    .new_note(note_to_load),
    .new_duration(duration),
    .curr_note(curr_note_1),
    .curr_duration(curr_duration_1),
    .curr_elapsed(curr_elapsed_1),
    .prev_note(prev_note_1),
    .prev_prev_note(prev_prev_note_1),
    .done(notes_done[3])
);

chord_slot slot2(
    .clk(clk),
    .reset(reset),
    .play_enable(play_enable),
    .beat(beat),
    .done_waiting(done_waiting),
    .load_new_note_this_slot(load_new_notes[2]),
    .new_note(note_to_load),
    .new_duration(duration),
    .curr_note(curr_note_2),
    .curr_duration(curr_duration_2),
    .curr_elapsed(curr_elapsed_2),
    .prev_note(prev_note_2),
    .prev_prev_note(prev_prev_note_2),
    .done(notes_done[2])
);

chord_slot slot3(
    .clk(clk),
    .reset(reset),
    .play_enable(play_enable),
    .beat(beat),
    .done_waiting(done_waiting),
    .load_new_note_this_slot(load_new_notes[1]),
    .new_note(note_to_load),
    .new_duration(duration),
    .curr_note(curr_note_3),
    .curr_duration(curr_duration_3),
    .curr_elapsed(curr_elapsed_3),
    .prev_note(prev_note_3),
    .prev_prev_note(prev_prev_note_3),
    .done(notes_done[1])
);

chord_slot #(.IS_WAITER(1)) slot4(
    .clk(clk),
    .reset(reset),
    .play_enable(play_enable),
    .beat(beat),
    .done_waiting(1'b1),
    .load_new_note_this_slot(load_new_notes[0]),
    .new_note(note_to_load),
    .new_duration(duration),
    .curr_note(curr_note_4),
    .curr_duration(curr_duration_4),
    .curr_elapsed(curr_elapsed_4),
    .prev_note(prev_note_4),
    .prev_prev_note(prev_prev_note_4),
    .done(notes_done[0])
);

assign curr_notes = {curr_note_1, curr_note_2, curr_note_3};
assign prev_notes = {prev_note_1, prev_note_2, prev_note_3};
assign prev_prev_notes = {prev_prev_note_1, prev_prev_note_2, prev_prev_note_3};

wire  [23:0] curr_durations;
assign curr_durations = {curr_duration_1, curr_duration_2, curr_duration_3, curr_duration_4};

wire  [17:0] curr_elapsed;
assign curr_elapsed = {curr_elapsed_1, curr_elapsed_2, curr_elapsed_3};

wire enable_harmonics;
dffre harmonics_ff (
   .clk(clk),
   .r(reset),
   .en(harmonics_button),
   .d(~enable_harmonics),
   .q(enable_harmonics)
);

always @(*) begin
    if (waiting && load_new_note && done_waiting) begin
        load_new_notes = {1'b0, 1'b0, 1'b0, load_new_note};
    end else if (notes_done[3] && load_new_note) begin
        load_new_notes = {load_new_note, 1'b0, 1'b0, 1'b0};
    end else if (notes_done[2] && load_new_note) begin
        load_new_notes = {1'b0, load_new_note, 1'b0, 1'b0};
    end else if (notes_done[1] && load_new_note) begin
        load_new_notes = {1'b0, 1'b0, load_new_note, 1'b0};
    end else begin 
        load_new_notes = {1'b0, 1'b0, 1'b0, 1'b0};
    end
end

wire signed [15:0] note_sample_1, note_sample_2, note_sample_3;
wire note_ready_1, note_ready_2, note_ready_3;
wire signed [15:0] overflow_final;

note_player player_1 (
	.clk(clk),
	.reset(reset),
	.play_enable(play_enable),
	.enable_harmonics(enable_harmonics),
	.generate_next_sample(generate_next_sample),
	.note_done(notes_done[3]),
	.note_to_load(note_to_load),
	.load_new_note(load_new_notes[3]),
	.sample_ready(note_ready_1),
	.sample_out(note_sample_1)
);
	
note_player player_2 (
	.clk(clk),
	.reset(reset),
	.play_enable(play_enable),
	.enable_harmonics(enable_harmonics),
	.generate_next_sample(generate_next_sample),
	.note_done(notes_done[2]),
	.note_to_load(note_to_load),
	.load_new_note(load_new_notes[2]),
	.sample_ready(note_ready_2),
	.sample_out(note_sample_2)
);

note_player player_3 (
	.clk(clk),
	.reset(reset),
	.play_enable(play_enable),
    .enable_harmonics(enable_harmonics),
	.generate_next_sample(generate_next_sample),
	.note_done(notes_done[1]),
	.note_to_load(note_to_load),
	.load_new_note(load_new_notes[1]),
	.sample_ready(note_ready_3),
	.sample_out(note_sample_3)
);

wire signed [15:0] dynamic_sample_1, dynamic_sample_2, dynamic_sample_3;
wire dynamic_ready_1, dynamic_ready_2, dynamic_ready_3;

dynamics dyn_1 (
    .clk(clk),
    .reset(reset),
    .activate_dynamics(activate_dynamics),
    .elapsed_in(curr_elapsed_1),
    .curr_duration_in(curr_duration_1),
    .note_sample_in(note_sample_1),
    .sample_ready_in(note_ready_1),
    .sample_out(dynamic_sample_1),
    .sample_ready(dynamic_ready_1)
);

dynamics dyn_2 (
    .clk(clk),
    .reset(reset),
    .activate_dynamics(activate_dynamics),
    .elapsed_in(curr_elapsed_2),
    .curr_duration_in(curr_duration_2),
    .note_sample_in(note_sample_2),
    .sample_ready_in(note_ready_2),
    .sample_out(dynamic_sample_2),
    .sample_ready(dynamic_ready_2)
);

dynamics dyn_3 (
    .clk(clk),
    .reset(reset),
    .activate_dynamics(activate_dynamics),
    .elapsed_in(curr_elapsed_3),
    .curr_duration_in(curr_duration_3),
    .note_sample_in(note_sample_3),
    .sample_ready_in(note_ready_3),
    .sample_out(dynamic_sample_3),
    .sample_ready(dynamic_ready_3)
);

assign {sample1, sample2, sample3} = {dynamic_sample_1, dynamic_sample_2, dynamic_sample_3};
assign overflow_final = (dynamic_sample_1 >>> 2) + (dynamic_sample_2 >>> 2) + (dynamic_sample_3 >>> 2);
assign note_done = |notes_done;
assign sample_ready = dynamic_ready_1 || dynamic_ready_2 || dynamic_ready_3;
assign sample_out = overflow_final;

// Better version here
// wire signed [17:0] dynamic_sample_big_1, dynamic_sample_big_2, dynamic_sample_big_3;
// wire signed [17:0] overflow_final;

// assign dynamic_sample_big_1 = {{2{dynamic_sample_1[15]}}, dynamic_sample_1};
// assign dynamic_sample_big_2 = {{2{dynamic_sample_2[15]}}, dynamic_sample_2};
// assign dynamic_sample_big_3 = {{2{dynamic_sample_3[15]}}, dynamic_sample_3};
// assign overflow_final = (dynamic_sample_big_1 + dynamic_sample_big_2 + dynamic_sample_big_3) >>> 2;
// assign sample_out = overflow_final[15:0];

// assign note_done = |notes_done;
// assign sample_ready = dynamic_ready_1 || dynamic_ready_2 || dynamic_ready_3;

endmodule
