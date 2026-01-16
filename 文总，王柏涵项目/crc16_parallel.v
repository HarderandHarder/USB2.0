module crc16_parallel (
    input  wire [15:0] crc_in,
    input  wire [7:0]  data_in,
    output wire [15:0] crc_out
);
    // USB CRC16 Polynomial: x^16 + x^15 + x^2 + 1
    // Data Width: 8 bits
    
    wire [7:0]  d = data_in;
    wire [15:0] c = crc_in;
    wire [15:0] next_c;

    // XOR Equations for parallel calculation
    assign next_c[0] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[3] ^ d[2] ^ d[1] ^ d[0] ^ c[8] ^ c[9] ^ c[10] ^ c[11] ^ c[12] ^ c[13] ^ c[14] ^ c[15];
    assign next_c[1] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[3] ^ d[2] ^ d[1] ^ c[9] ^ c[10] ^ c[11] ^ c[12] ^ c[13] ^ c[14] ^ c[15];
    assign next_c[2] = d[1] ^ d[0] ^ c[8] ^ c[9];
    assign next_c[3] = d[2] ^ d[1] ^ c[9] ^ c[10];
    assign next_c[4] = d[3] ^ d[2] ^ c[10] ^ c[11];
    assign next_c[5] = d[4] ^ d[3] ^ c[11] ^ c[12];
    assign next_c[6] = d[5] ^ d[4] ^ c[12] ^ c[13];
    assign next_c[7] = d[6] ^ d[5] ^ c[13] ^ c[14];
    assign next_c[8] = d[7] ^ d[6] ^ c[0] ^ c[14] ^ c[15];
    assign next_c[9] = d[7] ^ c[1] ^ c[15];
    assign next_c[10] = c[2];
    assign next_c[11] = c[3];
    assign next_c[12] = c[4];
    assign next_c[13] = c[5];
    assign next_c[14] = c[6];
    assign next_c[15] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[3] ^ d[2] ^ d[1] ^ d[0] ^ c[7] ^ c[8] ^ c[9] ^ c[10] ^ c[11] ^ c[12] ^ c[13] ^ c[14] ^ c[15];

    assign crc_out = next_c;

endmodule