`timescale  1ns/1ns

module tb_touch_key ();

wire led      ;

reg sys_clk   ;
reg sys_rst_n ;
reg touch_key ;

integer rand_delay;

initial begin
    sys_clk      = 1'b1;
    sys_rst_n   <= 1'b0;
    touch_key   <= 1'b1;
    #20
    sys_rst_n   <= 1'b1;
    /*#200
    touch_key   <= 1'b0;
    #500
    touch_key   <= 1'b1;
    #1000
    touch_key   <= 1'b0;
    #500
    touch_key   <= 1'b1;*/

    forever begin
        rand_delay = $urandom_range(1,9) * 100;
        #rand_delay touch_key <= 1'b0;

        rand_delay = $urandom_range(1,9) * 100;
        #rand_delay touch_key <= 1'b1;
    end
end



always #10 sys_clk = ~sys_clk;

touch_key touch_key_inst(
    .sys_clk        (sys_clk    ),
    .sys_rst_n      (sys_rst_n  ),
    .touch_key      (touch_key  ),

    .led            (led        )
);


endmodule