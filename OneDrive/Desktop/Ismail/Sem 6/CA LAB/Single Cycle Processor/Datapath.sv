module Datapath(
    input logic clk, rst
);
    logic [31:0] PC_out, sign_extended, instruction, ALU_result, rdata, rdata1, rdata2, wdata;
    logic [31:0] sel_input_A, sel_input_B;
    logic [4:0] raddr1, raddr2, waddr;
    logic [6:0] opcode;
    logic [3:0] alu_op;
    logic [2:0] br_type;
    logic [1:0] wb_sel;
    logic reg_wr, rd_en, wr_en, br_taken, sel_A, sel_B;

    always_comb begin 

        opcode = instruction[6:0];
        raddr1 = instruction[19:15];
        raddr2 = instruction[24:20];
        waddr = instruction[11:7];

        sel_input_A = sel_A ? rdata1 : PC_out;
        sel_input_B = sel_B ? sign_extended : rdata2;
        
    end
    
    PC pc_0(clk, rst, br_taken, ALU_result, PC_out);
    Instruction_Memory inst_mem_0(PC_out, instruction);
    Register_File reg_file_0(clk, reg_wr, raddr1, raddr2, waddr, wdata, rdata1, rdata2);
    ALU alu_0(alu_op, sel_input_A , sel_input_B, ALU_result);
    Data_Memory data_mem_0(clk, wr_en, rd_en, ALU_result, rdata2, rdata);
    Branch_Condition branch_condition_0(br_type, rdata1, rdata2, br_taken);
    Write_Back_Mux write_back_mux_0(wb_sel, ALU_result, rdata, PC_out, wdata);
    Immediate_Generator immediate_generator_0(instruction, sign_extended);
    Controller controller_0(instruction, reg_wr, rd_en, wr_en, sel_A, sel_B, wb_sel, alu_op, br_type);

endmodule