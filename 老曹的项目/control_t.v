module control_t (
    input  wire        clk,
    input  wire        rst_n,

    // 1. 来自潘智鸿 (link_ctrl) 的指令
    input  wire        start,           // 开始发送
    input  wire [1:0]  pkt_type,        // 包类型
    output reg         done,            // 发送完成通知

    // 2. 来自上层 (Transfer Layer) 的数据
    input  wire [3:0]  tx_pid,
    input  wire [6:0]  tx_addr,
    input  wire [7:0]  tx_lt_data,
    
    // 3. 输出给 PHY (物理层)
    output reg         tx_lp_sop,
    output reg         tx_lp_eop,
    output reg         tx_lp_valid,
    output reg  [7:0]  tx_lp_data,
    input  wire        tx_lp_ready
);

    // 子模块：CRC5 发送生成器 (需要你自己例化或写在内部)
    // wire [4:0] crc5_out;
    [cite_start]// crc5_t u_crc5_t ( ... ); [cite: 5]

    // TODO: 编写计数器逻辑
    // 0: 发送 SOP
    // 1: 发送 PID
    // 2...N: 发送数据/地址
    // Last: 发送 CRC & EOP

endmodule