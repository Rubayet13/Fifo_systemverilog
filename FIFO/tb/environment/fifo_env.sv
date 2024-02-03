class environment;

    generator gen;
    driver drv;
  
    monitor mon;
    scoreboard sco;
  
  mailbox #(transaction) gdmbx; ///generator + Driver
    
  mailbox #(transaction) msmbx; ///Monitor + Scoreboard

  event nextgs;
 

  virtual fifo_if fif;
  
  
  function new(virtual fifo_if fif);
 
    
    
    gdmbx = new();
    gen = new(gdmbx);
    drv = new(gdmbx);
    
    
    
    
    msmbx = new();
    mon = new(msmbx);
    sco = new(msmbx);
    
    
    this.fif = fif;
    
    drv.fif = this.fif;
    mon.fif = this.fif;
    
    
    gen.next = nextgs;
    sco.next = nextgs;

  endfunction
  
  
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
  fork
    gen.run();
    drv.run();
    mon.run();
    sco.run();
  join_any
    
  endtask
  
  task post_test();
    wait(gen.done.triggered);  
    $finish();
  endtask
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
  
  
  
endclass