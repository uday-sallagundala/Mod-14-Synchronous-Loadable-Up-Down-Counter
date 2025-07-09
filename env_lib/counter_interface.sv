				//interface//


interface counter_if (input bit clock);

	logic reset;
	logic up_down;
	logic load;
	logic [3:0] data_in;
	logic [3:0] count;
	

	clocking wr_drv_cb @(posedge clock);
		
	default input #1 output #1;
			
		output reset;
		output up_down;
		output load;
		output data_in;

	endclocking
		

	clocking wr_mon_cb @(posedge clock);
	
	default input #1 output #1;
			
		input reset;
		input up_down;
		input load;
		input data_in;

	endclocking

	clocking rd_mon_cb @(posedge clock);
		
	default input #1 output #1;
		
		input count;
	
	endclocking

	modport WR_DRV_MP ( clocking wr_drv_cb );

	modport WR_MON_MP ( clocking wr_mon_cb );

	modport RD_MON_MP ( clocking rd_mon_cb );


endinterface


		

	


