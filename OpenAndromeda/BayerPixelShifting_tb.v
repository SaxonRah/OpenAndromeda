module BayerPixelShifting_tb;

    // Inputs to the BayerPixelShifting module
    // ... (define inputs here) ...

    // Outputs from the BayerPixelShifting module
    reg [11:0] high_res_red_image [0:1545][0:989];
    reg [11:0] high_res_green_image [0:1545][0:989];
    reg [11:0] high_res_blue_image [0:1545][0:989];

    // Instantiate BayerPixelShifting
    BayerPixelShifting dut (
        .raw_red_data(raw_red_data),
        .raw_green_data(raw_green_data),
        .raw_blue_data(raw_blue_data),
        // ... (other inputs for BayerPixelShifting) ...
        .high_res_red_image(high_res_red_image),
        .high_res_green_image(high_res_green_image),
        .high_res_blue_image(high_res_blue_image)
    );

    // Testbench logic
    integer time_t = 0;
    reg clock = 0;

    always #5 clock = ~clock; // Simulate clock

    initial begin
        raw_red_data = 12'b010101010101;
        raw_green_data = 12'b101010101010;
        raw_blue_data = 12'b111100001111;

        repeat(10) begin // Simulate 10 clock cycles
            #10; // Wait for one clock cycle

            // Print some output for verification
            $display("Time = %d | R: %b | G: %b | B: %b",
                time_t, raw_red_data, raw_green_data, raw_blue_data);

            // Increment time
            time_t = time_t + 1;
        end

        $finish;
    end

endmodule
