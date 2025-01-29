module filter_tb;

localparam INPUT_WIDTH = 16;
localparam OUTPUT_WIDTH = 18;
localparam ORDER = 4;

logic clk = 0;
logic nrst = 1'b0;
logic [INPUT_WIDTH - 1:0] data;
logic [OUTPUT_WIDTH - 1:0] result;

logic [INPUT_WIDTH - 1:0] data_set [] = {1, 2, 3, 4, 5, 6, 7, 8};

always #5 clk = !clk;

initial begin
    data = '0;
    nrst = 1'b0;
    repeat(5) @(posedge clk);
    nrst = 1'b1;
    repeat(5) @(posedge clk);

    for (int i = 0; i < $size(data_set); i++) begin
        data = data_set[i];
        @(posedge clk);
        end
    data = '0;
end

filter #(
  .INPUT_WIDTH(INPUT_WIDTH),
  .OUTPUT_WIDTH(OUTPUT_WIDTH),
  .ORDER(ORDER)
) dut (
  .clk(clk),
  .nrst(nrst),
  .data(data),
  .result(result)
);

endmodule