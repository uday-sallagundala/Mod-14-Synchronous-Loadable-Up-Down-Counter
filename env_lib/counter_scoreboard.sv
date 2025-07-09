				//scoreboard//


class score_board;

	event OVER;

	static int to_stop;
	
	transaction t1;
	transaction t2;
	transaction t3;

	mailbox #(transaction) rm2sb;
	mailbox #(transaction) rdm2sb;

	covergroup count_cov;
	//	option.per_instance = 1
		
		rs : coverpoint t3.reset{
					  bins zerne = {[0:1]};	
						}
		md : coverpoint t3.up_down;
		ld : coverpoint t3.load;
		da : coverpoint t3.data_in { bins zero = {0};
					  bins one = {1};
					  bins two = {2};
					  bins three = {3};
					  bins four = {4};
					  bins five = {5};
					  bins six = {6};
					  bins seven = {7};
					  bins eight = {8};
				  	  bins nine = {9};
					  bins ten = {10};
					  bins eleven = {11};
					  bins tweleve = {12};
					  bins thirteen = {13}; 	}
	
	endgroup


	function new (	mailbox #(transaction) rm2sb,
			mailbox #(transaction) rdm2sb  );

		this.rm2sb = rm2sb;
		this.rdm2sb = rdm2sb;
		count_cov = new();
	
	endfunction

	
	virtual task check;
			$display("t1.count =%0d t2.count = %0d",t1.count,t2.count);

			if(t1.count == t2.count)
				begin
				$display("=======================");
				$display("        SUCCESS         ");
				$display("=======================");
				end
			
			else 
				begin
				$display("=========================");	
				$display("         FAILED          ");
				$display("=========================");
				end
	
			
			to_stop++;
			
			if(to_stop >= 5)
			->OVER;	
		

	endtask

	virtual task start;
		
		fork
			begin 
				forever
					begin
						rm2sb.get(t1);
						rdm2sb.get(t2);	
						t3 = new t1;
						count_cov.sample();
						t2.display("SCORE BOARD");
						$display("RESULTS AFTER COMPARISION");	
						check();
					end
			end
		join_none
		
	endtask
		
endclass


		


