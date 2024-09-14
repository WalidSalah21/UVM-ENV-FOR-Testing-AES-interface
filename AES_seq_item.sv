class AES_Transaction extends uvm_sequence_item;
`uvm_object_utils(AES_Transaction)
// function new
function new(string name = "AES_Transaction");
super.new(name);
endfunction: new

    rand  logic  [127:0]  in ;
    rand  logic  [127:0]  key;
          logic  [127:0]  out;
endclass: AES_Transaction

