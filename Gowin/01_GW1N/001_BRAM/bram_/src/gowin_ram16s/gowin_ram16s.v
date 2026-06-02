//Copyright (C)2014-2026 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: IP file
//Tool Version: V1.9.12.02_SP2 (64-bit)
//IP Version: 1.0
//Part Number: GW1N-UV9LQ144C6/I5
//Device: GW1N-9
//Created Time: Mon Jun  1 11:21:28 2026

module Gowin_RAM16S (dout, di, ad, wre, clk);

output [7:0] dout;
input [7:0] di;
input [0:0] ad;
input wre;
input clk;

wire gw_gnd;

assign gw_gnd = 1'b0;

RAM16S4 ram16s_inst_0 (
    .DO(dout[3:0]),
    .DI(di[3:0]),
    .AD({gw_gnd,gw_gnd,gw_gnd,ad[0]}),
    .WRE(wre),
    .CLK(clk)
);

defparam ram16s_inst_0.INIT_0 = 16'h0000;
defparam ram16s_inst_0.INIT_1 = 16'h0000;
defparam ram16s_inst_0.INIT_2 = 16'h0000;
defparam ram16s_inst_0.INIT_3 = 16'h0000;

RAM16S4 ram16s_inst_1 (
    .DO(dout[7:4]),
    .DI(di[7:4]),
    .AD({gw_gnd,gw_gnd,gw_gnd,ad[0]}),
    .WRE(wre),
    .CLK(clk)
);

defparam ram16s_inst_1.INIT_0 = 16'h0000;
defparam ram16s_inst_1.INIT_1 = 16'h0000;
defparam ram16s_inst_1.INIT_2 = 16'h0000;
defparam ram16s_inst_1.INIT_3 = 16'h0000;

endmodule //Gowin_RAM16S
