class AES_Sequencer extends uvm_sequencer #(AES_Transaction);
    `uvm_component_utils(AES_Sequencer)
    // Constructor
    function new(string name = "AES_Sequencer", uvm_component parent = null);
    super.new(name, parent);
    endfunction: new

    // Build function 
    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    endfunction: build_phase

    // Connect function
    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    endfunction: connect_phase

    // Task: run_phase
    task run_phase(uvm_phase phase);
    super.run_phase(phase);
    endtask: run_phase 
endclass: AES_Sequencer
