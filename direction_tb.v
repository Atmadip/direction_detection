`timescale 1ns/1ns
`include "direction.v"

module direction_tb();

reg clk, reset;
reg sensor1_data, sensor2_data;
wire [1:0] direction;

direction UUT(clk, reset, sensor1_data, sensor2_data, direction);

always #10 clk = ~clk;

initial begin
    $dumpfile ("direction_tb.vcd");
    $dumpvars (0, direction_tb);

    $display("time\t clk reset sensor2_data sensor1_data direction");
    $monitor("%g\t   %b\t %b\t %b\t %b\t%b",  
            $time, clk, reset, sensor2_data, sensor1_data, direction);

    reset = 1'b1;
    clk = 1'b0;
    #30;

    reset = 1'b0;
    sensor1_data = 1'b1;
    sensor2_data = 1'b0;
    #20;

    sensor1_data = 1'b1;
    sensor2_data = 1'b1;
    #20;

    sensor1_data = 1'b0;
    sensor2_data = 1'b1;
    #20;

    sensor1_data = 1'b0;
    sensor2_data = 1'b0;
    #20;

    sensor1_data = 1'b0;
    sensor2_data = 1'b0;
    #20;

    sensor1_data = 1'b0;
    sensor2_data = 1'b0;
    #20;

    sensor1_data = 1'b0;
    sensor2_data = 1'b1;
    #20;

    sensor1_data = 1'b1;
    sensor2_data = 1'b1;
    #20;

    sensor1_data = 1'b0;
    sensor2_data = 1'b1;
    #20;

    sensor1_data = 1'b1;
    sensor2_data = 1'b0;
    #20;
    $display("Test complete.\n");
    $finish;

end

endmodule