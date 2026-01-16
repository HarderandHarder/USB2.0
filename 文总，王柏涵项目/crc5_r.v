module crc5_r (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       init,       // 对应 rx_lp_sop，表示包开始（PID字节）
    input  wire       data_valid, // 对应 rx_lp_valid
    input  wire [7:0] data_in,    // 对应 rx_lp_data
    output wire       check_pass, // 当结果等于 Magic Number 时拉高
    output wire       crc_err     // check_pass 的反相，用于 Top 连线
);

    reg [4:0] lfsr_q;
    wire [4:0] next_lfsr;

    // 实例化上一轮生成的纯组合逻辑计算器
    crc5_parallel u_crc5_calc (
        .crc_in (lfsr_q),
        .data_in(data_in),
        .crc_out(next_lfsr)
    );

    // 标准 USB 2.0 CRC5 残余值 (Magic Number) = 5'h0C
    // 当接收到的 [地址 + 端点 + CRC5] 全部计算完后，结果应为此值
    assign check_pass = (lfsr_q == 5'h0C);
    assign crc_err    = !check_pass;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr_q <= 5'h1F; // USB 标准复位值 (全1)
        end else if (init) begin
            // 收到 SOP (PID 阶段)：复位 CRC，且不计算当前字节 (跳过 PID)
            lfsr_q <= 5'h1F;
        end else if (data_valid) begin
            // 后续数据阶段：累积计算
            lfsr_q <= next_lfsr;
        end
    end

endmodule