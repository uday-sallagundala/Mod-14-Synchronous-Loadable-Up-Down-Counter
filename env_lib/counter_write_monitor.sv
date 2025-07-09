				//writr monitor//

class write_monitor;
	
	virtual counter_if.WR_MON_MP wr_mon_if;
	
	transaction t1;

	mailbox #(transaction) wm2rm;
	
	
	function new (	virtual counter_if.WR_MON_MP wr_mon_if,
			mailbox #(transaction) wm2rm );

		this.wr_mon_if = wr_mon_if;
		this.wm2rm = wm2rm;
		t1 = new();

	endfunction
	
	virtual task sample;
		
		@(wr_mon_if.wr_mon_cb);
		t1.reset =  wr_mon_if.wr_mon_cb.reset;
		t1.up_down  =  wr_mon_if.wr_mon_cb.up_down;
		t1.load  =  wr_mon_if.wr_mon_cb.load;
		t1.data_in =  wr_mon_if.wr_mon_cb.data_in;

	endtask

	virtual task write_mon_delay;

		@(wr_mon_if.wr_mon_cb);
		t1.reset =  1'b1;
		#10;
		t1.reset =  1'b0;

	endtask
		

	virtual task start;
		
		fork
			begin 
			write_mon_delay;
				forever
					begin 
						sample();
						wm2rm.put(t1);
						t1.display("WRITE MONITIOR");
					end
			end
		join_none
	
	endtask
	
endclass	


