// ============================================================
// ID: rtl3 — Sequence Detector FSM (10110)
// ============================================================
// Goal: FSM asserts 1-cycle match when serial pattern 10110 completes. 

module seq_det_10110 (
  input  logic clk,
  input  logic rst_n,
  input  logic bit_in,
  output logic match_pulse
);


  typedef enum logic [2:0] {
    IDLE,
    GOT1,
    GOT10,
    GOT101,
    GOT1011
  } state_t;

  state_t current_state, next_state;


  always_ff @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      current_state <= IDLE;
    end
    else begin
      current_state <= next_state;
    end
    
  end


always_comb begin
  match_pulse = 0;
  case (current_state)

    IDLE: begin
      if (bit_in)
        next_state = GOT1;
      else
        next_state = IDLE;
    end

    GOT1: begin
      if (bit_in)
        next_state = GOT1;
      else
        next_state = GOT10;
    end

    GOT10: begin
      if (bit_in)
        next_state = GOT101;
      else
        next_state = IDLE;
    end

    GOT101: begin
      if (bit_in)
        next_state = GOT1011;
      else
        next_state = GOT10;
    end

    GOT1011: begin
      if (bit_in) begin
        next_state = GOT1;
      end
      else begin
        next_state = IDLE;
        match_pulse = 1;
      end
    end

  endcase
end
endmodule
