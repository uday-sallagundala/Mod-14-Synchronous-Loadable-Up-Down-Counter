module up_down_counter(
    input clock,
    input reset,  
    input load,
    input up_down,
    input [3:0] data_in,
    output reg [3:0] count
);
    
    always @(posedge clock) begin 
        if (reset) 
        begin           
          count <= 4'd0;
        end
      
        else if (load && data_in <= 4'd13)   
        begin  
          count <= data_in;
        end
      
        else if (up_down) 
      begin      
            if (count == 4'd13)   
                count <= 4'd0;
            else
                count <= count + 1;
      end
      
        else
      begin                  
            if (count == 4'd0)    
                count <= 4'd13;
            else
                count <= count - 1;
      end
    end
endmodule

