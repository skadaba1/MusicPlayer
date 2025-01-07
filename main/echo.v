`define NUM_CLKS 65536
module echo #(parameter WIDTH=24) (
    input clk,
    input reset,
    input beat,
    input sample_in_ready,
    input song_done,
    input wire signed [15:0] sample_in,
    output wire signed [15:0] sample_out,
    output wire sample_out_ready
);

    parameter QUEUE_DEPTH = 32768 // Set the depth of the queue
    
    reg [15:0] queue [0:QUEUE_DEPTH-1];

    // Data in and out
    wire [15:0] echo_sample;
    reg [15:0] next_echo_sample;

    // Define the counter and next_counter variables
    wire [5:0] counter;
    reg [5:0] next_counter;
    
    // Signals to control the queue state
    reg [14:0] front, rear;
    reg [14:0] next_front, next_rear;
    reg enqueue_enable, dequeue_enable;
  
    // Output signals
    assign empty = (front == rear);
    assign full = ((rear + 1) % QUEUE_DEPTH == front);
    assign dataOut = queue[front];

    dffre #(3) enqueue_ff(
        .clk(clk),
        .r(reset || song_done),
        .e(enqueue_enable),
        .d(next_front),
        .q(front)
    )

    dffre #(3) dequeue_ff(
        .clk(clk),
        .r(reset || song_done),
        .e(dequeue_enable),
        .d(next_rear),
        .q(rear)
    )
    
    dffr #(1) activate_ff(
        .clk(clk),
        .r(reset || song_done),
        .d(next_sample_out_ready),
        .q(sample_out_ready)
    );

    // Define a D flip-flop with reset and enable for the counter
    dffre #(6) counter_ff (
        .clk(clk),
        .r(reset || song_done),
        .en(beat),
        .d(next_counter),
        .q(counter)
    );
    // Enqueue and dequeue operations
    dffre #(16) output_ff(
        .clk(clk),
        .r(reset || song_done),
        .en(enqueue_enable),
        .d(next_echo_sample),
        .q(echo_sample)
    )
    always @(posedge clk) begin
        if (enqueue_enable)
        queue[rear] <= dataIn;
    end

    // Combinatorial logic for next_counter calculation and sample buffering
    always @(*) begin

        enqueue_enable = !full;
        dequeue_enable = sample_out_ready && !empty;
        
        // Calculate next values of front and rear
        next_front = (front + (dequeue_enable ? 1 : 0)) % QUEUE_DEPTH;
        next_rear = (rear + (enqueue_enable ? 1 : 0)) % QUEUE_DEPTH;
        
        // Calculate the next counter value
        if (counter == WIDTH - 1) begin
            next_counter = 0;
            next_sample_out_ready = 1'b1;
        end else begin
            next_counter = counter + 1;
            next_sample_out_ready = sample_out_ready;
        end

        if(enqueue_enable)
            queue[rear] = sample_in;
        end 

endmodule
