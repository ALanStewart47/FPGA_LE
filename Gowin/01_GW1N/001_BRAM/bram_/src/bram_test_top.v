module bram_test_top #(
    parameter SLOW_DIV = 26'd24_999_999
) (
    input           clk,
    input           rst_n,
    output  [3:0]   led,
    output          led_half,

    output  [1:0]   state_led
);
    
    localparam IDLE     = 2'd0;
    localparam WRITE    = 2'd1;    
    localparam READ     = 2'd2;
    localparam DONE     = 2'd3;

    reg [1:0]   state;
    reg [7:0]   addr;
    reg [7:0]   wdata;
    reg [7:0]   dout_latched;
    reg         wre ;

    reg         show_high;

    reg [25:0]  slow_cnt;
    wire        slow_tick = (slow_cnt == SLOW_DIV);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            slow_cnt <= 26'd0;
        end else if (slow_tick) begin
            slow_cnt <= 26'd0;
        end else    begin
            slow_cnt <= slow_cnt + 1'b1;
        end
    end

    wire [7:0] do_full;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state           <= IDLE;
            addr            <= 8'd0;
            wdata           <= 8'd0;
            wre             <= 1'b0;
            dout_latched    <= 8'd0;
            show_high       <= 1'b0;
        end else begin
            case (state) 
                IDLE: begin
                    state <= WRITE;
                    addr  <= 8'd0;
                    wdata <= 8'd0;
                    wre   <= 1'b1;        
                end
                WRITE : begin
                    if (addr == 8'd255) begin
                        state <= READ;
                        addr <= 8'd0;
                        wre <= 1'd0;
                    end else begin
                        addr  <= addr   + 1'b1;
                        wdata <= wdata  + 1'b1;
                    end
                end
                READ : begin
                    if (slow_tick ) begin
                        show_high <= ~ show_high;

                        if (show_high == 1'b1) begin
                            if (addr == 8'd255) 
                                state <= DONE;
                            else 
                                addr <= addr + 8'd1; 
                        end
                    end
                    dout_latched <= do_full[7:0];
                end
                DONE: begin
                    
                end
            endcase
        end
    end


    // led out 
    wire [3:0] display_nibble = show_high ? dout_latched[7:4] : dout_latched[3:0];

    assign led          = ~display_nibble;
    assign led_half     = show_high;
    assign state_led    = state;


    Gowin_SP u_sp (
        .dout   (do_full),
        .clk    (clk),
        .oce    (1'b1),
        .ce     (1'b1),
        .reset  (~rst_n),
        .wre    (wre),
        .ad     (addr),
        .din    (wdata)
    );


/*
    SP u_sp (
        .DO     (do_full),
        .CLK    (clk),
        .OCE    (1'b1),
        .CE     (1'b1),
        .RESET  (~rst_n),
        .WRE    (wre),
        .BLKSEL (3'b000),
        .AD     ({3'b000, addr, 3'b000}),
        .DI     ({24'b0, wdata})
    );

    defparam u_sp.READ_MODE = 1'b0;
    defparam u_sp.WRITE_MODE= 2'b00;
    defparam u_sp.BIT_WIDTH = 8;
    defparam u_sp.BLK_SEL   = 3'b000;
    defparam u_sp.RESET_MODE = "SYNC";
*/
endmodule