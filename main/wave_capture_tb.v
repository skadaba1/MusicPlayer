module wave_capture_tb ();

  reg clk;
  reg reset;
  reg new_sample_ready;
  reg [15:0] new_sample_in;
  reg wave_display_idle;

  wire [8:0] write_address;
  wire write_enable;
  wire [7:0] write_sample;
  wire read_index;

  wave_capture dut (
    clk,
    reset,
    new_sample_ready,
    new_sample_in,
    wave_display_idle,
    write_address,
    write_enable,
    write_sample,
    read_index
  );

  // Clock and reset
  initial begin
    $dumpfile("wave_capture_tb.vcd");
    $dumpvars(0, wave_capture_tb);

    clk = 1'b0;
    reset = 1'b1;
    repeat (4) #5 clk = ~clk;
    reset = 1'b0;
    forever #5 clk = ~clk;
  end

  initial begin
    new_sample_ready = 0;
    new_sample_in = 16'b0;
    wave_display_idle = 0;

    #25;
    @(negedge clk);
    new_sample_in = 16'hF23C;
    @(posedge clk);
    #1;
    if (write_address != 9'b100000000) begin
      $display("Write address should remain the same before new_sample_ready");
    end
    @(negedge clk);
    new_sample_ready = 1;
    @(posedge clk);
    #1;
    if (write_address != 9'b100000000) begin
      $display("Write address should remain the same before positive crossing");
    end
    // Step through writing to increment counter to max
    for (reg[31:0] i = 0; i < 256; i = i + 1) begin
      @(negedge clk);
      new_sample_ready = 0;
      new_sample_in = 16'h0245;
      @(negedge clk);
      new_sample_ready = 1;
      @(posedge clk);
    end

    @(posedge clk);
    // Should be in wait state now
    wave_display_idle = 1;
    @(posedge clk);
    #25;
    // Should be back in armed state  

    $finish;
  end

endmodule
