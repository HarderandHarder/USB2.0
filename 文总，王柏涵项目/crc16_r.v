module crc16_r (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        init,       // Signals SOP (PID byte)
    input  wire        data_valid,
    input  wire [7:0]  data_in,
    output wire        check_pass,
    output wire        crc_err
);
    // USB CRC16 Polynomial: X^16 + X^15 + X^2 + 1
    // USB Residual for CRC16: 16'h800D

    reg [15:0] lfsr_q;
    reg [15:0] lfsr_c;

    reg [15:0] c;
    reg [7:0] d;
    integer i;

    // Combinatorial Next Logic
    always @(*) begin
        c = lfsr_q;
        d = data_in; 

        for (i = 0; i < 8; i = i + 1) begin
            if (d[0] ^ c[0]) // LSB XOR
                c = (c >> 1) ^ 16'hA001; // A001 is reversed 8005
            else
                c = c >> 1;
            d = d >> 1;
        end
        lfsr_c = c;
    end

    // Sequential Logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr_q <= 16'hFFFF;
        end else begin
            if (init) begin
                // Reset on PID byte
                lfsr_q <= 16'hFFFF;
            end else if (data_valid) begin
                // Update on Data/CRC bytes
                lfsr_q <= lfsr_c;
            end
        end
    end

    assign check_pass = (lfsr_q == 16'h800D);
    assign crc_err = !check_pass;

endmodule
