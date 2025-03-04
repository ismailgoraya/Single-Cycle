module Controller (
    input logic [31:0] instruction,
    output logic reg_wr, rd_en, wr_en, sel_A, sel_B,
    output logic [1:0] wb_sel,
    output logic [3:0] alu_op,
    output logic [2:0] br_type
);
    logic [6:0] opcode, func7;
    logic [2:0] func3;

    assign opcode = instruction[6:0];
    assign func3 = instruction[14:12];
    assign func7 = instruction[31:25];

    always_comb begin
        case (opcode)
            7'b0110011: begin   // R-Type instruction
                reg_wr = 1;
                rd_en = 0;
                wr_en = 0;
                sel_A = 1;
                sel_B = 0;
                wb_sel = 2'b01;
                br_type = 3'b000;

                case ({func7, func3})
                    {7'b0000000, 3'b000}: alu_op = 4'b0000; // Addition
                    {7'b0100000, 3'b000}: alu_op = 4'b0001; // Subtraction
                    {7'b0000000, 3'b001}: alu_op = 4'b0010; // Shift Left Logical
                    {7'b0000000, 3'b101}: alu_op = 4'b0011; // Shift Right Logical
                    {7'b0100000, 3'b101}: alu_op = 4'b0100; // Shift Right Arithmatic
                    {7'b0000000, 3'b010}: alu_op = 4'b0101; // Set Less Then
                    {7'b0000000, 3'b011}: alu_op = 4'b0110; // Set Less Then Unsigned
                    {7'b0000000, 3'b100}: alu_op = 4'b0111; // XOR
                    {7'b0000000, 3'b110}: alu_op = 4'b1000; // OR
                    {7'b0000000, 3'b111}: alu_op = 4'b1001; // AND
                    default: alu_op = 4'b0000;
                endcase
            end

            7'b0010011: begin   // I-Type
                reg_wr = 1;
                rd_en = 0;
                wr_en = 0;
                sel_A = 1;
                sel_B = 1;
                wb_sel = 2'b01;
                br_type = 3'b000;

                case (func3)
                    3'b000: alu_op = 4'b0000; // ADDI
                    3'b001: alu_op = 4'b0010; // SLLI
                    3'b101: alu_op = (func7 == 7'b0100000) ? 4'b0100 : 4'b0011; // SRAI or SRLI
                    3'b010: alu_op = 4'b0101; // SLTI
                    3'b011: alu_op = 4'b0110; // SLTIU
                    3'b100: alu_op = 4'b0111; // XORI
                    3'b110: alu_op = 4'b1000; // ORI
                    3'b111: alu_op = 4'b1001; // ANDI
                    default: alu_op = 4'b0000;
                endcase
            end

            7'b0000011: begin       // I-Type (Load)
            reg_wr = 1;
            rd_en = 1;
            wr_en = 0;
            sel_A = 1;
            sel_B = 1;
            wb_sel = 2'b10;
            br_type = 3'b000;
            alu_op = 4'b0000;
        end

        7'b0100011: begin       // S-Type 
            reg_wr = 0;
            rd_en = 0;
            wr_en = 1;
            sel_A = 1;
            sel_B = 1;
            wb_sel = 2'b01;
            br_type = 3'b000;
            alu_op = 4'b0000;
        end

        7'b1100011: begin       // B-Type   
            reg_wr = 0;
            rd_en = 0;
            wr_en = 0;
            sel_A = 0;
            sel_B = 1;
            wb_sel = 2'b01;
            alu_op = 4'b0000;

            case (func3)
                3'b000: br_type = 3'b001; // Branch Equal
                3'b001: br_type = 3'b010; // Branch Not Equal
                3'b100: br_type = 3'b011; // Branch Less Then
                3'b101: br_type = 3'b100; // Branch Greater or Equal
                3'b110: br_type = 3'b101; // Branch Less Then Unsigned
                3'b111: br_type = 3'b110; // Branch Greater or Equal Unsigned
            endcase
        
        end

        7'b0110111: begin // LUI
            reg_wr = 1;
            rd_en = 0;
            wr_en = 0;
            sel_A = 0;
            sel_B = 1;
            wb_sel = 2'b01;
            br_type = 3'b000;
            alu_op = 4'b1010;
        end

        7'b0010111: begin // AUIPC
            reg_wr = 1;
            rd_en = 0;
            wr_en = 0;
            sel_A = 0;
            sel_B = 1;
            wb_sel = 2'b01;
            br_type = 3'b000;
            alu_op = 4'b0000;
        end

        7'b1101111: begin // JAL
            reg_wr = 1;
            rd_en = 0;
            wr_en = 0;
            sel_A = 0;
            sel_B = 1;
            wb_sel = 2'b00;
            br_type = 3'b111;
            alu_op = 4'b0000;
        end

        7'b1100111: begin // JALR
            reg_wr = 1;
            rd_en = 0;
            wr_en = 0;
            sel_A = 1;
            sel_B = 1;
            wb_sel = 2'b00;
            br_type = 3'b111;
            alu_op = 4'b0000;
        end
        endcase
    end
endmodule
