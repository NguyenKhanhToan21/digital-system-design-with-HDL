`timescale 1ns / 1ps

module sram_controller (
    // User Interface (Board DE-series)
    input  wire [17:0] SW,       // SW[15:8]: Address, SW[7:0]: Data_In
    input  wire [1:0]  KEY,      // KEY[1]: /WE, KEY[0]: /OE
    
    // SRAM Interface (IS61WV25616 hoặc tương đương)
    output wire [17:0] SRAM_ADDR,
    inout  wire [15:0] SRAM_DQ,  // Bus dữ liệu 2 chiều
    output wire        SRAM_CE_N,
    output wire        SRAM_OE_N,
    output wire        SRAM_WE_N,
    output wire        SRAM_UB_N,
    output wire        SRAM_LB_N,
    
    // Output Display
    output wire [6:0]  HEX0,
    output wire [6:0]  HEX1,
    output wire [6:0]  HEX2,
    output wire [6:0]  HEX3
);

    // 1. Phân giải tín hiệu điều khiển trực tiếp từ nút nhấn (Active Low)
    wire we_n = SW[17];
    wire oe_n = SW[16];
    
    assign SRAM_WE_N = we_n;
    assign SRAM_OE_N = oe_n;
    assign SRAM_CE_N = 1'b0; // Luôn Chip Enable
    assign SRAM_UB_N = 1'b0; // Kích hoạt Upper Byte (theo spec lab)
    assign SRAM_LB_N = 1'b0; // Kích hoạt Lower Byte (theo spec lab)

    // 2. Giải mã địa chỉ theo không gian quy định
    assign SRAM_ADDR = {10'h000, SW[15:8]};

    // 3. Xử lý Tri-state Buffer cho inout bus SRAM_DQ
    // - Khi Ghi (/WE = 0): Lái dữ liệu từ SW[7:0] ra bus, 8 bit cao nhồi 0.
    // - Khi Đọc (/WE = 1): Ngắt kết nối (High-Z) để SRAM bơm dữ liệu vào bus.
    assign SRAM_DQ = (~we_n) ? {8'h00, SW[7:0]} : 16'hZZZZ;

    // 4. Bắt dữ liệu trên bus để hiển thị
    // Ngay cả trong chu kỳ ghi, ta vẫn có thể monitor giá trị đang được ép lên bus.
    wire [15:0] data_to_display = SRAM_DQ;

    // 5. Khởi tạo khối giải mã 7 đoạn
    hex_decoder h0 (.bin(data_to_display[3:0]),   .hex(HEX0));
    hex_decoder h1 (.bin(data_to_display[7:4]),   .hex(HEX1));
    hex_decoder h2 (.bin(data_to_display[11:8]),  .hex(HEX2));
    hex_decoder h3 (.bin(data_to_display[15:12]), .hex(HEX3));

endmodule

// Khối logic tổ hợp: Giải mã Binary sang HEX (Active Low)
module hex_decoder (
    input  wire [3:0] bin,
    output reg  [6:0] hex
);
    always @(*) begin
        case (bin)
            4'h0: hex = 7'b1000000;
            4'h1: hex = 7'b1111001;
            4'h2: hex = 7'b0100100;
            4'h3: hex = 7'b0110000;
            4'h4: hex = 7'b0011001;
            4'h5: hex = 7'b0010010;
            4'h6: hex = 7'b0000010;
            4'h7: hex = 7'b1111000;
            4'h8: hex = 7'b0000000;
            4'h9: hex = 7'b0010000;
            4'hA: hex = 7'b0001000;
            4'hB: hex = 7'b0000011;
            4'hC: hex = 7'b1000110;
            4'hD: hex = 7'b0100001;
            4'hE: hex = 7'b0000110;
            4'hF: hex = 7'b0001110;
            default: hex = 7'b1111111;
        endcase
    end
endmodule