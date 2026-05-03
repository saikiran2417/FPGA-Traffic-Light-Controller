module traffic_fsm(
    input clk,
    input reset,
    output reg [3:0] led
);

reg [1:0] state;
reg [31:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state   <= 2'b00;
        counter <= 32'd0;
    end else begin
        if (counter == 32'd50000000) begin
            counter <= 32'd0;
            if (state == 2'b00)
                state <= 2'b10;
            else if (state == 2'b10)
                state <= 2'b01;
            else
                state <= 2'b00;
        end else begin
            counter <= counter + 1;
        end
    end
end

always @(*) begin
    if (state == 2'b00)
        led = 4'b0001;
    else if (state == 2'b01)
        led = 4'b0010;
    else if (state == 2'b10)
        led = 4'b0100;
    else
        led = 4'b0000;
end

endmodule