module filter_noise_tb;

localparam INPUT_WIDTH = 16;
localparam OUTPUT_WIDTH = 18;
localparam ORDER = 4;

logic clk = 0;
logic nrst = 1'b0;
logic [INPUT_WIDTH - 1:0] data;
logic [OUTPUT_WIDTH - 1:0] result;

real data_sin;
real data_noise;

always #5 clk = !clk;

initial begin
    int seed = 1;
    int rand_int = 0;
    data = '0;
    
    nrst = 1'b0;
    repeat(5) @(posedge clk);
    nrst = 1'b1;
    repeat(5) @(posedge clk);
    
    for (int i = 0; ; i++) begin
        data_sin = $sin(i * 0.0001);
        rand_int = $dist_normal(seed, 100, 10);
        data_noise = 10.0 + (rand_int / 5.0);
        data = data_sin + data_noise;
        @(posedge clk);
    end
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
