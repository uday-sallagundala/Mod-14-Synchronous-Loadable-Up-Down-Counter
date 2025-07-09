module top();

  	import pkg::*;   
	reg clock = 0;
	
counter_if CIF(clock);

	test test_h;

	up_down_counter dut (.clock(clock),
			.reset(CIF.reset),
			.up_down(CIF.up_down),
			.load(CIF.load),
			.data_in(CIF.data_in),
			.count(CIF.count)
						);

	initial 
		begin	
			forever #5 clock = ~clock;
		end

	initial
		begin 
			`ifdef VCS
         		$fsdbDumpvars(0, top);
        		`endif
			
			if($test$plusargs("TEST1"))
				begin
					test_h = new( CIF, CIF, CIF );
					test_h.start();
					#200;
					$finish;
				end
		end
endmodule
		



