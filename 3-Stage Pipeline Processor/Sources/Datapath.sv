module Datapath(
    input logic clk, rst
);
    logic [31:0] PC_f, PC_e, PC_w, PCplus4, sign_extended;
    logic [31:0] instruction_f, instruction_f_DFF, instruction_e, instruction_w, ALU_result_e, ALU_result_w;
    logic [31:0] rdata1_reg, rdata2_reg, rdata1, rdata2, rdata, wdata, wdata_dm;
    logic [31:0] sel_input_A, sel_input_B;
    logic [4:0] raddr1, raddr2, waddr;
    logic [6:0] opcode;
    logic [3:0] alu_op;
    logic [2:0] br_type;
    logic [1:0] wb_sel, wb_sel_w;
    logic reg_wr, rd_en, wr_en, br_taken, sel_A, sel_B;
    logic reg_wr_w, rd_en_w, wr_en_w, For_A, For_B, Flush;

    always_comb begin

        opcode = instruction_e[6:0];
        raddr1 = instruction_e[19:15];
        raddr2 = instruction_e[24:20];
        waddr = instruction_w[11:7];
        Flush = br_taken ? 1'b1 : 1'b0; 

        rdata1 = For_A ? wdata : rdata1_reg;
        rdata2 = For_B ? wdata : rdata2_reg;

        sel_input_A = sel_A ? rdata1 : PC_e;
        sel_input_B = sel_B ? sign_extended : rdata2;

        instruction_f = Flush ? 32'h00000013 : instruction_f_DFF;
        
    end

    // Instantiation
    DFF32bit dff_00 (clk, rst, PC_f, PC_e);
    DFF32bit dff_01 (clk, rst, instruction_f, instruction_e);
    DFF32bit dff_02 (clk, rst, PC_e, PC_w);
    DFF32bit dff_03 (clk, rst, ALU_result_e, ALU_result_w);
    DFF32bit dff_04 (clk, rst, rdata2, wdata_dm);
    DFF32bit dff_05 (clk, rst, instruction_e, instruction_w);

    PC pc_0 (clk, rst, br_taken, ALU_result_e, PCplus4, PC_f);
    Instruction_Memory inst_mem_0 (PC_f, instruction_f_DFF);
    Register_File reg_file_0 (clk, rst, reg_wr_w, raddr1, raddr2, waddr, wdata, rdata1_reg, rdata2_reg);
    ALU alu_0 (alu_op, sel_input_A, sel_input_B, ALU_result_e);
    Data_Memory data_mem_0 (clk, wr_en_w, rd_en_w, ALU_result_w, wdata_dm, rdata);
    Branch_Condition branch_condition_0 (br_type, rdata1, rdata2, br_taken);
    Forwarding_Unit forwarding_unit_0 ( reg_wr_w, instruction_e, instruction_w, For_A, For_B);
    Immediate_Generator immediate_generator_0 (instruction_e, sign_extended);
    Write_Back_Mux write_back_mux_0 (wb_sel_w, ALU_result_w, rdata, PC_w, wdata);
    Controller controller_0 (instruction_e, reg_wr, rd_en, wr_en, sel_A, sel_B, wb_sel, alu_op, br_type);
    Control_Unit control_unit_0 (clk, rst, reg_wr, wr_en, rd_en, wb_sel, reg_wr_w, wr_en_w, rd_en_w, wb_sel_w);

endmodule
