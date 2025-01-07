`define ARMED 2'b00
`define ACTIVE 2'b01
`define WAIT 2'b10

module wave_capture (
    input clk,
    input reset,
    input new_sample_ready,
    input [15:0] new_sample_in,
    input wave_display_idle,

    output wire [8:0] write_address,
    output wire write_enable,
    output wire [7:0] write_sample,
    output wire read_index
);

wire [7:0] counter;

wire [15:0] curr_sample, prev_sample;

wire crossing = prev_sample[15] && !curr_sample[15]; 

assign write_enable = state == `ACTIVE;

assign write_address = {~read_index, counter};

assign write_sample = {~curr_sample[15], curr_sample[14:8]};

// Flip flop for incrementing counter
// Only increment when we are about to enter ACTIVE state, during ACTIVE state,
// and reset when we are in the WAIT state
dffre #(.WIDTH(8)) counter_ff (
  .clk(clk),
  .r(reset || state == `WAIT),
  .en(new_sample_ready),
  .d(
    ((state == `ARMED && crossing) || state == `ACTIVE) ? counter + 8'b1 : 8'b0),
  .q(counter)
);

// Flip flops for computing positive crossing
dffre #(.WIDTH(16)) sample_ff (
  .clk(clk),
  .r(reset),
  .en(new_sample_ready),
  .d(new_sample_in),
  .q(curr_sample)
);

dffre #(.WIDTH(16)) prev_sample_ff (
  .clk(clk),
  .r(reset),
  .en(new_sample_ready),
  .d(curr_sample),
  .q(prev_sample)
);

// Flip read index only when we are about to go back to ARMED state
dffr #(.WIDTH(1)) read_index_ff (
  .clk(clk),
  .r(reset),
  .d(state == `WAIT && wave_display_idle ? ~read_index : read_index),
  .q(read_index)
);

reg [1:0] next_state;
wire [1:0] state;

// Control FSM
dffr #(.WIDTH(2)) fsm_ff(.clk(clk), .r(reset), .d(next_state), .q(state));

always @(*) begin
	case(state)
    `ARMED: next_state = crossing ? `ACTIVE : `ARMED;
    `ACTIVE: next_state = (counter == ~8'd0) ? `WAIT : `ACTIVE;
    `WAIT: next_state = wave_display_idle ?  `ARMED : `WAIT;
    default: next_state = `ARMED;
	endcase
end

endmodule
