module link_ctrl (
    input  wire        clk,
    input  wire        rst_n,

    // 1. 系统配置与状态
    input  wire [6:0]  self_addr,       // 本机地址
    [cite_start]output reg         d_oe,            // 【关键】1=发送(输出), 0=接收(高阻/输入) [cite: 2, 5]
    output reg         time_out,        // 超时中断信号

    // 2. 与 TX (发送组) 的握手
    output reg         tx_start,        // 指令：开始发送
    output reg  [1:0]  tx_type,         // 指令：发送类型 (00:Handshake, 01:Token, 10:Data)
    input  wire        tx_done,         // 反馈：发送完毕

    // 3. 与 RX (接收组) 的握手
    input  wire        rx_pkt_valid,    // 反馈：收到有效包
    input  wire [3:0]  rx_pid_val,      // 反馈：收到的PID是什么
    input  wire        crc5_err,        // 反馈：CRC5 错了没
    input  wire        crc16_err        // 反馈：CRC16 错了没
);

    // 状态机状态定义 (建议)
    localparam S_IDLE       = 3'd0;
    localparam S_RX_WAIT    = 3'd1;
    localparam S_TX_Driver  = 3'd2;
    // ... 其他状态你之后再补

    reg [2:0] current_state, next_state;

    // TODO: 在这里编写你的三段式状态机
    // 记住：d_oe 必须严格控制，默认是 0 (接收模式)

endmodule