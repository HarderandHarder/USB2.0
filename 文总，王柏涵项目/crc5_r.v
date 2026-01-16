module crc5_r (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        init,       // signals SOP/PID (reset)
    input  wire        data_valid,
    input  wire [7:0]  data_in,
    output wire        check_pass,
    output wire        crc_err
);
    reg [4:0] lfsr_q, lfsr_c;
    reg [4:0] c;
    reg [7:0] d;
    integer i;

    // Polynomial: X^5 + X^2 + 1 (0x05)
    always @(*) begin
        c = lfsr_q;
        d = data_in;
        for (i = 0; i < 8; i = i + 1) begin
            if (d[0] ^ c[4])
                c = (c << 1) ^ 5'h05;
            else
                c = c << 1;
            d = d >> 1;
        end
        lfsr_c = c;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            lfsr_q <= 5'h1F;
        else if (init)
            lfsr_q <= 5'h1F; // Reset on PID byte
        else if (data_valid)
            lfsr_q <= lfsr_c;
    end

    assign check_pass = (lfsr_q == 5'h0C);
    assign crc_err    = !check_pass;

endmodule
