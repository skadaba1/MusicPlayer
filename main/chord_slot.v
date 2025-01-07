module chord_slot (
    input clk,
    input reset,
    input play_enable,
    input beat,
    input done_waiting, // UNUSED INPUT if waiter
    input load_new_note_this_slot,
    input [5:0] new_note,
    input [5:0] new_duration,
    output [5:0] curr_note,
    output [5:0] curr_duration,
    output [5:0] curr_elapsed,
    output [5:0] prev_note,
    output [5:0] prev_prev_note,
    output done
);
    parameter IS_WAITER = 0;

    dffre #(.WIDTH(6)) note_dff (
        .clk(clk),
        .r(reset),
        .en(load_new_note_this_slot), // TODO: check behavior of 0
        .d(new_note),
        .q(curr_note)
    );
    
    dffre #(.WIDTH(6)) prev_note_dff (
        .clk(clk),
        .r(reset),
        .en(load_new_note_this_slot),
        .d(curr_note),
        .q(prev_note)
    );

    dffre #(.WIDTH(6)) prev_prev_note_dff (
        .clk(clk),
        .r(reset),
        .en(load_new_note_this_slot),
        .d(prev_note),
        .q(prev_prev_note)
    );

    dffre #(.WIDTH(6)) duration_ff (
        .clk(clk),
        .r(reset),
        .en(load_new_note_this_slot),
        .d(new_duration),
        .q(curr_duration)
    );

    reg [5:0] new_elapsed;

    dffre #(.WIDTH(6)) curr_elapsed_ff(
        .clk(clk),
        .r(reset),
        .en(((beat && (IS_WAITER || !done_waiting)) || load_new_note_this_slot) && play_enable),
        .d(new_elapsed),
        .q(curr_elapsed)
    );

    always @(*) begin
        if (load_new_note_this_slot) begin
            new_elapsed = 6'b0;
        end
        else if (done) begin
            new_elapsed = curr_elapsed;
        end
        else begin
            new_elapsed = curr_elapsed + 6'd1;
        end
    end

    assign done = curr_elapsed == curr_duration;

endmodule
