`timescale 1ns/1ps
module bit8rcc_tb;
wire [7:0]q,qb;
reg clk,rst;
ripple_carry_counter_8bit dut (q,qb,clk,rst);
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin
rst=1;
#5 rst=0;
end
initial begin
$monitor("Q=%b CLK=%d reset=%b",q,clk,rst);
end
initial begin
$dumpfile("8bitrcc.vcd");
$dumpvars(0,bit8rcc_tb);
#100 $finish;
end
endmodule
