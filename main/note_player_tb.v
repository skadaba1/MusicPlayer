module note_player_tb();

    reg clk, reset, play_enable, generate_next_sample;
    reg [5:0] note_to_load;
    reg load_new_note;
    reg note_done;
    wire [15:0] sample_out;
    
    reg enable_harmonics;

    note_player np(
        .clk(clk),
        .reset(reset),
        .enable_harmonics(enable_harmonics),
        .play_enable(play_enable),
        .note_to_load(note_to_load),
        .load_new_note(load_new_note),
        .note_done(note_done),
        .generate_next_sample(generate_next_sample),
        .sample_out(sample_out)
    );

//    beat_generator #(.WIDTH(17), .STOP(1500)) beat_generator(
//        .clk(clk),
//        .reset(reset),
//        .en(1'b1),
//        .beat(beat)
//    );

    // Clock and reset
    initial begin
        clk = 1'b0;
        reset = 1'b1;
        repeat (4) #5 clk = ~clk;
        reset = 1'b0;
        forever #5 clk = ~clk;
    end
    
    always #30 begin
        generate_next_sample = 1;
        #10;
        generate_next_sample = 0;
    end

    // Tests
    initial begin
        enable_harmonics = 1'b0;
        note_done = 1'b0;
        note_to_load = 6'd1;
//        duration_to_load = 6'b10;
        play_enable = 1'b0;
        
        @(negedge reset);
        #15;
        load_new_note = 1'b1;
        
        @(negedge clk);
        load_new_note = 1'b0;
        play_enable = 1'b1;
        #80000;
        play_enable = 1'b0;
        #40000;
        
        @(negedge clk);
        enable_harmonics = 1'b1;
        play_enable = 1'b1;
        load_new_note = 1'b1;
        note_to_load = 6'd13;
        
        @(negedge clk);
        load_new_note = 1'b0;
        
        #80000;
        $finish;
    end

endmodule
