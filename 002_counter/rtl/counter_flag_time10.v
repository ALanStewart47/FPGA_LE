module counter_flag 
#(
    parameter CNT_MAX = 25'd24_999_999
)
(
    input  wire     sys_clk     ,
    input  wire     sys_rst_n   ,

    output  reg     led_out
);

reg [24:0]  cnt;
reg         cnt_flag;   //flag of cnt max
reg [4:0]   toggle_cnt;     //blink 10 times 

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'd0)
        cnt <= 25'd0;
    else if (cnt == CNT_MAX- 1'd1)
        cnt <= 25'd0;
    else
        cnt <= cnt + 1'd1;


always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'd0) begin
        cnt_flag    <= 1'd0;
        toggle_cnt  <= 5'd0;
    end
    else if (cnt == CNT_MAX - 1'd1) begin
        cnt_flag    <= 1'd1;
        toggle_cnt  <= toggle_cnt +1'd1;
    end
    else begin
        cnt_flag    <= 1'd0;
        toggle_cnt  <= toggle_cnt;
    end
       

always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        led_out <= 1'd0;
    else if((cnt_flag) && (toggle_cnt < 5'd20))
        led_out <= ~led_out;
    else
        led_out <= led_out;


endmodule