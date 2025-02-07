module PixelShifting3CCD (
    input wire clk,
    input wire rst,
    input wire [11:0] raw_red_data,
    input wire [11:0] raw_green_data,
    input wire [11:0] raw_blue_data,
    output reg [11:0] high_res_luminance [0:1919][0:1079]
);

parameter SENSOR_WIDTH = 960;
parameter SENSOR_HEIGHT = 540;
parameter OUTPUT_WIDTH = 1920;
parameter OUTPUT_HEIGHT = 1080;
parameter SHIFT_AMOUNT = 0.5;

reg [9:0] pixel_counter_x = 0; // Counter for horizontal pixel position
reg [9:0] pixel_counter_y = 0; // Counter for vertical pixel position

reg [11:0] shifted_red, shifted_blue;
reg [1:0] shift_phase = 2'b00;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        pixel_counter_x <= 0;
        pixel_counter_y <= 0;
    end else begin
        // Shift red and blue sensors
        if (pixel_counter_x < SENSOR_WIDTH && pixel_counter_y < SENSOR_HEIGHT) begin
            shifted_red <= raw_red_data;
            shifted_blue <= raw_blue_data;
        end else begin
            shifted_red <= 12'b0;
            shifted_blue <= 12'b0;
        end

        // Store shifted luminance in the output array
        high_res_luminance[pixel_counter_x][pixel_counter_y] <= shifted_red + raw_green_data + shifted_blue;

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

module SpatialOffset(
  input wire clk,
  input wire rst,
  input wire [11:0] raw_red_data [0:539][0:959],
  input wire [11:0] raw_green_data [0:539][0:959],
  input wire [11:0] raw_blue_data [0:539][0:959],
  output reg [11:0] shifted_image [0:1919][0:1079],
  output reg [11:0] resized_image [0:1919][0:1079]
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


module SpatialOffsetWithInterpolation(
  input wire clk,
  input wire rst,
  input wire [11:0] raw_red_data [0:539][0:959],
  input wire [11:0] raw_green_data [0:539][0:959],
  input wire [11:0] raw_blue_data [0:539][0:959],
  output reg [11:0] shifted_image [0:1919][0:1079],
  output reg [11:0] resized_image [0:1919][0:1079]
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
      
      // Bilinear interpolation for resizing
      reg [11:0] dx, dy;
      reg [11:0] interpolated_value;

      dx = pixel_counter_x * (SENSOR_WIDTH - 1 - HORIZONTAL_OFFSET) / (OUTPUT_WIDTH - 1);
      dy = pixel_counter_y * (SENSOR_HEIGHT - 1 - VERTICAL_OFFSET) / (OUTPUT_HEIGHT - 1);

      // Perform bilinear interpolation
      interpolated_value = (
        (raw_green_data[pixel_counter_x][pixel_counter_y] * (SENSOR_WIDTH - 1 - dx) * (SENSOR_HEIGHT - 1 - dy)) +
        (raw_green_data[pixel_counter_x + 1][pixel_counter_y] * dx * (SENSOR_HEIGHT - 1 - dy)) +
        (raw_green_data[pixel_counter_x][pixel_counter_y + 1] * (SENSOR_WIDTH - 1 - dx) * dy) +
        (raw_green_data[pixel_counter_x + 1][pixel_counter_y + 1] * dx * dy)
      ) / ((SENSOR_WIDTH - 1) * (SENSOR_HEIGHT - 1));

      resized_image[pixel_counter_x][pixel_counter_y] <= interpolated_value;
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
