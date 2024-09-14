class AES_Sequence extends uvm_sequence;
`uvm_object_utils(AES_Sequence)

//*************************************//
///**declare my_trans object**///  
    AES_Transaction my_trans;


int file_handle;
int read_handle;
logic  [127:0] py_out_1,py_out_2;
int Encrypt_count = 100;
//*************************************//
///**Constructor**/// 
extern function new(string name = "AES_Sequence");
   
//*************************************//
/////////****body task****/////////
extern task body();
endclass: AES_Sequence


////////////////////////////// 
/////**** Constructor****/////
function AES_Sequence::new(string name = "AES_Sequence");
    super.new(name);
    endfunction: new

////////////////////////////// 
/////////****body****/////////
 task AES_Sequence::body();
 for(int i =0;i<Encrypt_count;i++)   //run the sequance 100 times check???
begin
    my_trans = AES_Transaction::type_id::create("my_trans");
    start_item(my_trans);
    $display("[sequance] start body %0d",i);
    if(!my_trans.randomize(in, key)) begin
    $display("errorrrrrrrrr");
    end


    file_handle = $fopen("in_file.txt","w");


    $fwrite(file_handle,"%h\n%h",my_trans.in,my_trans.key);

    $fclose(file_handle);

    $system("python AES_model.py");  //run the python model ???


    // Open the file for reading
    read_handle = $fopen("in_file.txt", "r");
    assert(read_handle != 0) else `uvm_fatal("file_error", "file not found");

    // Read the output from the file
    void'($fscanf(read_handle, "%h\n%h", py_out_1,py_out_2));
    $fclose(read_handle);

    // Display the read value (optional)
    $display("Read value from in_file.txt 1: %h", py_out_1);
    $display("Read value from in_file.txt 2: %h", py_out_2);
    $display("[sequance] finish body %0d",i);
    finish_item(my_trans);
end
endtask: body

