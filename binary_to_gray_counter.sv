// ============================================================
// ID: rtl6 — Binary Counter + Gray Output
// ============================================================
// Goal: binary counter increments; gray = bin ^ (bin >> 1). 

module bin_to_gray_counter #(
  parameter int W = 4
) (
  input  logic         clk,
  input  logic         rst_n,
  input  logic         enable,
  output logic [W-1:0] bin_count,
  output logic [W-1:0] gray_count
);

  always_ff @(posedge clk or negedge rst_n)
  begin
    if (!rst_n) begin
      bin_count <= 0;
    end
    else if (enable) begin
      bin_count <= bin_count + 1;
    end
  end

  assign gray_count = bin_count ^ (bin_count >> 1);
 

endmodule
