module Vending_Machine_RF
(
input wire sys_clk ,
input wire sys_rst_n ,
input wire pi_money_one ,
input wire pi_money_half ,
output reg [2:0] po_money ,
output reg po_beverage
);

parameter IDLE = 4'b0001;
parameter HALF = 4'b0010;
parameter ONE = 4'b0100;
parameter ONE_HALF = 4'b1000;

reg [3:0] state;

wire [1:0] pi_money;

assign pi_money = {pi_money_one, pi_money_half};

always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
state <= IDLE;
else case(state)
IDLE : if(sys_rst_n == 1'b0)
state <= IDLE;
else if(pi_money == 2'b01)
state <= HALF;
else if(pi_money == 2'b10)
state <= ONE;
else
state <= IDLE;
HALF : if(sys_rst_n == 1'b0)
state <= IDLE;
else if(pi_money == 2'b01)
state <= ONE;
else if(pi_money == 2'b10)
state <= ONE_HALF;
else
state <= HALF;
ONE : if(sys_rst_n == 1'b0)
state <= IDLE;
else if(pi_money == 2'b01)
state <= ONE_HALF;
else if(pi_money == 2'b10)
state <= IDLE;
else
state <= ONE;
ONE_HALF: if(sys_rst_n == 1'b0)
state <= IDLE;
else if(pi_money == 2'b01)
state <= IDLE;
else if(pi_money == 2'b10)
state <= IDLE;
else
state <= ONE_HALF;
default : state <= IDLE;
endcase

always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
po_beverage <= 1'b0;
else if((state == ONE_HALF && pi_money == 2'b01) || (state == ONE_HALF && pi_money == 2'b10) || (state == ONE && pi_money == 2'b10))
po_beverage <= 1'b1;
else
po_beverage <= 1'b0;

always@(posedge sys_clk )
if((state == HALF) && (sys_rst_n == 1'b0))
po_money <= 3'b001;
else if((state == ONE) && (sys_rst_n == 1'b0))
po_money <= 3'b010;
else if((state == ONE_HALF) && (sys_rst_n == 1'b0))
po_money <= 3'b100;
else if((state == ONE_HALF) && (pi_money == 2'b10))
po_money <= 3'b001;
else
po_money <= 3'b000;

endmodule