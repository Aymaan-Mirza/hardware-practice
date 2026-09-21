// ============================================================
// ID: rtl1 — Edge / Toggle Detector
// ============================================================
// Goal: detect rising, falling, and any toggle using previous-sample compare. 

module edge_toggle_detect (
  input  logic clk,
  input  logic rst_n,
  input  logic sig_in,
  output logic rise_pulse,
  output logic fall_pulse,
  output logic toggle_pulse
);


  logic sig_prev;

  always_ff @(posedge clk)
    begin
      if (!rst_n)
      begin
        rise_pulse <= 0;
        fall_pulse <= 0;
        toggle_pulse <= 0;
        sig_prev <= 0;
      end
      else
        begin
          sig_prev <= sig_in;
          rise_pulse <= (sig_in & ~sig_prev);
          fall_pulse <= (~sig_in & sig_prev);
          toggle_pulse <= (sig_in ^ sig_prev);
        end
    end



endmodule
