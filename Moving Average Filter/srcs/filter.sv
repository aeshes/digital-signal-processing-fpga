module filter #(
    parameter INPUT_WIDTH = 16,
    parameter OUTPUT_WIDTH = 18,
    parameter ORDER = 4
)(
    input logic clk,
    input logic nrst,
    input logic [INPUT_WIDTH - 1:0] data,
    output logic [OUTPUT_WIDTH - 1:0] result
);

logic [ORDER - 1:0][INPUT_WIDTH - 1:0] state = '0;

always_ff @(posedge clk) begin
    if (!nrst) begin
        state <= '0;
    end else begin
        state[0] <= data;
        for (int i = 1; i < ORDER; i++) begin
            state[i] <= state[i - 1];
        end
    end
end

always_comb begin
    result = '0;
    for (int i = 0; i < ORDER; i++) begin
        result += state[i];
    end
end

endmodule