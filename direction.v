module direction(clk, reset, sensor1_data, sensor2_data, direction);

input clk, reset;
input sensor1_data, sensor2_data;
output reg [1:0] direction;

parameter idle = 0,
          stage_00 = 1,
          stage_01 = 2,
          stage_10 = 3,
          stage_11 = 4;

reg [2:0] cur_state, next_state;
//wire [1:0] comb_data;
//assign comb_data = { sensor2_data, sensor1_data};

always @ (posedge clk) begin
    if (reset)
        cur_state <= idle;
    else    
        cur_state <= next_state;
end

always @ (posedge clk) begin
    case (cur_state)
    idle : begin
        if (sensor2_data == 0 && sensor1_data == 0) next_state = stage_00 ;
        else if (sensor2_data == 0 && sensor1_data == 1) next_state = stage_01;
        else if (sensor2_data == 1 && sensor1_data == 0) next_state = stage_10;
        else if (sensor2_data == 1 && sensor1_data == 1) next_state = stage_11;
        else next_state = idle;
    end

    stage_00 : begin
        if (sensor2_data == 0 && sensor1_data == 1) begin
            direction = 2'b11;
            next_state = stage_01;
            //$display("The disk is spinning clockwise.");
        end
        else if (sensor2_data == 1 && sensor1_data == 0) begin
            direction = 2'b00;
            next_state = stage_10;           
            //$display("The disk is spinning anti-clockwise.");
        end
        else if (sensor2_data == 0 && sensor1_data == 0) begin
            direction = 2'b01;
            next_state = stage_00;
            
            //$display("The disk is still.");
        end
        else begin
            direction = 2'b10;
            next_state = idle;
            
            //$display("Unknown state detected.");
        end
    end

    stage_01 : begin
        if (sensor2_data == 1 && sensor1_data == 1) begin
            direction = 2'b11;
            next_state = stage_11;
            
            //$display("The disk is spinning clockwise.");
        end
        else if (sensor2_data == 0 && sensor1_data == 0) begin
            direction = 2'b00;
            next_state = stage_00;
            
            //$display("The disk is spinning anti-clockwise.");
        end
        else if (sensor2_data == 0 && sensor1_data == 1) begin
            direction = 2'b01;
            next_state = stage_01;
            
            //$display("The disk is still.");
        end
        else begin
            direction = 2'b10;
            next_state = idle;
            
            //$display("Unknown state detected.");
        end
    end

    stage_10 : begin
        if (sensor2_data == 0 && sensor1_data == 0) begin
            direction = 2'b11;
            next_state = stage_00;
            
            //$display("The disk is spinning clockwise.");
        end
        else if (sensor2_data == 1 && sensor1_data == 1) begin
            direction = 2'b00;
            next_state = stage_11;
            
            //$display("The disk is spinning anti-clockwise.");
        end
        else if (sensor2_data == 1 && sensor1_data == 0) begin
            direction = 2'b01;
            next_state = stage_10;
            
            //$display("The disk is still.");
        end
        else begin
            direction = 2'b10;
            next_state = idle;
            
            //$display("Unknown state detected.");
        end
    end

    stage_11 : begin
        if (sensor2_data == 1 && sensor1_data == 0) begin
            next_state = stage_10;
            direction = 2'b11;
            //$display("The disk is spinning clockwise.");
        end
        else if (sensor2_data == 0 && sensor1_data == 1) begin
            next_state = stage_01;
            direction = 2'b00;
            //$display("The disk is spinning anti-clockwise.");
        end
        else if (sensor2_data == 1 && sensor1_data == 1) begin
            next_state = stage_11;
            direction = 2'b01;
            //$display("The disk is still.");
        end
        else begin
            next_state = idle;
            direction = 2'b10;
            //$display("Unknown state detected.");
        end
    end

    endcase
end

endmodule
          
          