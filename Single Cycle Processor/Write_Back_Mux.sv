module Write_Back_Mux (
    input logic [1:0] wb_sel,
    input logic [31:0] ALU_result, rdata, PC_out,
    output logic [31:0] wdata 
);
    always_comb begin
         case (wb_sel)
            2'b00: wdata = PC_out + 4;
            2'b01: wdata = ALU_result;
            2'b10: wdata = rdata;
        endcase
    end
endmodule
