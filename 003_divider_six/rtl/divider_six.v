
/*module divider_six (
    input    wire  sys_clk      ,
    input    wire  sys_rst_n    ,

    output   reg   clk_out
);

parameter CNT_MAX = 2'd2;
reg [1:0] cnt;

always @(posedge sys_clk or negedge sys_rst_n) 
    if(!sys_rst_n)
        cnt <= 2'd0;
    else if (cnt == CNT_MAX)
        cnt <= 2'd0;
    else
        cnt <= cnt + 1'd1;

always @(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        clk_out <= 2'd0;
    else if (cnt == CNT_MAX)
        clk_out = ~clk_out;
    else 
        clk_out = clk_out;

endmodule*/

module divider_six (
    input   wire    sys_clk     ,
    input   wire    sys_rst_n   ,

    output  reg     clk_flag
);

parameter CNT_MAX = 4'd5;
reg [2:0] cnt;

always @(posedge sys_clk or negedge sys_rst_n) 
    if(!sys_rst_n)
        cnt <= 3'd0;
    else if (cnt == CNT_MAX)
        cnt <= 3'd0;
    else
        cnt <= cnt + 1'd1;

always @(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        clk_flag <= 3'd0;
    else if (cnt == CNT_MAX - 1'd1 )
        clk_flag = 1'd1;
    else 
        clk_flag = 1'd0;

    
endmodule
