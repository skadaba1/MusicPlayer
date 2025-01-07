module sine_reader_tb();
    reg clk, reset, generate_next;
    reg [19:0] step_size;
    wire sample_ready;
    wire [15:0] sample;
    sine_reader reader(
        .clk(clk),
        .reset(reset),
        .step_size(step_size),
        .generate_next(generate_next),
        .sample_ready(sample_ready),
        .sample(sample)
    );

    // Clock and reset
    initial begin
        $dumpfile("sine_reader_tb.vcd");
        $dumpvars(0, sine_reader_tb);
        clk = 1'b0;
        reset = 1'b1;
        repeat (4) #5 clk = ~clk;
        reset = 1'b0;
        forever #5 clk = ~clk;
    end
    
    always #30 begin
        generate_next = 1;
        #10;
        generate_next = 0;
    end

    // Tests
    initial begin
        generate_next = 0;
        step_size = {1'b1, 19'b0};
    end

endmodule
