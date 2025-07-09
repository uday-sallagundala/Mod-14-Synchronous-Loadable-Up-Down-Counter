package pkg;

   int no_of_transactions = 100;
    
     `include "counter_transaction.sv"
     `include "counter_generator.sv"
     `include "counter_driver.sv"
     `include "counter_write_monitor.sv"
     `include "counter_read_monitor.sv"
     `include "counter_reference_model.sv"
     `include "counter_scoreboard.sv"
     `include "counter_env.sv"
     `include "counter_test.sv"

   

endpackage

