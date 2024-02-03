
class monitor;

   virtual fifo_if fif;
  
   mailbox #(transaction) mbx;
  
   transaction tr;

  
  

  
    function new(mailbox #(transaction) mbx);
      this.mbx = mbx;     
   endfunction;
  
  
  task run();
    tr = new();
    
    forever begin
      repeat(2) @(posedge fif.clock);
      tr.wr = fif.wr;
      tr.rd = fif.rd;
      tr.data_in = fif.data_in;
      tr.data_out = fif.data_out;
      tr.full = fif.full;
      tr.empty = fif.empty;
      
      
      mbx.put(tr);
      
      tr.display("MON");

    end
    
  endtask
  

  
endclass
