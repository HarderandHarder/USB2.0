module crc16_r (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        init,       // 对应 rx_lp_sop
    input  wire        data_valid, // 对应 rx_lp_valid
    input  wire [7:0]  data_in,    // 对应 rx_lp_data
    output wire        check_pass,
    output wire        crc_err
);

    reg [15:0] lfsr_q;
    wire [15:0] next_lfsr;

    // 实例化 CRC16 并行计算模块
    crc16_parallel u_crc16_calc (
        .crc_in (lfsr_q),
        .data_in(data_in),
        .crc_out(next_lfsr)
    );

    // 标准 USB 2.0 CRC16 残余值 = 16'h800D
    assign check_pass = (lfsr_q == 16'h800D);
    assign crc_err    = !check_pass;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr_q <= 16'hFFFF; // USB 标准复位值
        end else if (init) begin
            // 收到 SOP：复位，跳过 PID
            lfsr_q <= 16'hFFFF;
        end else if (data_valid) begin
            lfsr_q <= next_lfsr;
        end
    end

endmodule