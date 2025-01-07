module wave_display (
    input clk,
    input reset,
    input [10:0] x,
    input [9:0]  y,
    input valid,
    input [7:0] read_value,
    input read_index,
    output wire [8:0] read_address,
    output wire valid_pixel,
    output wire display
);

wire [7:0] read_value_adjusted = (read_value >> 1) + 8'd32;
assign read_address = {read_index, x[9], x[7:1]};

// Pass new x to get address first, then use it as enable signal to get value.
// This should take 2 cycles to propagate to align with RAM latency.
wire [8:0] p_address;
dffr #(.WIDTH(9)) p_address_ff (
  .clk(clk),
  .r(reset),
  .d(read_address),
  .q(p_address)
);

wire [7:0] p_value;
dffre #(.WIDTH(8)) p_value_ff (
  .clk(clk),
  .r(reset),
  .en(read_address != p_address),
  .d(read_value_adjusted),
  .q(p_value)
);

// Pixel should only be white if y value is between previous and current
assign display = (
    (y[8:1] >= p_value && y[8:1] <= read_value_adjusted) || 
    (y[8:1] <= p_value && y[8:1] >= read_value_adjusted)
) && valid;

// Pixel is valid to draw only if in the valid region
assign valid_pixel = valid && !y[9] && (x > 11'd258) && (x[8] ^ x[9]) ;

endmodule
