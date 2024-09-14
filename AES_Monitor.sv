class AES_Monitor extends uvm_monitor;
`uvm_component_utils(AES_Monitor)

// Constructor
function new(string name = "AES_Monitor", uvm_component parent = null);
super.new(name, parent);
endfunction: new

//declare the interface
virtual AES_INTERFACE vif;

//declare transaction 
AES_Transaction my_trans;

//declare analysis port
uvm_analysis_port #(AES_Transaction) port;

logic [127:0]  out;

// Build function
function void build_phase(uvm_phase phase);
super.build_phase(phase);
port = new("port", this);
my_trans =AES_Transaction::type_id::create("my_trans");

if(
        !uvm_config_db #(virtual AES_INTERFACE)::get(this, "", "monitor2agent", vif)
  )
`uvm_fatal(get_full_name(), "[AES_Monitor] vif not get")
endfunction: build_phase

// Connect function
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
endfunction: connect_phase

// Task: run_phase
task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
        @(vif.out);
        $display("[AES_monitor] the value of dut out %h",vif.out);
        my_trans.out   =  vif.out;
        port.write(my_trans);
        $display("[AES_monitor] done");
        end
endtask: run_phase

// 
endclass: AES_Monitor
