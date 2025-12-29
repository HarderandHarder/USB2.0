// --------------------------------------------------
// 模块 1: CRC5 校验 (用于 Token/Handshake 包)
// --------------------------------------------------
module crc5_r (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        init,            // 新包开始，复位CRC计算器
    input  wire        data_valid,      // 当前字节有效
    input  wire [7:0]  data_in,         // 输入数据
    
    output wire        check_pass,      // 1=校验通过 (余数为常数)
    [cite_start]output wire        crc_err          // 1=校验错误 [cite: 5]
);
    // USB CRC5 Poly: G(x) = x^5 + x^2 + 1 (0x05)
    // TODO: 你要负责去查 USB 协议或使用生成器填入逻辑
endmodule

// --------------------------------------------------
// 模块 2: CRC16 校验 (用于 Data 包)
// --------------------------------------------------
module crc16_r (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        init,
    input  wire        data_valid,
    input  wire [7:0]  data_in,
    
    output wire        check_pass,
    [cite_start]output wire        crc_err          // [cite: 5]
);
    // USB CRC16 Poly: G(x) = x^16 + x^15 + x^2 + 1 (0x8005)
    // TODO: 你要负责实现 LFSR 逻辑
endmodule