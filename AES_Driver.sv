class AES_Driver extends uvm_driver #(AES_Transaction);
`uvm_component_utils(AES_Driver)

// Constructor
function new(string name = "AES_Driver", uvm_component parent = null);
super.new(name, parent);
endfunction: new

//create transaction object
AES_Transaction my_trans;

//declare the virtual interface
virtual AES_INTERFACE vif;

// Build function 
function void build_phase(uvm_phase phase);
super.build_phase(phase);
my_trans =AES_Transaction::type_id::create("my_trans");

if(
    !uvm_config_db #(virtual AES_INTERFACE)::get(this, "", "driver2agent", vif)
  )
`uvm_fatal(get_full_name(), "[AES_Monitor] vif not get")
endfunction: build_phase

// Connect function
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
endfunction: connect_phase

// Task: run_phase
task run_phase(uvm_phase phase);
    forever begin   
    seq_item_port.get_next_item(my_trans);
        vif.in  <= my_trans.in;
        vif.key <= my_trans.key;
    seq_item_port.item_done();
    $display("[driver] done");
    end
endtask: run_phase
endclass: AES_Driver