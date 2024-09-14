class AES_coverage_collector extends uvm_subscriber #(AES_Transaction);
`uvm_component_utils(AES_coverage_collector)

//transaction object
AES_Transaction tran_mon2sub;

//coverage group    
covergroup cov;
out:coverpoint tran_mon2sub.out;
endgroup:cov

// Constructor
function new(string name = "AES_coverage_collector", uvm_component parent = null);
super.new(name, parent);
cov  = new();
endfunction: new

//declare the build function
function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction: build_phase

//declare the connect function
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
endfunction: connect_phase

// Task: run_phase
task run_phase(uvm_phase phase);
super.run_phase(phase);
endtask: run_phase
// Task: write
function void write(AES_Transaction t);
tran_mon2sub =t;
cov.sample();
endfunction: write

endclass 
