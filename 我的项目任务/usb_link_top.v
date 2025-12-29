module usb_link_top (
    // ------------------------------------------------------
    // 1. 系统与寄存器接口 
    // ------------------------------------------------------
    input  wire        clk,             // System Clock
    input  wire        rst_n,           // System Reset (Active Low)
    
    // 配置寄存器 (由主机配置)
    input  wire [6:0]  self_addr,       // 本机设备地址
    input  wire        ms,              // 1: Master, 0: Slave (主从模式)
    input  wire [15:0] time_threshold,  // 超时等待阈值
    input  wire [5:0]  delay_threshold, // 延迟阈值
    
    // 错误与状态指示
    output wire        crc5_err,        // CRC5 校验错误
    output wire        crc16_err,       // CRC16 校验错误
    output wire        time_out,        // 超时中断
    output wire        d_oe,            // Data Output Enable (控制双向总线方向的关键信号) [cite: 2, 3]

    // ------------------------------------------------------
    // 2. 物理层 (PHY) 接口 
    // ------------------------------------------------------
    // 接收路径 (RX Path)
    input  wire        rx_lp_sop,       // Start of Packet
    input  wire        rx_lp_eop,       // End of Packet
    input  wire        rx_lp_valid,     // 数据有效
    output wire        rx_lp_ready,     // 链路层准备好接收
    input  wire [7:0]  rx_lp_data,      // 接收到的 8-bit 数据

    // 发送路径 (TX Path)
    output wire        tx_lp_sop,       // 指示 PHY 发送 SOP
    output wire        tx_lp_eop,       // 指示 PHY 发送 EOP
    output wire        tx_lp_valid,     // 发送数据有效
    input  wire        tx_lp_ready,     // PHY 准备好发送
    output wire [7:0]  tx_lp_data,      // 发送给 PHY 的 8-bit 数据
    output wire        tx_lp_cancle,    // 取消发送

    // ------------------------------------------------------
    // 3. 传输层 (Transfer Layer) 接口 
    // ------------------------------------------------------
    // 上层给你的指令 (TX Request)
    input  wire [3:0]  tx_pid,          // 上层要发的 PID 类型
    input  wire [6:0]  tx_addr,         // 目标地址
    input  wire [3:0]  tx_endp,         // 目标端点
    input  wire [7:0]  tx_lt_data,      // 上层要发的数据内容
    input  wire        tx_valid,        // 请求有效
    input  wire        tx_lt_sop,       // 上层数据包开始
    input  wire        tx_lt_eop,       // 上层数据包结束
    input  wire        tx_lt_valid,     // 上层数据流有效
    output wire        tx_ready,        // 告诉上层：我很忙/我可以接单
    output wire        tx_lt_ready,     // 告诉上层：数据我收下了

    // 你给上层的数据 (RX Indication)
    output wire [3:0]  rx_pid,          // 解析出的 PID
    output wire [3:0]  rx_endp,         // 解析出的端点
    output wire [7:0]  rx_lt_data,      // 剥离了 CRC/PID 后的纯数据
    output wire        rx_pid_en,       // PID 解析完成脉冲
    output wire        rx_lt_sop,       // 告诉上层：新包开始了
    output wire        rx_lt_eop,       // 告诉上层：包结束了
    output wire        rx_lt_valid,     // 数据有效
    input  wire        rx_lt_ready      // 上层准备好接收了吗
);
	// ======================================================
    // 内部连线与模块例化 (TODO: 你的下一步工作)
    // ======================================================
    // 这里你需要根据题目要求  例化以下模块：
    // 1. crc5_r_inst  (CRC5校验)
    // 2. crc16_r_inst (CRC16校验)
    // 3. control_t_inst (发送控制)
    // 4. link_ctrl_inst (核心状态机)
endmodule