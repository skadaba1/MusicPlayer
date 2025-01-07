`define ADDR_WIDTH 17
`define DATA_WIDTH 16
module replay_ram (
    input wire clk,
    input wire [`ADDR_WIDTH-1:0] addr_a,
    input wire [`ADDR_WIDTH-1:0] addr_b,
    input wire signed [`DATA_WIDTH-1:0] data_in_a,
    input wire signed [`DATA_WIDTH-1:0] data_in_b,
    input wire write_enable_a,
    input wire write_enable_b,
    input wire read_enable_a,
    input wire read_enable_b,
    output reg signed [`DATA_WIDTH-1:0] data_out_a,
    output reg signed [`DATA_WIDTH-1:0] data_out_b
);
    // 
    (* ram_style = "block" *) reg signed [`DATA_WIDTH-1:0] memory [0:2**`ADDR_WIDTH-1];

    always @(posedge clk) begin
        if (write_enable_a)
            memory[addr_a] <= data_in_a;
        if (read_enable_a)
            data_out_a <= memory[addr_a];
    end

    always @(posedge clk) begin
        if (write_enable_b)
            memory[addr_b] <= data_in_b;
        if (read_enable_b)
            data_out_b <= memory[addr_b];
    end

endmodule

