class environment;
	
	virtual counter_if.WR_DRV_MP wr_drv_if;
	virtual counter_if.WR_MON_MP wr_mon_if;
	virtual counter_if.RD_MON_MP rd_mon_if;//initialising virtual interface

	mailbox #(transaction) gen2wd;
	mailbox #(transaction) wm2rm;
	mailbox #(transaction) rdm2sb;
	mailbox #(transaction) rm2sb;//initialising mailbox handles

	generator 	gen_h;
	write_driver 	wr_drv_h;
	write_monitor	wr_mon_h;
	read_monitor	rd_mon_h;
	reference_model	ref_mod_h;
	score_board	scb_h;//creating handles

	function new (	virtual counter_if.WR_DRV_MP wr_drv_if,
			virtual counter_if.WR_MON_MP wr_mon_if,
			virtual counter_if.RD_MON_MP rd_mon_if	);
		this.wr_drv_if = wr_drv_if;
		this.wr_mon_if = wr_mon_if;			//geting the address of interface form test file
		this.rd_mon_if = rd_mon_if;	
	endfunction


	virtual task build;
		
		gen2wd  = new();
		wm2rm 	= new();
		rdm2sb  = new();
		rm2sb 	= new();//creating objects for the mailbox
		
		gen_h 	  = new(gen2wd);
		wr_drv_h  = new(wr_drv_if,gen2wd);
		wr_mon_h  = new(wr_mon_if,wm2rm);
		rd_mon_h  = new(rd_mon_if,rdm2sb);
		ref_mod_h = new(wm2rm,rm2sb);
		scb_h 	  = new(rm2sb,rdm2sb);//sending the address as arguments to 
	
	endtask


	virtual task start;		
		gen_h.start;
		wr_drv_h.start;
		wr_mon_h.start;
		rd_mon_h.start;
		ref_mod_h.start;
		scb_h.start;

	endtask


	virtual task stop;		
		wait(scb_h.OVER.triggered);
	endtask


	virtual task final_run;		
		build();
		start();
		stop();
	endtask
endclass	



