					//write driver//

class write_driver;

	virtual counter_if.WR_DRV_MP wr_drv_if;
	
	transaction t1;
	
	mailbox #(transaction) gen2wd;

	function new (	virtual counter_if.WR_DRV_MP wr_drv_if,
			mailbox #(transaction) gen2wd );

		this.wr_drv_if = wr_drv_if;
		this.gen2wd = gen2wd;
	endfunction

	virtual task drive;
	
		@(wr_drv_if.wr_drv_cb);
		wr_drv_if.wr_drv_cb.up_down  <=  t1.up_down;
		wr_drv_if.wr_drv_cb.load  <=  t1.load;
		wr_drv_if.wr_drv_cb.data_in  <=  t1.data_in;
			
	endtask
	
	virtual task driv_delay;

		@(wr_drv_if.wr_drv_cb);	
		wr_drv_if.wr_drv_cb.reset <=  1'b1;
		@(wr_drv_if.wr_drv_cb);
		wr_drv_if.wr_drv_cb.reset <=  1'b0;

	endtask
	

	virtual task start;
		
		fork 
			begin
				driv_delay;
				forever
					begin 
						gen2wd.get(t1);
						drive();
						t1.display("WRITE DRIVER");
					end
			end
		join_none
	
	endtask

endclass
						


