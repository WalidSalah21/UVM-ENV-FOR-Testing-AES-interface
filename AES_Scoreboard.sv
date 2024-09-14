class AES_Scoreboard extends uvm_scoreboard;
`uvm_component_utils(AES_Scoreboard)

// Constructor
function new(string name = "AES_Scoreboard", uvm_component parent = null);
super.new(name, parent);
endfunction: new

//declare the analysis imp
uvm_analysis_imp #(AES_Transaction, AES_Scoreboard) imp;

//declare properties
int             file_handle;
logic [127:0]   py_out;
int       count;


//declare the build function
function void build_phase(uvm_phase phase);
super.build_phase(phase);
imp = new("imp", this);
endfunction: build_phase

//declare the connect function
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
endfunction: connect_phase

// Task: run_phase
task run_phase(uvm_phase phase);
super.run_phase(phase);
endtask: run_phase



//  write_function  
function void write (AES_Transaction t); 

    file_handle = $fopen("out_file.txt","r");
    if ($fscanf(file_handle, "%h", py_out) == 0) begin
        $display("Error: no output exist");
    
    end
    else if (py_out==t.out) begin
        $display("operation ID:%4d, Passed Encryption:\n Expected_py: %h \n Checked:     %h", count, py_out, t.out);
        $display("-------------------------------");
        //$stop;
    end
    else if (py_out!=t.out) begin
        $display("operation ID:%4d, Failed Encryption:\n Expected_py: %h \n Checked:     %h", count, py_out, t.out);
        $display("-------------------------------");
      
    end
    $fclose(file_handle);
endfunction 


endclass: AES_Scoreboard
