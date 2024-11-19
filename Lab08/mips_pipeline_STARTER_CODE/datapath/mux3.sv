//--------------------------------------------------------------
// mux3.sv - parameterized 3-1 mux
// John Nestor May 2018
//--------------------------------------------------------------

module mux3 #(parameter WIDTH = 8)
             (input  logic [WIDTH-1:0] d0, d1, d2,
              input  logic [1:0]       s,
              output logic [WIDTH-1:0] y);

  always_comb begin
      case(s)
          2'd0 : y = d0;
          2'd1 : y = d1;
          2'd2 : y = d2;
          default : y = '0;
      endcase
  end

endmodule
