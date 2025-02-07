module AndromedaMod (
    input wire red_data_0_in, // Use the first bit of red_data_0_in as the clock
    //input wire [1:0] red_data_0_in,
    input wire [1:0] red_data_1_in,
    input wire [1:0] red_data_2_in,
    input wire [1:0] red_data_3_in,
    input wire [1:0] red_data_4_in,
    input wire [1:0] red_data_5_in,
    input wire [1:0] red_data_6_in,
    input wire [1:0] red_data_7_in,
    input wire [1:0] red_data_8_in,
    input wire [1:0] red_data_9_in,
    input wire [1:0] red_data_10_in,
    input wire [1:0] red_data_11_in,
    
    input wire [1:0] green_data_0_in,
    input wire [1:0] green_data_1_in,
    input wire [1:0] green_data_2_in,
    input wire [1:0] green_data_3_in,
    input wire [1:0] green_data_4_in,
    input wire [1:0] green_data_5_in,
    input wire [1:0] green_data_6_in,
    input wire [1:0] green_data_7_in,
    input wire [1:0] green_data_8_in,
    input wire [1:0] green_data_9_in,
    input wire [1:0] green_data_10_in,
    input wire [1:0] green_data_11_in,
    
    input wire [1:0] blue_data_0_in,
    input wire [1:0] blue_data_1_in,
    input wire [1:0] blue_data_2_in,
    input wire [1:0] blue_data_3_in,
    input wire [1:0] blue_data_4_in,
    input wire [1:0] blue_data_5_in,
    input wire [1:0] blue_data_6_in,
    input wire [1:0] blue_data_7_in,
    input wire [1:0] blue_data_8_in,
    input wire [1:0] blue_data_9_in,
    input wire [1:0] blue_data_10_in,
    input wire [1:0] blue_data_11_in,
    
    output reg [11:0] red_image [0:719][0:480],
    output reg [11:0] blue_image [0:719][0:480],
    output reg [11:0] green_image [0:719][0:480]
);

parameter IMAGE_WIDTH = 720;
parameter IMAGE_HEIGHT = 480;

reg [9:0] pixel_counter_x = 0; // Counter for horizontal pixel position
reg [9:0] pixel_counter_y = 0; // Counter for vertical pixel position

reg [11:0] red_reg, green_reg, blue_reg;

// Logic triggered by changes in red_data_0_in
always @(posedge red_data_0_in) begin
//always @(posedge clock) begin
    // Combine the 12-bit data from individual channels
    red_reg <= {red_data_11_in, red_data_10_in, red_data_9_in, red_data_8_in, red_data_7_in, red_data_6_in, red_data_5_in, red_data_4_in, red_data_3_in, red_data_2_in, red_data_1_in, red_data_0_in};
    green_reg <= {green_data_11_in, green_data_10_in, green_data_9_in, green_data_8_in, green_data_7_in, green_data_6_in, green_data_5_in, green_data_4_in, green_data_3_in, green_data_2_in, green_data_1_in, green_data_0_in};
    blue_reg <= {blue_data_11_in, blue_data_10_in, blue_data_9_in, blue_data_8_in, blue_data_7_in, blue_data_6_in, blue_data_5_in, blue_data_4_in, blue_data_3_in, blue_data_2_in, blue_data_1_in, blue_data_0_in};

    if (pixel_counter_x < IMAGE_WIDTH) begin
        // Store the data into image buffers
        red_image[pixel_counter_x][pixel_counter_y] <= red_reg;
        blue_image[pixel_counter_x][pixel_counter_y] <= blue_reg;
        green_image[pixel_counter_x][pixel_counter_y] <= green_reg;

        // Increment pixel counter
        pixel_counter_x <= pixel_counter_x + 1;
    end
    // Increment vertical pixel counter if necessary
    if (pixel_counter_x == IMAGE_WIDTH - 1) begin
        pixel_counter_x <= 0;
        pixel_counter_y <= pixel_counter_y + 1;
    end
    // Reset vertical pixel counter at the end of the frame
    if (pixel_counter_y == IMAGE_HEIGHT - 1) begin
        pixel_counter_y <= 0;
    end
end

endmodule
