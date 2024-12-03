module hazard(
    input logic regwrite_w, regwrite_m, memtoreg_m,
    input logic branch_d, pcsrc_d, jump_d, regwrite_e, memtoreg_e,
    input logic [4:0] writereg_e, writereg_w, writereg_m, rs_e, rt_e, rs_d, rt_d,
    output logic [1:0] forward_a_e, forward_b_e,
    output logic flush_e, forward_a_d, forward_b_d,
    output logic stall_f, stall_d
    );


    // forward to ID stage for branch
    logic branchstall;
    assign forward_a_d = (rs_d != 0) && (rs_d == writereg_m) && regwrite_m;
    assign forward_b_d = (rt_d != 0) && (rt_d == writereg_m) && regwrite_m;
    assign branchstall = (branch_d && regwrite_e &&
                         (writereg_e == rs_d || writereg_e == rt_d)) ||
                         (branch_d && memtoreg_m &&
                         (writereg_m == rs_d || writereg_m == rt_d) || jump_d);


    // forward to execute stage
    always_comb begin
        if ( (rs_e != 0) && (rs_e == writereg_m) && regwrite_m )
            forward_a_e = 2'b10;
        else if ( (rs_e != 0) && (rs_e == writereg_w) && regwrite_w )
            forward_a_e = 2'b01;
        else
            forward_a_e = 2'b00;
    end

    always_comb begin
        if ( (rt_e != 0) && (rt_e == writereg_m) && regwrite_m )
            forward_b_e = 2'b10;
        else if ( (rt_e != 0) && (rt_e == writereg_w) && regwrite_w )
            forward_b_e = 2'b01;
        else
            forward_b_e = 2'b00;
    end

    // stalling logic
    logic lwstall;
    assign lwstall = ((rs_d==rt_e) || (rt_d==rt_e)) && memtoreg_e;
    assign stall_f = lwstall || branchstall;
    assign stall_d = stall_f;
    assign flush_e = stall_f;
endmodule
