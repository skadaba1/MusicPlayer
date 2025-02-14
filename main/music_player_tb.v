module music_player_tb();
    reg clk, reset, next_button, play_button, harmonics_button, dynamics_switch;
    wire new_frame;
    wire [15:0] sample;
    
    music_player #(.BEAT_COUNT(100)) music_player(
        .clk(clk),
        .reset(reset),
        .next_button(next_button),
        .play_button(play_button),
        .harmonics_button(harmonics_button),
        .dynamics_switch(dynamics_switch),
        .new_frame(new_frame),
        .sample_out(sample)
    );

    // AC97 interface
    wire AC97Reset_n;        // Reset signal for AC97 controller/clock
    wire SData_Out;          // Serial data out (control and playback data)
    wire Sync;               // AC97 sync signal

    // Our codec simulator
    ac97_if codec(
        .Reset(1'b0), // Reset MUST be shorted to 1'b0
        .ClkIn(clk),
        .PCM_Playback_Left(sample),   // Set these two to different
        .PCM_Playback_Right(sample),  // samples to have stereo audio!
        .PCM_Record_Left(),
        .PCM_Record_Right(),
        .PCM_Record_Valid(),
        .PCM_Playback_Accept(new_frame),  // Asserted each sample
        .AC97Reset_n(AC97Reset_n),
        .AC97Clk(1'b0),
        .Sync(Sync),
        .SData_Out(SData_Out),
        .SData_In(1'b0)
    );

    // Clock and reset
    initial begin
        $dumpfile("music_player_tb.vcd");
        $dumpvars(0, music_player_tb);
        clk = 1'b0;
        reset = 1'b1;
        repeat (4) #5 clk = ~clk;
        reset = 1'b0;
        forever #5 clk = ~clk;
    end

    // Tests
    initial begin
        play_button = 1'b0;
        next_button = 1'b0;
        harmonics_button = 1'b0;
        dynamics_switch = 1'b0;
   
        @(negedge reset);
        @(negedge clk);

        repeat (25) begin
            @(negedge clk);
        end 

        // Start playing
        $display("Playing first song...");
        @(negedge clk);
        play_button = 1'b1;
        next_button = 1'b0;

        @(negedge clk);
        play_button = 1'b0;

        repeat (500000) begin
            @(negedge clk);
        end 
        
        // reset = 1;
        // dynamics_switch = 1'b1;
        // @(negedge clk);
        // reset = 0;

        // repeat (300000) begin
        //     @(negedge clk);
        // end 
        
        // next_button = 1'b1;
        // @(negedge clk);
        // next_button = 1'b0;
        // play_button = 1'b1;
        // @(negedge clk);
        // play_button = 1'b0;
        
        repeat (2000000) begin
            @(negedge clk);
        end
        
        // Song 2
        play_button = 1'b1;
        @(negedge clk);
        play_button = 1'b0;

        repeat (3000000) begin
            @(negedge clk);
        end
        
            
        $finish;
    end


endmodule