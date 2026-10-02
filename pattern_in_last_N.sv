// ============================================================
// ID: rtl4 — Pattern 10110 Anywhere in Last N Samples
// ============================================================
// Goal: shift-register window + decode all alignments.

module pattern_in_window #(
  parameter int N = 8,
  parameter int K = 5,
  parameter logic [K-1:0] PATTERN = 5'b10110
) (
  input  logic clk,
  input  logic rst_n,
  input  logic bit_in,
  output logic found
);

  logic [N-1:0] shreg;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      shreg <= 0;
    end
    else begin
      shreg <= shreg >> 1;
      shreg[N-1] <= bit_in;
    end
  end

  int i;

  always_comb begin
    found = '0;

    if (N >= K) begin
      for (i = 0; i < N-K+1; i = i + 1) begin
        if (shreg[i +: 5] == PATTERN) begin
          found = 1;
        end
      end
    end
  end

endmodule
