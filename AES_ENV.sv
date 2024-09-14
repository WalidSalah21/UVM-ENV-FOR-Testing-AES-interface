class AES_env extends uvm_env;
`uvm_component_utils(AES_env)

// Constructor
function new(string name = "AES_env", uvm_component parent = null);
super.new(name, parent);
endfunction: new

//declare the conponents
AES_Agent my_agent;
AES_Scoreboard my_scoreboard;
AES_coverage_collector my_collector;

//declare the virtual interface
virtual AES_INTERFACE my_vif;

//declare the build function
function void build_phase(uvm_phase phase);
super.build_phase(phase);
my_agent = AES_Agent::type_id::create("my_agent", this);
my_scoreboard = AES_Scoreboard::type_id::create("my_scoreboard", this);
my_collector = AES_coverage_collector::type_id::create("my_collector", this);
if(
    !uvm_config_db #(virtual AES_INTERFACE)::get(this, "", "test2env", my_vif)
  )
`uvm_fatal(get_full_name(), "[AES_env] vif not get")

uvm_config_db #(virtual AES_INTERFACE)::set(this, "my_agent", "env2agent", my_vif);
endfunction: build_phase

//declare the connect function
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
my_agent.m_monitor.port.connect(my_collector.analysis_export);
my_agent.m_monitor.port.connect(my_scoreboard.imp);
endfunction: connect_phase

// Task: run_phase
task run_phase(uvm_phase phase);
super.run_phase(phase);
endtask: run_phase
endclass: AES_env
