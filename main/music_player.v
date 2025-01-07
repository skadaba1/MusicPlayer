//
//  music_player module
//
//  This music_player module connects up the MCU, song_reader, note_player,
//  beat_generator, and codec_conditioner. It provides an output that indicates
//  a new sample (new_sample_generated) which will be used in lab 5.
//
`define MAX_BEATS_WIDTH 14

module music_player(
    // Standard system clock and reset
    input clk,
    input reset,

    // Our debounced and one-pulsed button inputs.
    input play_button,
    input next_button,
    input harmonics_button,

    // The raw new_frame signal from the ac97_if codec.
    input new_frame,
    input dynamics_switch,
    input echo_switch,

    // This output must go high for one cycle when a new sample is generated.
    output wire new_sample_generated,

    // Our final output sample to the codec. This needs to be synced to
    // new_frame.
    output wire [15:0] sample1_out,
    output wire [15:0] sample2_out,
    output wire [15:0] sample3_out,
    output wire [15:0] sample_out,
    output wire [17:0] curr_notes,
    output wire [17:0] prev_notes,
    output wire [17:0] prev_prev_notes
);
    // The BEAT_COUNT is parameterized so you can reduce this in simulation.
    // If you reduce this to 100 your simulation will be 10x faster.
    parameter BEAT_COUNT = 100; //1000

//
//  ****************************************************************************
//      Master Control Unit
//  ****************************************************************************
//   The reset_player output from the MCU is run only to the song_reader because
//   we don't need to reset any state in the note_player. If we do it may make
//   a pop when it resets the output sample.
//

    wire play;
    wire reset_player;
    wire song_done;
    wire [1:0] current_song;

    mcu mcu(
        .clk(clk),
        .reset(reset),
        .play_button(play_button),
        .next_button(next_button),
        .play(play),
        .reset_player(reset_player),
        .song(current_song),
        .song_done(song_done)
    );

//
//  ****************************************************************************
//      Song Reader
//  ****************************************************************************
//
    wire [5:0] note_to_play;
    wire [5:0] duration_for_note;
    wire beat;
    
    wire [`MAX_BEATS_WIDTH - 1:0]  beat_count;
    reg  [`MAX_BEATS_WIDTH - 1:0] next_beat_count;
    
//    dffre #(.WIDTH(`MAX_BEATS_WIDTH)) county(.clk(clk), .r(reset | song_done), .e(beat), .d(next_beat_count), .q(beat_count));
    
//    always @(*) begin
//        next_beat_count = beat_count + 1;
//    end
    
    wire new_note, note_done;
    wire waiting, done_waiting;
    
    song_reader song_reader(
        .clk(clk),
        .reset(reset | reset_player),
        .play(play),
        .waiting(waiting),
        .done_waiting(done_waiting),
        .song(current_song),
        .note_done(note_done),
        .song_done(song_done),
        .note(note_to_play),
        .duration(duration_for_note),
        .new_note(new_note)
    );

//   
//  ****************************************************************************
//      Chord Player
//  ****************************************************************************
//  
    wire generate_next_sample;
    wire signed [15:0] chord_sample, final_sample, summed, echo_sample;
    wire [15:0] sample1, sample2, sample3;
    wire chord_sample_ready, echo_sample_ready_const, echo_sample_ready_pulse;

    chord_player cp(
        .clk(clk),
        .reset(reset),
        .play_enable(play),
        .harmonics_button(harmonics_button),
        .note_to_load(note_to_play) ,        
        .duration(duration_for_note),   
        .load_new_note(new_note),      
        .waiting(waiting),        
        .done_waiting(done_waiting),
        .beat(beat),                
        .generate_next_sample(generate_next_sample),
        .sample1(sample1),
        .sample2(sample2),
        .sample3(sample3),
        .sample_out(chord_sample),
        .note_done(note_done),          
        .sample_ready(chord_sample_ready),
        .curr_notes(curr_notes),
        .prev_notes(prev_notes),
        .prev_prev_notes(prev_prev_notes),
        .activate_dynamics(dynamics_switch)
    );
//   
//  ****************************************************************************
//      Echo
//  ****************************************************************************
//  Intercepts sample to condec and adds a delayed, attenuated version of it
//  
    
     echo #(.WIDTH(24)) echoer(
         .clk(clk),
         .reset(reset),
         .beat(beat),
         .sample_in_ready(chord_sample_ready),
         .sample_in(chord_sample),
         .sample_out(echo_sample),
         .song_done(song_done),
         .echo_out_ready_pulse(echo_sample_ready_pulse),
         .sample_out_ready(echo_sample_ready_const)
     );
     assign summed = ((echo_sample >>> 2) + (chord_sample >>> 1));
     assign final_sample = (echo_sample_ready_const && echo_switch) ? summed : chord_sample;
//     assign final_sample = chord_sample;
      
//   
//  ****************************************************************************
//      Beat Generator
//  ****************************************************************************
//  By default this will divide the generate_next_sample signal (48kHz from the
//  codec's new_frame input) down by 1000, to 48Hz. If you change the BEAT_COUNT
//  parameter when instantiating this you can change it for simulation.
//  

    beat_generator #(.WIDTH(10), .STOP(BEAT_COUNT)) beat_generator(
        .clk(clk),
        .reset(reset),
        .en(generate_next_sample),
        .beat(beat)
    );

//  
//  ****************************************************************************
//      Codec Conditioner
//  ****************************************************************************
//  
    wire generate_next_sample_1, generate_next_sample_2, generate_next_sample_3;
    assign new_sample_generated = generate_next_sample;
    codec_conditioner codec_conditioner(
        .clk(clk),
        .reset(reset),
        .new_sample_in(final_sample),
        .latch_new_sample_in(chord_sample_ready),
        .generate_next_sample(generate_next_sample),
        .new_frame(new_frame),
        .valid_sample(sample_out)
    );
    codec_conditioner codec_conditioner1(
        .clk(clk),
        .reset(reset),
        .new_sample_in(sample1),
        .latch_new_sample_in(chord_sample_ready),
        .generate_next_sample(generate_next_sample_1),
        .new_frame(new_frame),
        .valid_sample(sample1_out)
    );
    codec_conditioner codec_conditioner2(
        .clk(clk),
        .reset(reset),
        .new_sample_in(sample2),
        .latch_new_sample_in(chord_sample_ready),
        .generate_next_sample(generate_next_sample_2),
        .new_frame(new_frame),
        .valid_sample(sample2_out)
    );
    codec_conditioner codec_conditioner3(
        .clk(clk),
        .reset(reset),
        .new_sample_in(sample3),
        .latch_new_sample_in(chord_sample_ready),
        .generate_next_sample(generate_next_sample_3),
        .new_frame(new_frame),
        .valid_sample(sample3_out)
    );

endmodule
