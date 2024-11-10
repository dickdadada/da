`timescale 1ns/1ns

module tb_Vending_Machine();

 reg sys_clk;
 reg pi_money_one;
 reg pi_money_half;
 reg random_data_gen;
 
 wire po_beverage;
 wire po_money;

 
 initial begin
 sys_clk = 1'b1;
 end

 always #10 sys_clk = ~sys_clk;

 
 always@(posedge sys_clk )
 random_data_gen <= {$random} % 2;


 always@(posedge sys_clk )
 pi_money_one <= random_data_gen;


 always@(posedge sys_clk )
 pi_money_half <= ~random_data_gen;

 wire [4:0] state = Vending_Machine_inst.state;
 wire [1:0] pi_money = Vending_Machine_inst.pi_money;

 initial begin
 $timeformat(-9, 0, "ns", 6);
 $monitor("@time %t: pi_money_one=%b pi_money_half=%b pi_money=%b state=%b po_beverage=%b po_money=%b", $time, pi_money_one, pi_money_half, pi_money, state, po_beverage, po_money);
 end

 Vending_Machine Vending_Machine_inst(
 .sys_clk (sys_clk ),
 .pi_money_one (pi_money_one ),
 .pi_money_half (pi_money_half ), 
 .po_beverage (po_beverage ), 
 .po_money (po_money ) 
 );

 endmodule