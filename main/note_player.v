module note_player(
    input  clk,
    input  reset,
    input  play_enable,         // When high we play, when low we don't.
    input  enable_harmonics,
    input  [5:0] note_to_load,  // The note to play
    input  load_new_note,       // Tells us when we have a new note to load
    input  note_done,           // Informs create_harmonic how the weight of each harmony
    input  generate_next_sample,// Tells us when the codec wants a new sample
    output signed [15:0] sample_out, // Our sample output
    output sample_ready       // Tells the codec when we've got a sample
);

    wire [5:0] freq_rom_in;
    wire [19:0] step_size;

    dffre #(.WIDTH(6)) np_freq_reg (
        .clk(clk),
        .r(reset),
        .en(load_new_note),
        .d(note_to_load),
        .q(freq_rom_in)
    );

    frequency_rom np_freq_rom(
        .clk(clk),
        .addr(freq_rom_in),
        .dout(step_size)
    );

    wire signed [15:0] out, out_harm1, out_harm2;
    wire signed [15:0] out_temp, out_temp_harm1, out_temp_harm2;
    wire signed [17:0] overflow;
    wire ready_temp, ready_temp_harm1, ready_temp_harm2;
    wire ready, ready_harm1, ready_harm2;
    
    wire [19:0] step_size_div2, step_size_div4;
    
    assign step_size_div2 = step_size << 1;
    assign step_size_div4 = step_size << 2;

    // create harmonics by adding sine waves which are multiples of fundamental frequency
    sine_reader harmonic_sine_read1(
        .clk(clk),
        .reset(reset),
        .step_size(step_size),
        .generate_next(!note_done && play_enable && generate_next_sample),
        .sample_ready(ready_temp),
        .sample(out_temp)
    );
    
    sine_reader harmonic_sine_read2(
        .clk(clk),
        .reset(reset),
        .step_size(step_size_div2),
        .generate_next(!note_done && play_enable && generate_next_sample),
        .sample_ready(ready_temp_harm1),
        .sample(out_temp_harm1)
    );

    sine_reader harmonic_sine_read3(
        .clk(clk),
        .reset(reset),
        .step_size(step_size_div4),
        .generate_next(!note_done && play_enable && generate_next_sample),
        .sample_ready(ready_temp_harm2),
        .sample(out_temp_harm2)
    );

    dffr #(.WIDTH(48)) out_delay (
        .clk(clk),
        .r(reset),
        .d({out_temp, out_temp_harm1, out_temp_harm2}),
        .q({out, out_harm1, out_harm2})
    );

    dffr #(.WIDTH(3)) ready_delay (
        .clk(clk),
        .r(reset),
        .d({ready_temp, ready_temp_harm1, ready_temp_harm2}),
        .q({ready, ready_harm1, ready_harm2})
    );
    
    /************** DEFINE HARMONICS ****************/
//    ((out >>> 1) + (out_harm1 >>> 2) + (out_harm2 >>> 3))
    assign overflow = (enable_harmonics == 1'b0) ? out : ((out >>> 1) + (out_harm1 >>> 2) + (out_harm2 >>> 3));
    assign sample_out = overflow >>> 2;
    assign sample_ready = ready && ready_harm1 && ready_harm2;
    
endmodule
