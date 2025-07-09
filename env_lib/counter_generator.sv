class generator;

	transaction t1;
	transaction t2;
	
	mailbox #(transaction) gen2wd;
	
	function new (mailbox #(transaction) gen2wd );		
		this.gen2wd = gen2wd;
		this.t1 = new;	
	endfunction	
		
	virtual task start;	
		fork
			begin
				for (int i = 0; i <= no_of_transactions; i++ )
					begin
						t1.randomize();
						t2 = new t1;
						gen2wd.put(t2);
						t2.display("GENERATOR CLASS");					
					end
			end
		join_none
	endtask
endclass
		
		


