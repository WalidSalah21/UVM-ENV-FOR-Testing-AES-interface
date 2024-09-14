class MY_test extends uvm_test;
`uvm_component_utils(MY_test)

// Constructor
function new(string name = "MY_test", uvm_component parent = null);
super.new(name, parent);
endfunction: new

//declare the environment and sequence
AES_env my_env;
AES_Sequence my_seq;

//declare the interface
virtual AES_INTERFACE vif;

//declare the build function
function void build_phase(uvm_phase phase);
super.build_phase(phase);
my_env = AES_env::type_id::create("my_env", this);
my_seq = AES_Sequence::type_id::create("my_seq", this);

if (
    !uvm_config_db #(virtual AES_INTERFACE)::get(this,"", "top2tast", vif)
    ) begin
        `uvm_fatal(get_full_name(), "[MY_test] vif not get");
end
    uvm_config_db #(virtual AES_INTERFACE)::set(this, "my_env", "test2env", vif);
endfunction: build_phase

//declare the connect function
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);

endfunction: connect_phase

// Task: run_phase
task  run_phase(uvm_phase phase) ;
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("walid_test", "Raising objection", UVM_LOW)
    my_seq.start(my_env.my_agent.m_sequencer);
    `uvm_info("walid_test", "Dropping objection", UVM_LOW)
    phase.drop_objection(this);
    $display("walid_test_run_phase");
endtask

endclass: MY_test

