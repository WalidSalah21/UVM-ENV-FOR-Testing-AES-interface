`timescale 1ns/1ps
`include"AES_INTERFACE.sv"
import uvm_pkg::*;
import AES_Package::*;
module  AES_TOP;
parameter Encrypt_count =100; 
bit clk;

//interface instantiation
AES_INTERFACE intf();

//dut instantiation
AES_Encrypt AES_Encrypt_1  (intf.in,intf.key,intf.out);
initial begin
    uvm_config_db#(virtual AES_INTERFACE)::set(null,"uvm_test_top","top2tast",intf);
    run_test("MY_test");
end   
endmodule
