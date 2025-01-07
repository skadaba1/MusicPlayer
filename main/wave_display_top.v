module wave_display_top(
    input clk,
    input reset,
    input new_sample,
    input [15:0] sample,
    input [10:0] x,  // [0..1279]
    input [9:0]  y,  // [0..1023]     
    input valid,
    input vsync,
    output display
);

    parameter R = 8'd255;
    parameter G = 8'd255;
    parameter B = 8'd255;

    wire [7:0] read_sample, write_sample;
    wire [8:0] read_address, write_address;
    wire read_index;
    wire write_en;
    wire wave_display_idle = ~vsync;

    wave_capture wc(
        .clk(clk),
        .reset(reset),
        .new_sample_ready(new_sample),
        .new_sample_in(sample),
        .write_address(write_address),
        .write_enable(write_en),
        .write_sample(write_sample),
        .wave_display_idle(wave_display_idle),
        .read_index(read_index)
    );
    
    ram_1w2r #(.WIDTH(8), .DEPTH(9)) sample_ram(
        .clka(clk),
        .clkb(clk),
        .wea(write_en),
        .addra(write_address),
        .dina(write_sample),
        .douta(),
        .addrb(read_address),
        .doutb(read_sample)
    );
 
    wire valid_pixel;
    wire temp_display;
    wave_display wd(
        .clk(clk),
        .reset(reset),
        .x(x),
        .y(y),
        .valid(valid),
        .read_address(read_address),
        .read_value(read_sample),
        .read_index(read_index),
        .valid_pixel(valid_pixel),
        .display(temp_display)
    );

    assign display = valid_pixel && temp_display;

endmodule
