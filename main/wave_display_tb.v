module wave_display_tb;

  // Testbench Inputs
  reg tb_clk;
  reg tb_reset, tb_valid, tb_read_index;
  reg [10:0] tb_x;
  reg [9:0] tb_y;
  wire [7:0] tb_read_value;

  // Testbench Outputs
  wire [8:0] tb_read_addr;
  wire tb_valid_pixel;
  wire [7:0] tb_red, tb_green, tb_blue;
  reg [7:0] tb_read_value_reg; // intermediate reg variable

  // DUT Instance
  wave_display wd_inst(
    .clk(tb_clk), .reset(tb_reset), .x(tb_x), .y(tb_y),
    .valid(tb_read_index), .read_value(tb_read_value),
    .read_index(tb_read_index), .read_address(tb_read_addr),
    .valid_pixel(tb_valid_pixel), .r(tb_red), .b(tb_blue), .g(tb_green)
  );

  // Instantiate Fake Memory Module
  fake_sample_ram fsm_inst (
    .clk(tb_clk),
    .addr(tb_read_addr),
    .dout(tb_read_value)
  );

  // Clock Generator
  initial begin
    tb_clk = 1'b0;
    forever #2 tb_clk = ~tb_clk;

    // Reset
    tb_reset = 1'b1;
    #4;
    tb_reset = 1'b0;
    #4;
  end

  // Test Scenario
  initial begin
    // Initialize testbench variables
    tb_reset = 0;
    tb_valid = 1'b1;
    tb_x = 11'b00100000000;
    tb_y = 10'b0;
    tb_read_value_reg = 8'b0;
    tb_read_index = 1;
    
    #1 tb_read_value_reg = 8'b11111111;

    // Draw a horizontal line
    #12;

    
    // Nested loop (commented out for simplicity)
    for (tb_y = 10'b0; tb_y <= 10'd1023; tb_y = tb_y + 10'd10) begin
      for (tb_x = 11'b0; tb_x <= 11'd1023; tb_x = tb_x + 11'd10) begin
        #4;
      end
    end
    

    $finish;
  end

endmodule
