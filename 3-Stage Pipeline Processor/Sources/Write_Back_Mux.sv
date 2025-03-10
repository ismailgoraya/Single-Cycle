module Write_Back_Mux (
    input logic [1:0] wb_sel_w,
    input logic [31:0] ALU_result_w, rdata, PC_w,
    output logic [31:0] wdata 
);
    always_comb begin
         case (wb_sel_w)
            2'b00: wdata = PC_w + 4;
            2'b01: wdata = ALU_result_w;
            2'b10: wdata = rdata;
        endcase
    end
endmodule