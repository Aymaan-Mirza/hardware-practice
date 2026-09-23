// ============================================================
// ID: rtl9 — Timebase from 1ms tick (sec/min/hr)
// ============================================================
// Goal: count 1ms pulses to generate 1-cycle sec/min/hour pulses. 

module timebase (
  input  logic clk,
  input  logic rst_n,
  input  logic tick_1ms,
  output logic sec_pulse,
  output logic min_pulse,
  output logic hour_pulse
);

  logic [9:0] ms_cnt;

  logic [5:0] sec_cnt;

  logic [5:0] min_cnt;


  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        sec_pulse  <= 0;
        min_pulse  <= 0;
        hour_pulse <= 0;
        ms_cnt     <= 0;
        sec_cnt    <= 0;
        min_cnt    <= 0;
    end
    else begin
        sec_pulse  <= 0;
        min_pulse  <= 0;
        hour_pulse <= 0;

        if (tick_1ms) begin

            if (ms_cnt == 999) begin
                ms_cnt <= 0;
                sec_pulse <= 1;

                if (sec_cnt == 59) begin
                    sec_cnt    <= 0;
                    min_pulse <= 1;

                    if (min_cnt == 59) begin
                        min_cnt    <= 0;
                        hour_pulse <= 1;
                    end
                    else begin
                        min_cnt <= min_cnt + 1;
                    end
                end
                else begin
                    sec_cnt <= sec_cnt + 1;
                end
            end
            else begin
                ms_cnt <= ms_cnt + 1;
            end

        end
    end
end


endmodule
