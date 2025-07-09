				//transaction//

class transaction;

	rand logic reset;
	rand logic up_down;
	rand logic load;
	randc logic [3:0] data_in;
	
	logic [3:0] count;

	constraint c1 { reset dist { 0:=10 , 1:=30 };}	
	constraint c2 { load dist { 0:=90 , 1:=30 };}	
	constraint c3 { data_in inside {[0:13]};}
	constraint c4 { up_down dist { 0:=5 , 1:=5 };}
	
	function void display ( input string s);
		$display("\n===========================================");
		$display("-------  %s  ------",s);
		$display("===========================================\n");
		$display("	the reset = %0d", reset);
		$display("	the up_down  = %0d", up_down);
		$display("	the load  = %0d", load);
		$display("	the data_in  = %0d", data_in);
		$display("	the count  = %0d", count);
	
	endfunction

endclass

		
		


