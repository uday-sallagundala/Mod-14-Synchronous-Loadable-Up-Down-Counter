				//read monitor//


class read_monitor;
	
	virtual counter_if.RD_MON_MP rd_mon_if;
	
	transaction t1;

	mailbox #(transaction) rdm2sb;
	
	
	function new (	virtual counter_if.RD_MON_MP rd_mon_if,
			mailbox #(transaction) rdm2sb );

		this.rd_mon_if = rd_mon_if;
		this.rdm2sb = rdm2sb;
	
	endfunction

	virtual task sample;
	
		@(rd_mon_if.rd_mon_cb);
		t1.count = rd_mon_if.rd_mon_cb.count;
	
	endtask


	virtual task read_mon_delay;
		@(rd_mon_if.rd_mon_cb);
		@(rd_mon_if.rd_mon_cb);
		//delay for sync
	endtask
		

	virtual task start;
		
		fork
			begin 
			read_mon_delay;
				forever
					begin 
						t1 = new();
						sample();
						rdm2sb.put(t1);
						t1.display("READ MONITOR");
					end
			end
		join_none
	
	endtask

endclass
	
		


