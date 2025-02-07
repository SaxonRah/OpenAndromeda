module SpatialOffset(
  input wire clk,
  input wire rst,
  input wire [7:0] raw_red_data [0:539][0:959],
  input wire [7:0] raw_green_data [0:539][0:959],
  input wire [7:0] raw_blue_data [0:539][0:959],
  output reg [7:0] shifted_image [0:1919][0:1079],
  output reg [7:0] resized_image [0:1919][0:1079]
);

parameter SENSOR_WIDTH = 960;
parameter SENSOR_HEIGHT = 540;
parameter OUTPUT_WIDTH = 1920;
parameter OUTPUT_HEIGHT = 1080;
parameter HORIZONTAL_OFFSET = 50;
parameter VERTICAL_OFFSET = 30;

reg [11:0] pixel_counter_x = 0; // Counter for horizontal pixel position
reg [11:0] pixel_counter_y = 0; // Counter for vertical pixel position

always @(posedge clk or posedge rst) begin
  if (rst) begin
    pixel_counter_x <= 0;
    pixel_counter_y <= 0;
  end else begin
    // Apply spatial offset
    if (pixel_counter_x < SENSOR_WIDTH && pixel_counter_y < SENSOR_HEIGHT) begin
      shifted_image[pixel_counter_x][pixel_counter_y] <= raw_red_data[pixel_counter_x + HORIZONTAL_OFFSET][pixel_counter_y + VERTICAL_OFFSET];
      resized_image[pixel_counter_x][pixel_counter_y] <= raw_green_data[pixel_counter_x][pixel_counter_y]; // No resizing in this example
    end

    // Increment pixel counters
    if (pixel_counter_x < OUTPUT_WIDTH - 1) begin
      pixel_counter_x <= pixel_counter_x + 1;
    end else if (pixel_counter_y < OUTPUT_HEIGHT - 1) begin
      pixel_counter_x <= 0;
      pixel_counter_y <= pixel_counter_y + 1;
    end else begin
      pixel_counter_x <= 0;
      pixel_counter_y <= 0;
    end
  end
end

endmodule
