class AES_Agent extends uvm_agent;
  `uvm_component_utils(AES_Agent)
  // Components
  AES_Driver m_driver;
  AES_Sequencer m_sequencer;
  AES_Monitor m_monitor;
  
  // Constructor
  function new(string name = "AES_Agent", uvm_component parent = null);
  super.new(name, parent);
  endfunction: new
//interface
  virtual AES_INTERFACE m_vif;

  // Build Phase
    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_driver    = AES_Driver::type_id::create("m_driver", this);
    m_sequencer = AES_Sequencer::type_id::create("m_sequencer", this);
    m_monitor   = AES_Monitor::type_id::create("m_monitor", this);


    if(!uvm_config_db #(virtual AES_INTERFACE)::get(this, "", "env2agent", m_vif))
    `uvm_fatal(get_full_name(), "[AES_Agent] vif not get")

    uvm_config_db #(virtual AES_INTERFACE)::set(this, "m_driver", "driver2agent", m_vif);
    uvm_config_db #(virtual AES_INTERFACE)::set(this, "m_monitor", "monitor2agent", m_vif);
  endfunction: build_phase

  // Connect Phase
    function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    endfunction: connect_phase

  // Task: run_phase
    task run_phase(uvm_phase phase);
    super.run_phase(phase);
    endtask: run_phase
endclass
