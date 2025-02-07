module ParallelCapture (
    
    input wire red_data_0_in,
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
    
    input wire green_data_0_in,
    //input wire [1:0] green_data_0_in,
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
    
    input wire blue_data_0_in,
    //input wire [1:0] blue_data_0_in,
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
    
    output wire [35:0] rgb_data
);
    parameter BUFFER_DEPTH = 1024;
    reg [35:0] rgb_data_buffer [0:BUFFER_DEPTH-1];
    integer buffer_index = 0;
    integer buffer_index_next = 0;


    always @(posedge red_data_0_in or posedge green_data_0_in or posedge blue_data_0_in) begin
        buffer_index_next = (buffer_index + 1) % BUFFER_DEPTH; // Calculate next index
    
        rgb_data_buffer[buffer_index_next] <= {
           red_data_0_in, red_data_1_in, red_data_2_in, red_data_3_in, red_data_4_in, red_data_5_in, red_data_6_in, red_data_7_in, red_data_8_in, red_data_9_in, red_data_10_in, red_data_11_in,
           green_data_0_in, green_data_1_in, green_data_2_in, green_data_3_in, green_data_4_in, green_data_5_in, green_data_6_in, green_data_7_in, green_data_8_in, green_data_9_in, green_data_10_in, green_data_11_in,
           blue_data_0_in, blue_data_1_in, blue_data_2_in, blue_data_3_in, blue_data_4_in, blue_data_5_in, blue_data_6_in, blue_data_7_in, blue_data_8_in, blue_data_9_in, blue_data_10_in, blue_data_11_in
       }; // Store in the next buffer index
    
        buffer_index <= buffer_index_next; // Update buffer index
    end

    // Store the combined RGB data in the buffer
    always @(posedge red_data_0_in or posedge green_data_0_in or posedge blue_data_0_in) begin
        rgb_data_buffer[buffer_index] <= rgb_data;
        buffer_index = (buffer_index + 1) % BUFFER_DEPTH;
    end
endmodule
