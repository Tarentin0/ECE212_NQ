module mux3 #(parameter WIDTH = 32)
             (input  logic [WIDTH-1:0] d0, d1, d2, d3,
              input  logic [1:0]       s, 
              output logic [WIDTH-1:0] y);

   always_comb
      case(s)
        2'b00: y = d0;
        2'b01: y = d1;
        2'b10: y = d2;
	default: y = '0;
      endcase
endmodule

