//CRC5 模块 (用于 Token 包)

module crc5_parallel (
    input  wire [4:0] crc_in,
    input  wire [7:0] data_in,
    output wire [4:0] crc_out
);
    // USB CRC5 Polynomial: x^5 + x^2 + 1
    // Data Width: 8 bits
    // Implementation: Parallel LFSR logic
    
    wire [7:0] d = data_in;
    wire [4:0] c = crc_in;
    wire [4:0] next_c;

    // XOR Equations for parallel calculation
    assign next_c[0] = d[7] ^ d[6] ^ d[4] ^ d[3] ^ d[1] ^ d[0] ^ c[0] ^ c[3] ^ c[4];
    assign next_c[1] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[2] ^ d[1] ^ c[0] ^ c[1] ^ c[4];
    assign next_c[2] = d[7] ^ d[5] ^ d[3] ^ d[2] ^ d[0] ^ c[0] ^ c[1] ^ c[2] ^ c[3] ^ c[4];
    assign next_c[3] = d[7] ^ d[6] ^ d[4] ^ d[2] ^ d[1] ^ c[1] ^ c[2] ^ c[3] ^ c[4];
    assign next_c[4] = d[7] ^ d[6] ^ d[5] ^ d[3] ^ d[2] ^ c[2] ^ c[3] ^ c[4];

    assign crc_out = next_c;

endmodule