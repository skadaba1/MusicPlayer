`define TAIL_REGION 6'b001000

module dynamics (
    input clk,
    input reset,
    input activate_dynamics,
    input [5:0] elapsed_in,
    input [5:0] curr_duration_in,
    input signed [15:0] note_sample_in,
    input sample_ready_in,
    output wire signed [15:0] sample_out,
    output sample_ready
);
    wire sample_almost_ready, sample_almost_almost_ready;
    wire signed [15:0] note_sample;
    wire [5:0] elapsed;
    wire [5:0] curr_duration;

    dffre #(.WIDTH(16)) sample_delay_ff (
        .clk(clk),
        .r(reset),
        .en(sample_ready_in),
        .d(note_sample_in),
        .q(note_sample)
    );

    dffre #(.WIDTH(6)) elapsed_delay_ff (
        .clk(clk),
        .r(reset),
        .en(sample_ready_in),
        .d(elapsed_in),
        .q(elapsed)
    );

    dffre #(.WIDTH(6)) duration_delay_ff (
        .clk(clk),
        .r(reset),
        .en(sample_ready_in),
        .d(curr_duration_in),
        .q(curr_duration)
    );

    dffr sample_ready_delay_ff (
        .clk(clk),
        .r(reset),
        .d(sample_ready_in),
        .q(sample_almost_almost_ready)
    );

    dffr sample_ready_delay_ff_2 (
        .clk(clk),
        .r(reset),
        .d(sample_almost_almost_ready),
        .q(sample_almost_ready)
    );
    
    dffr sample_ready_delay_ff_3 (
        .clk(clk),
        .r(reset),
        .d(sample_almost_ready),
        .q(sample_ready)
    );

    wire [5:0] remaining = curr_duration - elapsed;

    wire signed [18:0] linear_crescendo_sample_full = ({ {3{note_sample[15]}}, note_sample } * elapsed[2:0]) >>> 3;
    wire signed [15:0] linear_crescendo_sample = linear_crescendo_sample_full[15:0];
    wire signed [15:0] descrecendo_sample = note_sample >>> ((`TAIL_REGION - remaining) >> 1);
    reg signed [15:0] sample_out_temp;

    always @(*) begin
        if (activate_dynamics) begin
            if (elapsed < `TAIL_REGION) begin
                sample_out_temp = linear_crescendo_sample; 
            end else if (remaining < `TAIL_REGION) begin
                sample_out_temp = descrecendo_sample;
            end else begin
                sample_out_temp = note_sample;
            end
        end else begin
            sample_out_temp = note_sample;
        end
    end
    
    dffr #(.WIDTH(16)) sample_out_delay (
        .clk(clk),
        .r(reset),
        .d(sample_out_temp),
        .q(sample_out)
    );
    
endmodule 