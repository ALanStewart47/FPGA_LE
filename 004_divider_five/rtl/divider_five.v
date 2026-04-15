module divider_five
(
    input   wire    sys_clk     ,
    input   wire    sys_rst_n   ,

    output  wire    clk_out  
);

reg [2:0]   cnt;
reg         clk1;
reg         clk2;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n != 1'd0)
        cnt <= 3'd0
    else if (cnt == 3'd4)
        cnt <= 3'd0;
    else
        cnt <= cnt + 1'd1;

always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n != 1'd0)
        clk1 <= 1'd1;
    else if(cnt == 3'd2)
        clk1 <= 1'd0;
    else if (cnt == 3'd4)
        clk1 <= 1'd1;

always@(negedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n != 1'd0)
        clk2 <= 1'd1;
    else if(cnt == 3'd2)
        clk2 <= 1'd0;
    else if(cnt == 3'd4)
        clk2 <= 1'd1;

assign clk_out = clk1 & clk2;

endmodule