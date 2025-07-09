				//reference up_downl//


class reference_model;

	mailbox #(transaction) wm2rm;
	mailbox #(transaction) rm2sb;

	transaction t1;

	function new (	mailbox #(transaction) wm2rm,
			mailbox #(transaction) rm2sb  );

		this.wm2rm = wm2rm;
		this.rm2sb = rm2sb;

	endfunction
	
	virtual task dummy_rtl(	transaction t1 );
	
	//	$display("BEFORE DUMMY RTL  = %p ", t1);


	if (t1.reset) 
        begin           
          t1.count <= 4'd0;
        end
      
        else if (t1.load && t1.data_in <= 4'd13)   
        begin  
          t1.count <= t1.data_in;
        end
      
        else if (t1.up_down) 
      begin      
            if (t1.count == 4'd13)   
                t1.count <= 4'd0;
            else
                t1.count <= t1.count + 1;
      end
      
        else
      begin                  
            if (t1.count == 4'd0)    
                t1.count <= 4'd13;
            else
                t1.count <= t1.count - 1;
      end

	//	$display("AFTER DUMMY RTL  = %p ", t1);


	endtask
	

	virtual task start;
		
		fork 
			begin 
				forever
					begin

						wm2rm.get(t1);
						dummy_rtl(t1);
						rm2sb.put(t1);
						t1.display("REFERENCE MODEL");
					end
			end
		join_none
		
	endtask

endclass
		
	
	


