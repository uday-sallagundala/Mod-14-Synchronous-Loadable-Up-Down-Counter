class test;

	virtual counter_if.WR_DRV_MP wr_drv_if;
	virtual counter_if.WR_MON_MP wr_mon_if;
	virtual counter_if.RD_MON_MP rd_mon_if;

	function new(	virtual counter_if.WR_DRV_MP wr_drv_if,
			virtual counter_if.WR_MON_MP wr_mon_if,
			virtual counter_if.RD_MON_MP rd_mon_if  ); 
		
		this.wr_drv_if = wr_drv_if;
		this.wr_mon_if = wr_mon_if;
		this.rd_mon_if = rd_mon_if;

	endfunction

	environment env_h;
	
	virtual task start;
	
		env_h = new ( wr_drv_if, wr_mon_if, rd_mon_if );
		env_h.final_run();
	
	endtask

endclass


