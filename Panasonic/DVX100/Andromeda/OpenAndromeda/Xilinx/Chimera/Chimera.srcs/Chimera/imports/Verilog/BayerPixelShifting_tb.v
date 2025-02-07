module BayerPixelShifting_tb;

    // ... (input declarations) ...

    // Outputs from the BayerPixelShifting module
    reg [11:0] high_res_red_image [0:1545][0:989];
    reg [11:0] high_res_green_image [0:1545][0:989];
    reg [11:0] high_res_blue_image [0:1545][0:989];

    // ... (clock generation, instantiation of BayerPixelShifting) ...

    initial begin
        // Generate sample input data or use the generated images from AndromedaMod_tb
        // Assign image data to raw_red_data, raw_green_data, raw_blue_data
        
        // Example: Assigning image data from AndromedaMod_tb output
        raw_red_data = andromeda_red_image[pixel_counter_x][pixel_counter_y];
        raw_green_data = andromeda_green_image[pixel_counter_x][pixel_counter_y];
        raw_blue_data = andromeda_blue_image[pixel_counter_x][pixel_counter_y];

        // ... (rest of the testbench logic) ...
        
    end

endmodule
