module BayerPixelShifting (
    input wire [11:0] raw_red_data,
    input wire [11:0] raw_green_data,
    input wire [11:0] raw_blue_data,
    output reg [11:0] high_res_red_image [0:1545][0:989],
    output reg [11:0] high_res_green_image [0:1545][0:989],
    output reg [11:0] high_res_blue_image [0:1545][0:989]
);

parameter INPUT_WIDTH = 720;
parameter INPUT_HEIGHT = 480;
parameter OUTPUT_WIDTH = 1546;
parameter OUTPUT_HEIGHT = 990;

reg [9:0] pixel_counter_x = 0; // Counter for horizontal pixel position
reg [9:0] pixel_counter_y = 0; // Counter for vertical pixel position

reg [11:0] high_res_red, high_res_green, high_res_blue;
reg [1:0] color_phase = 2'b00;

always @(posedge clock) begin
    if (pixel_counter_x < OUTPUT_WIDTH) begin
        if (color_phase == 2'b00) begin
            high_res_red <= raw_red_data;
            high_res_green <= raw_green_data;
            high_res_blue <= raw_blue_data;
        end else if (color_phase == 2'b01) begin
            high_res_green <= raw_red_data;
        end else if (color_phase == 2'b10) begin
            high_res_green <= raw_blue_data;
        end else begin // color_phase == 2'b11
            high_res_green <= raw_green_data;
            high_res_blue <= raw_blue_data;
        end
        
        high_res_red_image[pixel_counter_x][pixel_counter_y] <= high_res_red;
        high_res_green_image[pixel_counter_x][pixel_counter_y] <= high_res_green;
        high_res_blue_image[pixel_counter_x][pixel_counter_y] <= high_res_blue;
        
        // Increment pixel counter
        pixel_counter_x <= pixel_counter_x + 1;
    end
    
    // Update color phase
    if (color_phase == 2'b11) begin
        color_phase <= 2'b00;
    end else begin
        color_phase <= color_phase + 1;
    end
    
    // Increment vertical pixel counter if necessary
    if (pixel_counter_x == OUTPUT_WIDTH - 1) begin
        pixel_counter_x <= 0;
        pixel_counter_y <= pixel_counter_y + 1;
    end
    
    // Reset vertical pixel counter at the end of the frame
    if (pixel_counter_y == OUTPUT_HEIGHT - 1) begin
        pixel_counter_y <= 0;
    end
end

endmodule
