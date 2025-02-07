module Chimera_tb;

    // Inputs to the Chimera module (if any)
    // ... (define inputs here) ...
    
    // Instantiate the Chimera module
    Chimera dut (
        // ... (connect inputs/outputs as needed) ...
    );

    // Testbench logic
    integer time_t = 0;
    reg clock = 0;
    
    // Instantiate AndromedaMod_tb testbench
    AndromedaMod_tb andromeda_tb ();

    // Instantiate BayerPixelShifting_tb testbench
    BayerPixelShifting_tb bayer_tb ();

    // Clock simulation
    always #5 clock = ~clock;

    initial begin
        // Initialize signals if needed
        
        // Simulate for a number of clock cycles
        repeat(20) begin
            #10; // Wait for one clock cycle

            // Print time and other relevant signals if needed
            $display("Time = %d | Clock = %b | ...", time_t, clock);

            // Increment time
            time_t = time_t + 1;
        end

        $finish; // End simulation
    end

endmodule
